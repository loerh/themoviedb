//
//  TableView.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit

class MoviesTableView: UITableView {
    
    private var allMovies: [Movie]?
    private var movies: [Movie]?
    private var lastItemDelegate: LastItemDelegate?
    private var currentSearchText: String?
    private var selectedIndexPath: IndexPath?
    
    func setup(withMovies movies: [Movie], itemDelegate: LastItemDelegate?) {
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
    
    func filterMovies(withSearchText searchText: String) {
        
        if searchText.isEmpty {
            currentSearchText = nil
            movies = allMovies
            reloadData()
            return
        }
        
        let formattedSearchText = searchText.lowercased()
        currentSearchText = formattedSearchText
        movies = allMovies?.filter { $0.title.lowercased().contains(formattedSearchText) }
        reloadData()
    }
    
}

extension MoviesTableView: UITableViewDataSource {
    
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
        
        var heightForRow: CGFloat = currentSearchText == nil ? 120 : 180
        if indexPath == selectedIndexPath {
            
            guard let movieCell = tableView.cellForRow(at: indexPath) as? MoviesTableViewCell else {
                return heightForRow
            }
            let increasedHeight = (movieCell.overviewLabel?.requiredHeight ?? 0) - (movieCell.overviewLabel?.bounds.size.height ?? 0)
            heightForRow += increasedHeight + 5
        }
        
        return heightForRow
    }
}

extension MoviesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? MoviesTableViewCell else {
//            return
//        }
        selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexPath = nil
    }
}

protocol LastItemDelegate {
    func didReachLastItem()
}
