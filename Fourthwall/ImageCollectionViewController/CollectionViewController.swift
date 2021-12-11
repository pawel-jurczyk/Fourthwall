//
//  ViewController.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Alamofire
import AlamofireImage
import UIKit

class CollectionViewController: UICollectionViewController {

    private var model = CollectionViewControllerModel()

    private lazy var navigationBarActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setLeftBarButton(barButton, animated: true)
        return activityIndicator
    }()

    private var itemWidthScaled: CGFloat {
        UIScreen.main.scale * layout.itemSize.width
    }

    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Lorem Picsum"

        configureView()
        downloadPicturesPage()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.itemSize =  model.itemSize(with: size)
    }

    private func downloadPicturesPage() {
        navigationBarActivityIndicator.startAnimating()
        model.downloadPicturesPage { [weak self] result in
            self?.navigationBarActivityIndicator.stopAnimating()
            switch result {
            case .success(let indexPaths):
                self?.collectionView.insertItems(at: indexPaths)
            case .failure:
                self?.title = "Downloading error"
            }
        }
    }

    private func configureView() {
        collectionView.collectionViewLayout = layout
        layout.itemSize = model.itemSize(with: view.bounds.size)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PhotoDetails",
              let detailViewController = segue.destination as? PhotoDetailsViewController,
              let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let picture = model.pictures[indexPath.row]
        detailViewController.viewModel = .init(author: picture.author, pictureId: picture.id, picsumAPI: PicsumPhotosAPI.self)
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath)
        let picture = model.pictures[indexPath.row]

        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.configure(viewModel: .init(itemWidthScaled: itemWidthScaled,
                                                 pictureId: picture.id,
                                                 picsumAPI: PicsumPhotosAPI.self))
        }

        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == model.pictures.count - 1 {
            downloadPicturesPage()
        }
    }
}
