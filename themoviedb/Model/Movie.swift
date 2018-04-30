//
//  Movie.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    
    let title: String
    let year: Int
    let imageURL: String?
    let overview: String
    
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

enum MovieKey: String {
    case title
    case releaseDate = "release_date"
    case overview
    case posterPath = "poster_path"
}
