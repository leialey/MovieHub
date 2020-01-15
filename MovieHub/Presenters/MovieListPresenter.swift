//
//  MovieListPresenter.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieListPresenter {
    private var movies = [Movie]() // list of movies
    weak private var view: MovieView?
    private var persistanceManager = PersistanceManager() // to mark favourite movies
    private var apiManager = ApiManager()
    var rowsToDisplay: Int = 1 //MovieView's table will display total movies + 1 to show activity indicator in the last row if not all movies are fetched from the API yet
    
    // MARK: - Public
    init(_ view: MovieView) {
        self.view = view
        NetworkManager.shared.onConnected = { [weak self] in
            //Once connection restored, load all requested movies
            if let movieIndex = self?.apiManager.currentPage.movieIndex {
                self?.fetchMovies(movieIndex)
            }
        }
        NetworkManager.shared.startMonitoring()
        do {
            try persistanceManager.fetchFavourites()
        } catch {
            self.view?.showStatus(TaskError.errorDB.errorDescription)
        }
    }
    
    func requestDetails(_ cell: MovieCell, _ row: Int) {
        guard let movie = self.movies[safe: row] else { return }
        let presenter = MovieDetailsPresenter(movie)
        presenter.requestDetails(row)
        self.view?.showDetails(presenter)
    }
    
    func configure(_ cell: MovieCell, _ row: Int) {
        var movie = movies[safe: row]
        if movie != nil {
            movie!.isFavourite = persistanceManager.isFavourite(movie!)
            cell.updateFavorites = { [weak self] in
                self?.updateFavourite(for: row)
            }
        }
        cell.show(movie, row)
    }
    
    func loadDataIfNeeded(_ row: Int) {
        fetchMovies(row)
    }
    
    // MARK: - Private
    
    private func fetchMovies(_ row: Int) {
        //No parallel fetching or fetching same movies
        
        if movies[safe: row] != nil || apiManager.getStatus() == .inProgress {
            return
        }
        
        apiManager.startFetching(row)
        
        //Start fetching
        apiManager.sendRequest(apiName: "discover", movieID: nil) { (result) in
            switch result {
            case .success(let jsonString):
                let json = JSON(jsonString)
                self.parseJSONMovies(json)
            case .failure(let error):
                self.view?.showStatus(error.errorDescription)
            }
        }
    }
    
    //Беру id, заголовок, краткое описание, есть ли видео - хотя этот флаг не всегда соответствует действительности, имя файла постера
    private func parseJSONMovies(_ json: JSON) {
        movies.append(contentsOf: json["results"].arrayValue.map{Movie(id: $0["id"].intValue, title: $0["title"].stringValue, overview: $0["overview"].stringValue, hasVideo: $0["video"].boolValue, imageURL: APIImage(fileName: $0["poster_path"].string).secureURL)})
        apiManager.currentPage.movieIndex = movies.count - 1
        
        let totalCount = json["total_results"].intValue
        if totalCount <= movies.count { //All movies fetched - no need to monitor network anymore
            NetworkManager.shared.stopMonitoring()
            rowsToDisplay = totalCount
        } else {
            rowsToDisplay = movies.count + 1
        }
        view?.reloadData()
    }
    
    
    private func updateFavourite(for row: Int) {
        guard let movie = movies[safe: row] else { return }
        do {
            try persistanceManager.updateFavourite(movie: movie)
        } catch {
            self.view?.showStatus(TaskError.errorDB.errorDescription)
        }
        self.view?.reloadData()
    }
}
