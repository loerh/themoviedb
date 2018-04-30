//
//  ViewController.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: MoviesTableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    private lazy var moviesViewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar?.delegate = self
        
        fetchData() {
            self.activityIndicator?.stopAnimating()
        }
    }

    private func fetchData(completion: @escaping () -> Void) {
        
        moviesViewModel.fetchMostPopularMovies { (movies) in
            if let movies = movies {
                self.moviesTableView?.setup(withMovies: movies, itemDelegate: self)
            }
            
            completion()
        }
    }

}

extension MoviesViewController: LastItemDelegate {
    
    func didReachLastItem() {
        
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        
        fetchData() {
            self.activityIndicator?.stopAnimating()
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviesTableView?.filterMovies(withSearchText: searchText)
    }
}

