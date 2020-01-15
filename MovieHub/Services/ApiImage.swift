//
//  ApiImage.swift
//  MovieHub
//
//  Created by Leialey on 14.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

struct APIImage {
    private let fileConfiguration = "https://image.tmdb.org/t/p/w92" // константа для упрощения задачи, но в идеале TMDB рекомендует делать запрос API configuration раз в несколько дней
    var secureURL: URL?
    
    init(fileName: String?) {
        //filename будет в формате /xxxxxx.jpg
        if let fileName = fileName {
        self.secureURL = URL(string: fileConfiguration + fileName)
        }
    }
}
