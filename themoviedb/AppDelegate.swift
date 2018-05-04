//
//  AppDelegate.swift
//  themoviedb
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /// Search bar appearance
        if let font =  UIFont(name: "HelveticaNeue", size: 14) {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = font
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.font: font.withSize(15)], for: .normal)
        }
        
        return true
    }
}

