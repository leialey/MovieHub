//
//  ApiRequest.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Alamofire

struct ApiRequest: ApiRequestConstructor {
    private var baseURL: String
    private let language = Locale.current.languageCode ?? "en" // iso 639-1 code - по-хорошему надо добавить локализацию и всего остального
    static private var apiKey: String = ""
    private var params: Parameters?
    typealias T = DataRequest
    
    //MARK: - Public methods
    init(_ apiName: ApiName, _ parameter: Any?){
        switch apiName {
        case .discover:
            guard let page = parameter as? Int else { fatalError("Page wrong format") }
            baseURL = "https://api.themoviedb.org/3/discover/movie"
            getAPIkey()
            params = [
                "page": page,
                "sort_by": "popularity.desc",
                "api_key": ApiRequest.apiKey,
                "language": language,
                "include_video": true
            ]
        case .movie:
            guard let movieID = parameter as? Int else { fatalError("Movie ID wrong format") }
            baseURL = "https://api.themoviedb.org/3/movie/\(movieID)/videos"
            getAPIkey()
            params = [
                "api_key": ApiRequest.apiKey,
                "language": language
            ]
        }
    }
    
    func getDataRequest() -> T {
        return Alamofire.request(self.baseURL, method: .get, parameters: self.params)
    }
    
    //MARK: - Private methods
    private func getAPIkey() {
        if ApiRequest.apiKey.isEmpty {
            guard let path = Bundle.main.path(forResource: "apiKeys", ofType: "plist"),
                let key = NSDictionary(contentsOfFile: path) as? [String : String],
                let apiKey = key["apiKey"]
                else { fatalError("apiKey not found or in a wrong format") }
            ApiRequest.apiKey = apiKey
        }
    }
    
    
}



