//
//  Movie.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 The Movie object model
 */
struct Movie {
    
    /// Title of the movie
    let title: String
    
    /// Release year of the movie
    let year: Int
    
    /// Image URL of the movie
    let imageURL: String?
    
    /// Overview/description of the movie
    let overview: String
    
    
    /**
     Parses a JSON object and converts it to a Movie object.
     - parameter json: The JSON object to parse.
     - returns: The converted Movie object, if any
     */
    static func parseJSON(json: JSON) -> Movie? {
        
        guard let title = json[MovieKey.title.rawValue].string else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let rawDate = json[MovieKey.releaseDate.rawValue].string,
        let date = dateFormatter.date(from: rawDate) else {
            return nil
        }
        
        let year = Calendar.current.component(.year, from: date)
        
        var imageURL: String?
        if let posterPath = json[MovieKey.posterPath.rawValue].string {
            imageURL = Constants.apiImageBaseURL + "w500" + posterPath
        }
        
        guard let overview = json[MovieKey.overview.rawValue].string else {
            return nil
        }
        
        return Movie(title: title, year: year, imageURL: imageURL, overview: overview)
        
    }
}

/**
 The list of keys in the JSON to parse a Movie Object.
 */
enum MovieKey: String {
    
    /// Title
    case title
    
    /// Release date
    case releaseDate = "release_date"
    
    /// Overview
    case overview
    
    /// Poster path
    case posterPath = "poster_path"
}
