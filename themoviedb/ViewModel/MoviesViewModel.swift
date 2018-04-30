//
//  MoviesViewModel.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    private var mostPopularMoviesPage = 1
    private var mostPopularMovies = [Movie]()
    
    func fetchMostPopularMovies(completion: @escaping MostPopularMoviesCompletion) {
        
        APIManager.shared.fetchMostPopularMovies(forPage: mostPopularMoviesPage) { (movies) in
            
            guard let movies = movies else {
                completion(nil)
                return
            }
            
            for movie in movies {
                self.mostPopularMovies.append(movie)
            }
            
            completion(self.mostPopularMovies)
            self.mostPopularMoviesPage += 1
        }
    }
}
