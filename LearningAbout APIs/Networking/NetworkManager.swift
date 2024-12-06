//
//  NetworkManager.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/3/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession
    private init() {
        session = URLSession(configuration: .default)
    }

    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.networkError))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }

    func fetchData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.networkError))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}


