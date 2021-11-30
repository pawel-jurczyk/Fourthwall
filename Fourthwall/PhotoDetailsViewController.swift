//
//  PhotoDetailsViewController.swift
//  Fourthwall
//
//  Created by Pawel on 11/29/21.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var authorsName: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var picture: Picture?

    private var itemWidthScaled: Int {
        Int(UIScreen.main.scale * imageView.bounds.width)
    }

    private var itemHeightScaled: Int {
        Int(UIScreen.main.scale * imageView.bounds.height)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWithCurrentPicture()
    }

    func updateWithCurrentPicture() {
        authorsName.text = picture?.author

        guard let pictureId = picture?.id else { return }

        guard let url = PicsumPhotosAPI.urlForPictureWith(itemWidth: itemWidthScaled, itemHeight: itemHeightScaled, pictureId: pictureId) else { return }
        imageView.af.setImage(withURL: url, completion: { [weak self] response in
            self?.activityIndicator.stopAnimating()
            guard response.error == nil else {
                self?.authorsName.text = "Error loading image"
                return
            }
        })
    }

    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        share()
    }

    private func share() {
        guard let image = imageView.image,
              let text = authorsName.text else { return }
        let vc = UIActivityViewController(activityItems: [text, image], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
}
