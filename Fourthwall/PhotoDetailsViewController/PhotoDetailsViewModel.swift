//
//  PhotoDetailsViewModel.swift
//  Fourthwall
//
//  Created by Pawel on 12/11/21.
//

import Foundation
import CoreGraphics

struct PhotoDetailsViewModel {
    let author: String
    let pictureId: String
    let picsumAPI: PicsumPhotosAPIProtocol.Type

    init(author: String, pictureId: String, picsumAPI: PicsumPhotosAPIProtocol.Type) {
        self.author = author
        self.pictureId = pictureId
        self.picsumAPI = picsumAPI
    }

    func pictureURL(itemWidth: CGFloat, itemHeight: CGFloat) -> URL? {
        picsumAPI.urlForPictureWith(itemWidth: itemWidth, itemHeight: itemHeight, pictureId: pictureId)
    }
}
