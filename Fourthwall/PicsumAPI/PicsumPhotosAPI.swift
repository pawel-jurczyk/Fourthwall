//
//  PicsumPhotosAPI.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation
import CoreGraphics

protocol PicsumPhotosAPIProtocol {
    static func urlForPictureWith(itemWidth: CGFloat, itemHeight: CGFloat?, pictureId: String) -> URL?
    static func urlForPictureList(page: Int) -> URL?
}

struct PicsumPhotosAPI: PicsumPhotosAPIProtocol {

    private static let api: String = "picsum.photos"

    private static var commonComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = api
        return components
    }

    static func urlForPictureWith(itemWidth: CGFloat, itemHeight: CGFloat? = nil, pictureId: String) -> URL? {
        var components = commonComponents
        components.path = "/\(Int(itemWidth))"
        if let height = itemHeight {
            components.path += "/\(Int(height))"
        }
        components.queryItems = [.init(name: "image", value: pictureId)]
        return components.url
    }

    static func urlForPictureList(page: Int) -> URL? {
        var components = commonComponents
        components.path = "/v2/list"
        components.queryItems = [.init(name: "page", value: "\(page)")]
        return components.url
    }
}
