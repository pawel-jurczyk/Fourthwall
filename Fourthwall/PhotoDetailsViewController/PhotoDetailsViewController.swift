//
//  PhotoDetailsViewController.swift
//  Fourthwall
//
//  Created by Pawel on 11/29/21.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {
    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.image = nil
        }
    }
    @IBOutlet var authorsName: UILabel! {
        didSet {
            authorsName.text = nil
        }
    }
    var viewModel: PhotoDetailsViewModel?

    override func updateViewConstraints() {
        super.updateViewConstraints()
        updateWithCurrentPicture()
    }

    private func updateWithCurrentPicture() {
        let size = imageView.scaledSize
        guard let url = viewModel?.pictureURL(itemWidth: size.width, itemHeight: size.height) else { return }
        imageView.af.setImage(withURL: url, completion: { [weak self] response in
            self?.imageDownloadResponse(response)
        })
    }

    private func imageDownloadResponse(_ response: AFIDataResponse<UIImage>) {
        activityIndicator.stopAnimating()
        guard response.response?.statusCode != 200,
              let error = response.error,
              let errorDescription = error.errorDescription else {
                  authorsName.text = viewModel?.author
                  return
              }
        authorsName.text = "Error loading image: \(errorDescription)"
    }

    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        share()
    }

    private func share() {
        guard let image = imageView.image,
              let author = viewModel?.author else { return }
        let viewController = UIActivityViewController(activityItems: [author, image], applicationActivities: [])
        present(viewController, animated: true, completion: nil)
    }
}
