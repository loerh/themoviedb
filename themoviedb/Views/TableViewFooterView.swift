//
//  TableViewFooterView.swift
//  themoviedb
//
//  Created by Laurent Meert on 03/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

class TableViewFooterView: UIView {
    
    static let nibName = "TableViewFooter"
    
    @IBOutlet weak var loadingLabel: UILabel?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
}
