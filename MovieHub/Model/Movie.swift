//
//  Movie.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

struct Movie {
    var id: Int
    var title: String
    var overview: String
    var hasVideo: Bool
    var imageURL: URL?
    var videoURL: URL?
    var isFavourite: Bool?
}
