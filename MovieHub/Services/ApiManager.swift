//
//  ApiManager.swift
//  MovieHub
//
//  Created by Leialey on 14.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

class ApiManager {
    var currentPage = ApiPage() // current requested page from API
    private var fetchStatus: FetchStatus = .initial
    
    //MARK: - Public methods
    func getStatus() -> FetchStatus {
        return fetchStatus
    }
    
    func startFetching(_ index: Int) {
        if index > (currentPage.movieIndex ?? -1) {  //Requested index is greater than previous - request new page
            currentPage.pageIndex += 1
        }
        currentPage.movieIndex = index
        fetchStatus = .inProgress
    }
    
     func sendRequest(apiName: String, movieID: Int?, completionHandler: @escaping (Swift.Result<Any, TaskError>) -> Void) {
        let apiRequest = constructRequest(apiName, movieID)
        //Start fetching
        //Validate - response code 200..<300
        apiRequest.getDataRequest().validate().responseJSON { response in
            switch response.result {
            case .success(let jsonString):
                completionHandler(.success(jsonString))
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    completionHandler(.failure(.notConnectedToInternet))
                } else {
                    completionHandler(.failure(.errorAPI))
                }
            }
            self.fetchStatus = .initial
        }
    }
    //MARK: - Private methods
    private func constructRequest(_ name: String, _ movieID: Int?) -> ApiRequest {
        switch name {
        case "discover":
            return ApiRequest(page: currentPage.pageIndex)
        case "movie":
            guard let id = movieID else { fatalError("Movie ID not provided") }
            return ApiRequest(movieID: id)
        default:
            fatalError("API name not expected")
        }
    }
}
