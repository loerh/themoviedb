//
//  ViewController.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The view controller showing movies.
 */
class MoviesViewController: UIViewController {
    
    //MARK: Properties

    /// The movies table view
    @IBOutlet weak var moviesTableView: MoviesTableView?
    
    /// The activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    /// The search bar
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: Outlets
    
    /// The movies view model
    private let moviesViewModel = MoviesViewModel()
    
    //MARK: App Life Cycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar?.delegate = self
        
        fetchData() {
            self.activityIndicator?.stopAnimating()
        }
    }
    
    //MARK: Fetch

    /**
     Fetches data to feed the tableview on this view controller.
     */
    private func fetchData(completion: @escaping () -> Void) {
        
        moviesViewModel.fetchMostPopularMovies { (movies) in
            if let movies = movies {
                self.moviesTableView?.setup(withMovies: movies, itemDelegate: self)
            }
            
            completion()
        }
    }

}

extension MoviesViewController: TableViewLastItemDelegate {
    
    //MARK: Table View Last Item Delegate Functions
    
    /**
     When the table view has reached the last item.
     */
    func didReachLastItem() {
        
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        
        fetchData() {
            self.activityIndicator?.stopAnimating()
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    //MARK: Search Bar Delegate Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviesTableView?.filterMovies(withSearchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        moviesTableView?.filterMovies()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

