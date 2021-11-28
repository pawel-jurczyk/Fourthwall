//
//  ImageCollectionViewCell.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!

    override func prepareForReuse() {
        imageView.af.cancelImageRequest()
        imageView.image = nil
    }

    func configure(viewModel: ImageCollectionViewCellViewModel) {
        guard let url = viewModel.url else { return }
        imageView.af.setImage(withURL: url, cacheKey: viewModel.pictureId)
    }
}
