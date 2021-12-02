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

    private var itemWidthScaled: Int {
        Int(UIScreen.main.scale * layout.itemSize.width)
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
        configureItemSize(with: size)
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
        configureItemSize(with: view.bounds.size)
    }

    private func configureItemSize(with size: CGSize) {
        let orientationVertical = size.height > size.width
        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        let itemWidth: CGFloat
        switch (orientationVertical, isPad) {
        case (true, true), (false, false):
            itemWidth = size.width / 4
        case (true, false):
            itemWidth = size.width / 2
        case (false, true):
            itemWidth = size.width / 6
        }
        layout.itemSize = .init(width: itemWidth, height: itemWidth)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PhotoDetails",
              let detailViewController = segue.destination as? PhotoDetailsViewController,
              let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        detailViewController.picture = model.pictures[indexPath.row]
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
                                                 pictureId: picture.id))
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
