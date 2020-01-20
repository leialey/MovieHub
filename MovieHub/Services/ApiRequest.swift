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
    private var apiKey: String = AppSettings.shared.string(key: "apiKey")
    private var params: Parameters?
    typealias T = DataRequest
    
    //MARK: - Public methods
    init(_ apiName: ApiName, _ parameter: Any?){
        switch apiName {
        case .discover:
            guard let page = parameter as? Int else { fatalError("Page wrong format") }
            baseURL = "https://api.themoviedb.org/3/discover/movie"
            params = [
                "page": page,
                "sort_by": "popularity.desc",
                "api_key": apiKey,
                "language": language,
                "include_video": true
            ]
        case .movie:
            guard let movieID = parameter as? Int else { fatalError("Movie ID wrong format") }
            baseURL = "https://api.themoviedb.org/3/movie/\(movieID)/videos"
            params = [
                "api_key": apiKey,
                "language": language
            ]
        }
    }
    
    func getDataRequest() -> T {
        return Alamofire.request(self.baseURL, method: .get, parameters: self.params)
    }
}



