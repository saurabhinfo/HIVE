//
//  NetworkManager.swift
//  HIVE
//
//  Created by Saurabh Sharma on 03/01/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

    private init() {}

    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            completion(.success(data))
        }.resume()
    }
}

