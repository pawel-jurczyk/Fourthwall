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

    private var pictures: [Picture] = []
    private var pictureListProvider = PictureProvider()

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

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picsum Photos"

        configureView()
        downloadPicturesPage()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureItemSize(with: size)
    }

    private func downloadPicturesPage() {
        navigationBarActivityIndicator.startAnimating()
        pictureListProvider.getList { [weak self] result in
            self?.navigationBarActivityIndicator.stopAnimating()
            switch result {
            case .success(let pictures):
                self?.updateCollectionView(with: pictures)
            case .failure:
                self?.title = "Downloading error"
            }
        }
    }

    private func updateCollectionView(with pictures: [Picture]) {
        let indexPaths = indexPathsToInsert(newCount: pictures.count)

        self.pictures += pictures

        collectionView.insertItems(at: indexPaths)
    }

    private func indexPathsToInsert(newCount: Int) -> [IndexPath] {
        let startIndex = pictures.count
        let endIndex = startIndex + newCount - 1
        let indexes = startIndex...endIndex
        return indexes.map {
            .init(item: $0, section: 0)
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
        detailViewController.picture = pictures[indexPath.row]
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath)
        let picture = pictures[indexPath.row]

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
        if indexPath.row == pictures.count - 1 {
            downloadPicturesPage()
        }
    }
}
