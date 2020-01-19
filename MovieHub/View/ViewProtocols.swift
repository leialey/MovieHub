//
//  Protocols.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

protocol MovieView: class {
    func reloadData()
    func showStatus(_ statusMessage: String?)
    func showDetails(_ presenter: MovieDetailsPresenting)
}

protocol MovieCell: MovieTableViewCell {
    func show(_ movie: Movie?, _ row: Int)
    var updateFavorites: (()->())? { get set }
}

protocol MovieDetailsView: class {
    func reloadData()
    func showStatus(_ statusMessage: String?)
    var isAnimating: Bool { get set }
}

