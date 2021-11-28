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

    private var itemWidth: CGFloat {
        view.bounds.size.width / 2
    }

    private var itemWidthScaled: Int {
        Int(UIScreen.main.scale * itemWidth)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()

        pictureListProvider.getList { [weak self] pictures in
            self?.pictures = pictures
            self?.collectionView.reloadData()
        }
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
