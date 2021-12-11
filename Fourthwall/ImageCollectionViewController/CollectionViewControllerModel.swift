//
//  CollectionViewControllerModel.swift
//  Fourthwall
//
//  Created by Pawel on 12/2/21.
//

import Foundation
import UIKit

class CollectionViewControllerModel {
    private struct NumberOfColumns {
        static let verticalPad: CGFloat = 4
        static let horizontalPad: CGFloat = 6
        static let verticaliPhone: CGFloat = 2
        static let horizontaliPhone: CGFloat = 4

        static func columns(size: CGSize) -> CGFloat {
            let orientationVertical = size.height > size.width
            let isPad = UIDevice.current.userInterfaceIdiom == .pad
            switch (orientationVertical, isPad) {
            case (true, true):
                return verticalPad
            case (false, false):
                return horizontaliPhone
            case (true, false):
                return verticaliPhone
            case (false, true):
                return horizontalPad
            }
        }
    }

    var pictures: [Picture] = []
    private var pictureListProvider: PictureProviderProtocol

    init(pictureProvider: PictureProviderProtocol = PictureProvider()) {
        self.pictureListProvider = pictureProvider
    }

    func itemSize(with size: CGSize) -> CGSize {
        let itemWidth = size.width / NumberOfColumns.columns(size: size)
        return .init(width: itemWidth, height: itemWidth)
    }

    func downloadPicturesPage(completion: @escaping ((Result<[IndexPath], PictureProviderError>) -> Void)) {
        pictureListProvider.getList { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let pictures):
                    let indexes = strongSelf.indexPathsToInsert(newCount: pictures.count)
                    strongSelf.pictures += pictures
                    completion(.success(indexes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func indexPathsToInsert(newCount: Int) -> [IndexPath] {
        let startIndex = pictures.count
        let endIndex = startIndex + newCount - 1
        let indexes = startIndex...endIndex
        return indexes.map {
            .init(item: $0, section: 0)
        }
    }
}
