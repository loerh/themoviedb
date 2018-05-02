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
    
    /// The required height that this label should be given its CGRect and font
    var requiredHeight: CGFloat {
        
        guard let text = text else {
            return bounds.size.height
        }
        
        /// Get the CGRect for this label using its size and font
        let textRect = (text as NSString).boundingRect(with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
                                                         options: .usesLineFragmentOrigin,
                                                         attributes: [.font: font],
                                                         context: nil)
        
        return textRect.size.height
        
    }
}
