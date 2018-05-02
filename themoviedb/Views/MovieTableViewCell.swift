//
//  MovieTableViewCell.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

/**
 The table view cell for a movie.
 */
class MoviesTableViewCell: UITableViewCell {
    
    /// The title label
    @IBOutlet weak var titleLabel: UILabel?
    
    /// The cover image view
    @IBOutlet weak var coverImageView: UIImageView?
    
    /// The overview label
    @IBOutlet weak var overviewLabel: UILabel?
    
    /// The release year label
    @IBOutlet weak var releaseYearLabel: UILabel?
    
    //MARK: Configuration
    
    /**
     Configures the cell using metadata.
     - parameter movie: The Movie object to use for this cell.
     */
    func configure(with movie: Movie) {
        
        titleLabel?.text = movie.title
        overviewLabel?.text = movie.overview
        releaseYearLabel?.text = "\(movie.year)"
        if let imageURL = movie.imageURL {
            coverImageView?.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
        }
    }
}

/**
 Contains the list of table view cell sizes.
 */
enum TableViewCellSize: String {
    
    /// Regular size
    case regular = "MoviesTableViewCell"
    
    /// Large size
    case large = "MoviesTableViewCellLarge"
}

