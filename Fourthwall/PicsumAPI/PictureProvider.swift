//
//  PictureListProvider.swift
//  Fourthwall
//
//  Created by Pawel on 11/28/21.
//

import Foundation

class PictureProvider {

    enum PictureProviderError: Error {
        case networkError
        case parsingError
    }

    private var pictureJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private var dataTask: URLSessionDataTask?

    private let defaultSession = URLSession(configuration: .default)

    private var listCompletion: ((Result<[Picture], PictureProviderError>) -> Void)?

    private var page = 1

    private var currentPage: Int {
        get {
            defer {
                page += 1
            }
            return page
        }
    }

    func getList(completion: @escaping ((Result<[Picture], PictureProviderError>) -> Void)) {
        dataTask?.cancel()

        guard let url = PicsumPhotosAPI.urlForPictureList(page: currentPage) else { return }

        self.listCompletion = completion

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            self?.handleResponse(data: data, response: response, error: error)
        }
        dataTask?.resume()
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        defer {
            dataTask = nil
        }
        guard error == nil,
              let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 else  {
                  callCompletetion(result: .failure(.networkError))
                  return
              }

        guard let pictures = try? pictureJSONDecoder.decode([Picture].self, from: data) else {
            callCompletetion(result: .failure(.parsingError))
            return
        }
        callCompletetion(result: .success(pictures))
    }

    func callCompletetion(result: Result<[Picture], PictureProviderError>) {
        DispatchQueue.main.async { [weak self] in
            self?.listCompletion?(result)
            self?.listCompletion = nil
        }
    }
}
