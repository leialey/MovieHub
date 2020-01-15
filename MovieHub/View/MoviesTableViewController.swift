//
//  MoviesTableViewController.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit


class MoviesTableViewController: UITableViewController {
    
    private let cellID = "MovieCell"
    private var presenter: MovieListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieListPresenter(self)
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.rowsToDisplay ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //Эту фразу просят добавить TMDB
        return "This product uses the TMDb API but is not endorsed or certified by TMDb."
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MovieTableViewCell else { fatalError("Cannot cast to MovieTableViewCell")}
        presenter?.configure(cell, indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.loadDataIfNeeded(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell else { fatalError("Cannot cast to MovieTableViewCell")}
        presenter?.requestDetails(cell, indexPath.row)
    }
    
}



