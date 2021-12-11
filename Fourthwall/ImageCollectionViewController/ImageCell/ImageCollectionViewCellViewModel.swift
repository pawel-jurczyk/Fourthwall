//
//  ImageCollectionViewCellViewModel.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation
import CoreGraphics

struct ImageCollectionViewCellViewModel {
    let itemWidthScaled: CGFloat
    let pictureId: String
    let picsumAPI: PicsumPhotosAPIProtocol.Type

    init(itemWidthScaled: CGFloat, pictureId: String, picsumAPI: PicsumPhotosAPIProtocol.Type = PicsumPhotosAPI.self) {
        self.itemWidthScaled = itemWidthScaled
        self.pictureId = pictureId
        self.picsumAPI = picsumAPI
    }

    var url: URL? {
        picsumAPI.urlForPictureWith(itemWidth: itemWidthScaled, itemHeight: nil, pictureId: pictureId)
    }
}
