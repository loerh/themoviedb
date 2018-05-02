//
//  TableView.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit

/**
 The table view displaying movies
 */
class MoviesTableView: UITableView {
    
    //MARK: Properties
    
    /// The initial list of movies without any filtering
    private var allMovies: [Movie]?
    
    /// The showed list of movies on the table view. It may or may not have been filtered
    private var movies: [Movie]?
    
    /// The last item delegate
    private var lastItemDelegate: TableViewLastItemDelegate?
    
    /// The current search text, if any
    private var currentSearchText: String?
    
    /// The selected index path
    private var selectedIndexPath: IndexPath?
    
    //MARK: Setup
    
    /**
     Sets up the table view.
     - parameter movies: The list of movies to populate the table view.
     - parameter itemDelegate: The TableViewLastItemDelegate to use for callbacks.
     */
    func setup(withMovies movies: [Movie], itemDelegate: TableViewLastItemDelegate?) {
        
        delegate = self
        dataSource = self
        self.allMovies = movies
        
        if let searchText = currentSearchText {
            self.movies = movies.filter { $0.title.lowercased().contains(searchText) }
        } else {
            self.movies = movies
        }
        
        self.lastItemDelegate = itemDelegate
        reloadData()
    }
    
    //MARK: Filtering
    
    /**
     Filters movies in the table view.
     - parameter searchText: The search text that was entered by the user to filter results. Defaults to nil.
     */
    func filterMovies(withSearchText searchText: String? = nil) {
        
        /// Check that search hasn't been cleared
        if searchText?.isEmpty ?? true {
            currentSearchText = nil
            movies = allMovies
            reloadData()
            return
        }
        
        /// Format search text
        guard let formattedSearchText = searchText?.lowercased() else {
            print("Could not find any search text")
            return
        }
        
        /// Filter and update table view
        currentSearchText = formattedSearchText
        movies = allMovies?.filter { $0.title.lowercased().contains(formattedSearchText) }
        reloadData()
    }
    
}

extension MoviesTableView: UITableViewDataSource {
    
    //MARK: Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (movies?.count ?? 0) - 1 {
            lastItemDelegate?.didReachLastItem()
        }
        
        let identifier = currentSearchText == nil ? TableViewCellSize.regular.rawValue : TableViewCellSize.large.rawValue
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        
        if let movie = movies?[indexPath.row] {
            cell.configure(with: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if currentSearchText != nil || indexPath == selectedIndexPath {
            return UITableViewAutomaticDimension
        }
      
        return currentSearchText == nil ? 130 : 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    
}

extension MoviesTableView: UITableViewDelegate {
    
    //MARK: Table View Delegate Functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexPath = nil
    }
}

/**
 The last item delegate for a table view.
 */
protocol TableViewLastItemDelegate {
    func didReachLastItem()
}
