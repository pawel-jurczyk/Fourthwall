//
//  PicsumPhotosAPI.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation

struct PicsumPhotosAPI {

    private static let api: String = "picsum.photos"

    private static var commonComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = api
        return components
    }

    static func urlForPictureWith(itemWidth: Int, pictureId: String) -> URL? {
        var components = commonComponents
        components.path = "/\(itemWidth)"
        components.queryItems = [.init(name: "image", value: pictureId)]
        return components.url
    }

    static func urlForPictureList() -> URL? {
        var components = commonComponents
        components.path = "/v2/list"
        return components.url
    }
}
