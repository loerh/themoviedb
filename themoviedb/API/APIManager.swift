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

class APIManager {
    
    static let shared = APIManager()
    
    func fetchMostPopularMovies(forPage page: Int = 1, completion: @escaping MostPopularMoviesCompletion) {
        

        let parameters: Parameters = [
            "page": page,
            "api_key": Constants.tmdbAPIKey
        ]
        
        fetch(withAdditionalURL: "list/1", parameters: parameters) { (json) in
            
            guard let json = json else {
                print("Error fetching Most popular movies.")
                completion(nil)
                return
            }
            
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
            
            var movies = [Movie]()
            for result in results {
                if let movie = Movie.parseJSON(json: result) {
                    movies.append(movie)
                }
            }
            
            completion(movies)
        }
    }
    
    private func fetch(withAdditionalURL additionalURL: String,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil,
                       completion: @escaping (JSON?) -> Void) {
        
        let url = Constants.apiBaseURL + additionalURL
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData { (dataResponse) in
            
            guard let data = dataResponse.result.value else {
                print("Could not find any data for this request!")
                completion(nil)
                return
            }
            
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
