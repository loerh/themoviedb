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
    
    /// The movies respective page number for API pagination
    private var moviesPages: [String: Int] = [
        Constants.popularMoviesPath: 1,
        Constants.searchMoviesPath: 1
    ]
    
    /// The stored list of most popular movies
    private var mostPopularMovies = [Movie]()
    
    /// The stored list of search movies
    private var searchMovies = [Movie]()
    
    /// The current search filter, if any
    private var searchFilter: String?
    
    /**
     Fetches movies.
     - parameter filter: The filter text applied in case of search.
     */
    func fetchMovies(filter: String? = nil, canceledSearch isCanceledSearch: Bool = false, completion: @escaping MoviesCompletion) {
        
        /// Reload existing popular movies if search was canceled
        if isCanceledSearch {
            print("Search was canceled. Reloading data with existing popular movies.")
            completion(mostPopularMovies)
            return
        }
        
        /// Define request type, page key and returned movies
        var requestType: APIMoviesRequestType = .mostPopular
        var pageKey = Constants.popularMoviesPath
        var returnedMovies = mostPopularMovies
        
        if let filter = filter {
            
            /// Clean up search storage if search text (query) has changed
            if let searchFilter = searchFilter {
                if searchFilter != filter {
                    print("Search filter has changed. Resetting pagination and results storage.")
                    searchMovies.removeAll()
                    moviesPages[Constants.searchMoviesPath] = 1
                    completion(searchMovies)
                } else {
                    print("Search keyword is the same as before. Reloading existing search data.")
                    completion(searchMovies)
                    return
                }
            }
            
            requestType = .search(filter)
            pageKey = Constants.searchMoviesPath
            returnedMovies = searchMovies
        }
        
        searchFilter = filter
        
        guard let page = moviesPages[pageKey] else {
            print("Could not find page for key \(pageKey)")
            return
        }
        
        APIManager.shared.fetchMovies(withRequestType: requestType, forPage: page) { (movies) in
            
            /// Make sure we have movies
            guard let movies = movies else {
                completion(nil)
                return
            }
            
            /// Add new movies to stored property
            for movie in movies {
                returnedMovies.append(movie)
            }
            
            if filter == nil {
                self.mostPopularMovies = returnedMovies
            } else {
                self.searchMovies = returnedMovies
            }
            
            print("Finished fetching movies for page \(page) (\(filter == nil ? "Most popular" : "Search"))")
            self.moviesPages[pageKey] = page + 1
            completion(returnedMovies)
        }
    }
}
