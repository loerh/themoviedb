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

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var coverImageView: UIImageView?
    @IBOutlet weak var overviewLabel: UILabel?
    @IBOutlet weak var releaseYearLabel: UILabel?
    
    func configure(with movie: Movie) {
        
        titleLabel?.text = movie.title
        overviewLabel?.text = movie.overview
        releaseYearLabel?.text = "\(movie.year)"
        if let imageURL = movie.imageURL {
            coverImageView?.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
        }
    }
}

enum TableViewCellSize: String {
    case regular = "MoviesTableViewCell"
    case large = "MoviesTableViewCellLarge"
}

