//
//  ImageCollectionViewCellViewModel.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation

struct ImageCollectionViewCellViewModel {
    let itemWidthScaled: Int
    let pictureId: String

    var url: URL? {
        PicsumPhotosAPI.urlForPictureWith(itemWidth: itemWidthScaled, pictureId: pictureId)
    }
}
