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
    
    /// The showed list of movies on the table view. It may or may not have been filtered
    private var movies: [Movie]?
    
    /// The last item delegate
    private var lastItemDelegate: TableViewLastItemDelegate?
    
    /// The selected index path
    private var selectedIndexPath: IndexPath?
    
    /// If search mode is currently enabled or disabled
    private var isSearching = false
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTableFooter()
    }
    
    /**
     Sets up the table view.
     - parameter movies: The list of movies to populate the table view.
     - parameter itemDelegate: The TableViewLastItemDelegate to use for callbacks.
     */
    func setup(withMovies movies: [Movie], itemDelegate: TableViewLastItemDelegate?) {
        
        delegate = self
        dataSource = self
        
        self.movies = movies
        self.lastItemDelegate = itemDelegate
        reloadData()
    }
    
    /**
     Sets search mode enabled or disabled.
     - parameter isEnabled: If search mode should be enabled or disabled.
     */
    func setSearchMode(enabled isEnabled: Bool) {
        self.isSearching = isEnabled
    }
    
    //MARK: Table Footer View
    
    /**
     Updates table view's footer view.
     - parameter isSearching: If search mode is currently enabled. Defaults to false.
     */
    private func updateTableFooter(isSearching: Bool = false) {
        
        var footerView: TableViewFooterView?
        
        if let existingFooterView = tableFooterView as? TableViewFooterView {
            footerView = existingFooterView
        } else {
            footerView = Bundle.main.loadNibNamed(TableViewFooterView.nibName, owner: self, options: nil)?.first as? TableViewFooterView
            footerView?.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 55)
        }
        
        footerView?.loadingLabel?.text = isSearching ? "Looking for more matching results..." : "Loading more popular movies..."
        
        tableFooterView = footerView
    }
    
}

extension MoviesTableView: UITableViewDataSource {
    
    //MARK: Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = isSearching ? TableViewCellSize.large.rawValue : TableViewCellSize.regular.rawValue
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
        
        /// If in search mode or selected row mode, use automatic dimension
        if isSearching || indexPath == selectedIndexPath {
            return UITableViewAutomaticDimension
        }
      
        return isSearching ? 200 : 130
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /// Check if we have reached last item (to load more cells for instance)
        if indexPath.row == (movies?.count ?? 0) - 1 {
            lastItemDelegate?.didReachLastItem()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return nil
        }
        
        return "Most Popular Movies"
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
