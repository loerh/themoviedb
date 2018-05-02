//
//  MoviesViewModel.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The view model for movies.
 */
class MoviesViewModel {
    
    //MARK: Properties
    
    /// The most popular movies page number for API pagination
    private var mostPopularMoviesPage = 1
    
    /// The stored list of most popular movies
    private var mostPopularMovies = [Movie]()
    
    /**
     Fetches the most popular movies.
     */
    func fetchMostPopularMovies(completion: @escaping MostPopularMoviesCompletion) {
        
        APIManager.shared.fetchMostPopularMovies(forPage: mostPopularMoviesPage) { (movies) in
            
            /// Make sure we have movies
            guard let movies = movies else {
                completion(nil)
                return
            }
            
            /// Add new movies to stored property
            for movie in movies {
                self.mostPopularMovies.append(movie)
            }
            
            completion(self.mostPopularMovies)
            self.mostPopularMoviesPage += 1
        }
    }
}
