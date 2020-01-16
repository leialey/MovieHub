//
//  ApiRequest.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Alamofire

struct ApiRequest {
    private var baseURL: String
    private let language = Locale.current.languageCode ?? "en" // iso 639-1 code - по-хорошему надо добавить локализацию и всего остального
    private let sort_by = "popularity.desc"
    private let include_video = true
    static private var apiKey: String = ""
    private var params: Parameters?
    
    init(page: Int) {
        baseURL = "https://api.themoviedb.org/3/discover/movie"
        getAPIkey()
        params = [
            "page": page,
            "sort_by": sort_by,
            "api_key": ApiRequest.apiKey,
            "language": language,
            "include_video": include_video
        ]
        
    }
    
    init(movieID: Int) {
        baseURL = "https://api.themoviedb.org/3/movie/\(movieID)/videos"
        getAPIkey()
        params = [
            "api_key": ApiRequest.apiKey,
            "language": language
        ]
    }
    
    private func getAPIkey() {
        if ApiRequest.apiKey.isEmpty {
            guard let path = Bundle.main.path(forResource: "apiKeys", ofType: "plist"),
                let key = NSDictionary(contentsOfFile: path) as? [String : String],
                let apiKey = key["apiKey"]
                else { fatalError("apiKey not found or in a wrong format") }
            ApiRequest.apiKey = apiKey
        }
    }
    
    func getDataRequest() -> DataRequest {
        return Alamofire.request(self.baseURL, method: .get, parameters: self.params)
    }
}



