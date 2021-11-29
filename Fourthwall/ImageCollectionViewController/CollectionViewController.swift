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
    private var pictureListProvider = PictureListProvider()

    private lazy var navigationBarActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setLeftBarButton(barButton, animated: true)
        return activityIndicator
    }()

    private var itemWidth: CGFloat {
        view.bounds.size.width / 2
    }

    private var itemWidthScaled: Int {
        Int(UIScreen.main.scale * itemWidth)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        downloadPicturesPage()
    }

    private func downloadPicturesPage() {
        navigationBarActivityIndicator.startAnimating()
        pictureListProvider.getList { [weak self] pictures in
            self?.updateCollectionView(with: pictures)
        }
    }

    private func updateCollectionView(with pictures: [Picture]) {
        navigationBarActivityIndicator.stopAnimating()
        self.pictures = pictures
        collectionView.reloadData()
    }

    private func configureView() {
        collectionView.collectionViewLayout = collectionViewFlowLayout()
    }

    private func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
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

}
