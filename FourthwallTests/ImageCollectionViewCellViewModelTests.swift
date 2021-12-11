//
//  ImageCollectionViewCellViewModelTests.swift
//  FourthwallTests
//
//  Created by Pawel on 12/2/21.
//

import XCTest
@testable import Fourthwall

class ImageCollectionViewCellViewModelTests: XCTestCase {
    func testPictureListURL() throws {
        // Given
        let model = ImageCollectionViewCellViewModel(itemWidthScaled: 1234, pictureId: "someid", picsumAPI: MockPicsumPhotosAPI.self)
        // When
        let url = model.url
        // Then
        XCTAssertEqual(url?.absoluteString, "https://picsum.photos/1234?image=someid")
    }
}

class MockPicsumPhotosAPI: PicsumPhotosAPIProtocol {
    static func urlForPictureWith(itemWidth: CGFloat, itemHeight: CGFloat?, pictureId: String) -> URL? {
        URL(string: "https://picsum.photos/1234?image=someid")
    }

    static func urlForPictureList(page: Int) -> URL? {
        URL(string: "https://picsum.photos/")
    }
}
