//
//  PresenterProtocols.swift
//  MovieHub
//
//  Created by Leialey on 19.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation


protocol MovieListPresenting {
    var rowsToDisplay: Int { get }
    init(_ view: MovieView)
    func requestMovieDetails(_ cell: MovieCell, _ row: Int)
    func configure(_ cell: MovieCell, _ row: Int)
    func loadDataIfNeeded(_ row: Int)
}

protocol MovieDetailsPresenting {
    var view: MovieDetailsView? { get set }
    init(_ movie: Movie)
    func getMovie() -> Movie
    func requestDetails(_ row: Int)
}
