//
//  MovieTableViewCell+Extensions.swift
//  MovieHub
//
//  Created by Leialey on 14.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import AlamofireImage

extension MovieTableViewCell: MovieCell {
    
    func show(_ movie: Movie?, _ row: Int) {
        let cellElements = [movieTitle, movieImage, isFavourite]
        if let movie = movie {
            cellElements.forEach({$0?.isHidden = false})
            loadingIndicator.isHidden = true
            let imagePlaceholder = UIImage(named: placeholderImage)
            if let imageURL = movie.imageURL {
                movieImage?.af_setImage(withURL: imageURL, placeholderImage: imagePlaceholder, imageTransition: .crossDissolve(0.2))
            } else {
                movieImage.image = imagePlaceholder
            }
            movieTitle.text = "\(row + 1).\t\(movie.title)"
            let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
            let imageName = movie.isFavourite ?? false ? "star.fill" : "star"
            let image = UIImage(systemName: imageName, withConfiguration: configuration)
            isFavourite.setImage(image, for: .normal)
        } else {
            cellElements.forEach({$0?.isHidden = true})
            self.loadingIndicator.isHidden = false
        }
    }
}
