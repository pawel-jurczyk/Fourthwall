//
//  PicsumPhotosAPITests.swift
//  FourthwallTests
//
//  Created by Pawel on 11/30/21.
//

import XCTest
@testable import Fourthwall

class PicsumPhotosAPITests: XCTestCase {

    func testPictureListURL() throws {
        // Given
        let page = 2
        // When
        let url = PicsumPhotosAPI.urlForPictureList(page: page)
        // Then
        XCTAssertEqual(url?.absoluteString, "https://picsum.photos/v2/list?page=\(page)")
    }

    func testPictureURLWithHeight() throws {
        // Given
        let itemWidth = 123
        let itemHeight = 234
        let pictureId = "someid"
        // When
        let url = PicsumPhotosAPI.urlForPictureWith(itemWidth: CGFloat(itemWidth), itemHeight: CGFloat(itemHeight), pictureId: pictureId)
        // Then
        XCTAssertEqual(url?.absoluteString, "https://picsum.photos/\(itemWidth)/\(itemHeight)?image=\(pictureId)")
    }

    func testPictureURLWithoutHeight() throws {
        // Given
        let itemWidth = 123
        let pictureId = "someid"
        // When
        let url = PicsumPhotosAPI.urlForPictureWith(itemWidth: CGFloat(itemWidth), pictureId: pictureId)
        // Then
        XCTAssertEqual(url?.absoluteString, "https://picsum.photos/\(itemWidth)?image=\(pictureId)")
    }
}
