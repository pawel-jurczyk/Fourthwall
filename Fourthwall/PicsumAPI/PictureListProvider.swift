//
//  PictureListProvider.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation

class PictureListProvider {

    private var pictureJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private var dataTask: URLSessionDataTask?

    private let defaultSession = URLSession(configuration: .default)

    private var completion: (([Picture]) -> Void)?

    func getList(completion: @escaping (([Picture]) -> Void)) {
        dataTask?.cancel()

        guard let url = PicsumPhotosAPI.urlForPictureList() else { return }

        self.completion = completion

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            self?.handleResponse(data: data, response: response, error: error)
        }
        dataTask?.resume()
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        defer {
            dataTask = nil
        }
        if let error = error {
            print("DataTask error: " + error.localizedDescription + "\n")
        } else if let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 {

            guard let pictures = try? pictureJSONDecoder.decode([Picture].self, from: data) else { return }

            DispatchQueue.main.async { [weak self] in
                print(pictures)
                self?.completion?(pictures)
            }
        }
    }
}
