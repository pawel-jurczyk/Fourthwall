//
//  CollectionViewControllerModel.swift
//  Fourthwall
//
//  Created by Pawel on 12/2/21.
//

import Foundation

class CollectionViewControllerModel {
    var pictures: [Picture] = []
    private var pictureListProvider = PictureProvider()

    func downloadPicturesPage(completion: @escaping ((Result<[IndexPath], PictureProvider.PictureProviderError>) -> Void)) {
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
