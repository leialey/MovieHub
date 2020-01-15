//
//  MovieTableViewCell.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var isFavourite: UIButton!
    
    let placeholderImage = "themoviedb"
    var updateFavorites: (()->())?
    
    
    @IBAction func updateFavorites(_ sender: UIButton) {
        self.updateFavorites?()
    }
    
}


