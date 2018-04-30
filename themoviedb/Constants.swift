//
//  Constants.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

struct Constants {
    
    static let apiBaseURL = "https://api.themoviedb.org/4/"
    static let apiImageBaseURL = "https://image.tmdb.org/t/p/"
    static let tmdbAPIKey = "93aea0c77bc168d8bbce3918cefefa45"
}

typealias MostPopularMoviesCompletion = ([Movie]?) -> Void
