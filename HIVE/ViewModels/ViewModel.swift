//
//  ViewModel.swift
//  HIVE
//
//  Created by Saurabh Sharma on 03/01/24.
//

import Foundation

// Protocol defining the interface for the network manager
protocol NetworkManaging {
    func fetchData(withQuery query: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class MainViewModel {
    // Dependency injection using the network manager protocol
    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager.shared as! NetworkManaging) {
        self.networkManager = networkManager
    }

    func fetchData(withQuery query: String, completion: @escaping (Result<Data, Error>) -> Void) {
        networkManager.fetchData(withQuery: query, completion: completion)
    }
}
