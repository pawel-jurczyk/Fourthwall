//
//  PictureListProvider.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation

class PictureListProvider {
    private var dataTask: URLSessionDataTask?

    private let defaultSession = URLSession(configuration: .default)

    func getList(completion: @escaping (([Picture]) -> Void)) {
        dataTask?.cancel()

        guard let url = PicsumPhotosAPI.urlForPictureList() else { return }

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let pictures = try? decoder.decode([Picture].self, from: data) else { return }

                DispatchQueue.main.async {
                    print(pictures)
                    completion(pictures)
                }
            }
        }
        dataTask?.resume()
    }
}
