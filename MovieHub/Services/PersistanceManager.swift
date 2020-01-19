//
//  PersistanceManager.swift
//  MovieHub
//
//  Created by Leialey on 12.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import CoreData

class PersistanceManager: PersistanceManagement {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var favouriteMovies = [FavouriteMovie]()
    
    //MARK: - Public methods
    func fetchFavourites() throws {
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        do {
            favouriteMovies = try context.fetch(request)
        } catch {
            throw TaskError.errorDB
        }
    }
    
    
    func updateFavourite(movie: Movie) throws {
        if isFavourite(movie) {
            try deleteFavourite(movie)
        } else {
            try saveFavourite(movie)
        }
        try saveContext()
    }
    
    
    
    func isFavourite(_ movie: Movie) -> Bool {
        return favouriteMovies.contains(where: {$0.id == Int64(movie.id)})
    }
    
    
    
    //MARK: - Private methods
    
    private func saveFavourite(_ movie: Movie) throws {
        let favouriteMovie = FavouriteMovie(context: context)
        favouriteMovie.id = Int64(movie.id)
        favouriteMovies.append(favouriteMovie)
    }
    
    private func deleteFavourite(_ movie: Movie) throws {
        guard let index = favouriteMovies.firstIndex(where: {$0.id == movie.id}) else { return }
        context.delete(favouriteMovies[index])
        favouriteMovies.remove(at: index)
        
    }
    
    private func saveContext() throws {
        do {
            try context.save()
        } catch {
            throw TaskError.errorDB
        }
    }
}
