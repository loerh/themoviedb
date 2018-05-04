//
//  Constants.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The list of constants for the overall application.
 */
struct Constants {
    
    /// The API base URL
    static let apiBaseURL = "https://api.themoviedb.org/3/"
    
    /// The API image base URL
    static let apiImageBaseURL = "https://image.tmdb.org/t/p/"
    
    /// The API key for themoviedb.com's API
    static let tmdbAPIKey = "93aea0c77bc168d8bbce3918cefefa45"
    
    /// The most popular movies path (for API and key value binding)
    static let popularMoviesPath = "movie/popular"
    
    /// The search movies path (for API and key value binding)
    static let searchMoviesPath = "search/movie"
}

/// A type alias for movies completion
typealias MoviesCompletion = ([Movie]?) -> Void
