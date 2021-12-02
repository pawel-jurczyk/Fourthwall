//
//  Picture.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation

struct Picture: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
