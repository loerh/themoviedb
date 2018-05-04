//
//  APIManager.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


/**
 A manager for API calls.
 */
class APIManager {
    
    /// The shared instance
    static let shared = APIManager()
    
    /**
     Fetches most popular movies from the API.
     - parameter requestType: The type of API request to use i.e. mostPopular or search.
     - parameter page: The pagination number to use for this request. Defaults to 1.
     */
    func fetchMovies(withRequestType requestType: APIMoviesRequestType, forPage page: Int, completion: @escaping MoviesCompletion) {
        
        /// Define parameters and additional URL
        var parameters: Parameters = [
            "page": page,
            "api_key": Constants.tmdbAPIKey
        ]
        
        let additionalURL: String
        
        switch requestType {
        
        case.mostPopular:
            additionalURL = "movie/popular"
            
        case .search(let keyword):
            additionalURL = "search/movie"
            parameters["query"] = keyword
        }
        
        /// Fetch
        fetch(withAdditionalURL: additionalURL, parameters: parameters) { (json) in
            
            guard let json = json else {
                print("Error fetching Most popular movies.")
                completion(nil)
                return
            }

            /// Extract results
            guard let results = json["results"].array else {
                print("Could not find any results key in JSON")
                completion(nil)
                return
            }

            guard results.count > 0 else {
                print("Empty array of results, no more movies to fetch.")
                completion(nil)
                return
            }

            /// Parse JSON objects to Movie objects
            var movies = [Movie]()
            for result in results {
                if let movie = Movie.parseJSON(json: result) {
                    movies.append(movie)
                }
            }

            completion(movies)
        }
    }
    
    /**
     Fetches generically from the API.
     - parameter additionalURL: The additional URL to use after base URL.
     - parameter method: The HTTPMethod to use e.g. GET, POST, PUT, ... Defaults to GET.
     - parameter parameters: The list of parameters to use for this request. Defaults to nil.
     - parameter encoding: The type of encoding. Defaults to URLEncoding.default.
     - parameter headers: The HTTPHeadears to use, if any. Defaults to nil.
     - parameter completion: The completion handler that sends back the freshly initialised JSON object, if any.
     */
    private func fetch(withAdditionalURL additionalURL: String,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil,
                       completion: @escaping (JSON?) -> Void) {
        
        let url = Constants.apiBaseURL + additionalURL
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData { (dataResponse) in
            
            /// Make sure we've got data back
            guard let data = dataResponse.result.value else {
                print("Could not find any data for this request!")
                completion(nil)
                return
            }
            
            /// Initialise JSON Object
            do {
                let json = try JSON(data: data)
                completion(json)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}

enum APIMoviesRequestType {
    case mostPopular
    case search(String)
}
