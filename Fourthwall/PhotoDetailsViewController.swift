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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWithCurrentPicture()
    }

    func updateWithCurrentPicture() {
        authorsName.text = picture?.author

        guard let pictureId = picture?.id else { return }
        let itemWidth = Int(UIScreen.main.scale * imageView.bounds.width)
        let itemHeight = Int(UIScreen.main.scale * imageView.bounds.height)
        guard let url = PicsumPhotosAPI.urlForPictureWith(itemWidth: itemWidth, itemHeight: itemHeight, pictureId: pictureId) else { return }
        imageView.af.setImage(withURL: url, completion: { [weak self] _ in
            self?.activityIndicator.stopAnimating()
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
