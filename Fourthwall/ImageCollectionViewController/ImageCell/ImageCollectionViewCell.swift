//
//  ImageCollectionViewCell.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        imageView.af.cancelImageRequest()
        imageView.image = nil
        activityIndicator.startAnimating()
    }

    func configure(viewModel: ImageCollectionViewCellViewModel) {
        guard let url = viewModel.url else { return }
        imageView.af.setImage(withURL: url,
                              cacheKey: viewModel.pictureId,
                              completion: { [weak self] _ in
            self?.activityIndicator.stopAnimating()
        })
    }
}
