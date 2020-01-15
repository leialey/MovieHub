//
//  MovieDetailsPresenter.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieDetailsPresenter {
    weak var view: MovieDetailsView?
    private var movie: Movie
    private let apiManager = ApiManager()
    private let youtubeURL = "https://www.youtube.com/embed/"
    private let providerName = "YouTube"

    // MARK: - Public
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    func getMovie() -> Movie {
        return self.movie
    }
    
    func requestDetails(_ row: Int) {
        self.view?.isAnimating = true
        apiManager.sendRequest(apiName: "movie", movieID: self.movie.id) { (result) in
            switch result {
            case .success(let jsonString):
                let json = JSON(jsonString)
                if let url = self.parseJSONVideo(json) {
                    self.movie.videoURL = url
                    self.view?.reloadData()
                } else {
                    self.view?.showStatus(TaskError.errorParsing.errorDescription)
                    self.view?.isAnimating = false
                }
            case .failure(let error):
                self.view?.showStatus(error.errorDescription)
                self.view?.isAnimating = false
            }            
        }
    }

    // MARK: - Private
    private func parseJSONVideo(_ json: JSON) -> URL? {
        
        //Результат содержит ключи различных видео: трейлеры, клипы, тизеры и др. Поскольку в требованиях не специфицировано, беру первый по списку
        //Также недавно помимо Ютуб стали добавлять Вимео - для простоты я беру только Ютуб

        if let videoKey = json["results"][0]["key"].string, let videoProvider = json["results"][0]["site"].string, videoProvider == providerName {
            return URL(string: youtubeURL+videoKey)
        }
            return nil
    }

}
