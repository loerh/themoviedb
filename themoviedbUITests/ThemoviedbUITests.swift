//
//  themoviedbUITests.swift
//  themoviedbUITests
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import XCTest

class ThemoviedbUITests: XCTestCase {
    
    private var application: XCUIApplication?
    
    private var app: XCUIApplication {
        
        if let app = application {
            return app
        }
        
        let newApp = XCUIApplication()
        application = newApp
        return newApp
    }
        
    override func setUp() {
        super.setUp()
        
        // stop immediately when a failure occurs
        continueAfterFailure = false
        // Launch the application that they test
        app.launch()
    }
    
    func testElementsPresentInTableView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let staticText = app.tables.staticTexts.firstMatch
        let predicate = NSPredicate(format: "exists == 1")
        let expect = expectation(for: predicate, evaluatedWith: staticText, handler: nil)
        wait(for: [expect], timeout: 10)
    }
    
    func testTableViewScrollable() {
        app.tables.firstMatch.swipeDown()
    }
    
}
