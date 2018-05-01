//
//  Extensions.swift
//  themoviedb
//
//  Created by Laurent Meert on 01/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(with: CGSize(width: frame.size.width,
                                                                              height: .greatestFiniteMagnitude),
                                                                 options: .usesLineFragmentOrigin,
                                                                 attributes: [.font: font],
                                                                 context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
 
    var requiredHeight: CGFloat {
        guard let text = text else {
            return bounds.size.height
        }
        
        let textRect = (text as NSString).boundingRect(with: CGSize(width: frame.size.width,
                                                                      height: .greatestFiniteMagnitude),
                                                         options: .usesLineFragmentOrigin,
                                                         attributes: [.font: font],
                                                         context: nil)
        
        return textRect.size.height
        
    }
}
