//
//  ServiceProtocols.swift
//  MovieHub
//
//  Created by Leialey on 19.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

protocol ApiRequestConstructor {
    associatedtype T
    init(_ apiName: ApiName, _ parameter: Any?)
    func getDataRequest() -> T
}

protocol ApiImageConstructor {
    var secureURL: URL? { get }
    init(fileName: String?)
}

protocol ApiManagement {
    var currentPage: ApiPage { get set }
    func getStatus() -> FetchStatus
    func startFetching(_ index: Int)
    func sendRequest(apiName: ApiName, parameter: Any?, completionHandler: @escaping (Swift.Result<Any, TaskError>) -> Void)
}

protocol PersistanceManagement {
    func fetchFavourites() throws
    func updateFavourite(movie: Movie) throws
    func isFavourite(_ movie: Movie) -> Bool
}

protocol NetworkManagerDelegate {
    func onConnected() 
}


