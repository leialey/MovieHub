//
//  MovieDetailsViewController.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailsViewController: UIViewController {
    var presenter: MovieDetailsPresenting?
    var isAnimating: Bool = true  {
        didSet {
            isAnimating ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        }
    }
    @IBOutlet weak var playerView: WKWebView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.uiDelegate = self
        playerView.navigationDelegate = self
        presenter?.view = self
        movieTitle.text = presenter?.getMovie().title
        movieOverview.text = presenter?.getMovie().overview
    }
    
}

