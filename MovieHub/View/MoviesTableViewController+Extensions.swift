//
//  MoviesTableViewController+Extensions.swift
//  MovieHub
//
//  Created by Leialey on 14.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit

extension MoviesTableViewController: MovieView {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //Показывать ошибку в navigation bar для упрощения задачи, но я бы использовала SVProgressHUD или кастомизированный Activity Indicator
    func showStatus(_ statusMessage: String?) {
        DispatchQueue.main.async {
            self.navigationItem.title = statusMessage
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigationItem.title = "POPULAR"
        }
    }
    
    func showDetails(_ presenter: MovieDetailsPresenter) {
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {fatalError("Cannot find MovieDetailsViewController")}
        nextVC.presenter = presenter
        show(nextVC, sender: self)
    }
}
