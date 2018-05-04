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
        let predicate = NSPredicate(format: "count > 0")
        let expect = expectation(for: predicate, evaluatedWith: app.cells, handler: nil)
        wait(for: [expect], timeout: 10)
    }
    
    func testTableViewScrollable() {
        app.tables.firstMatch.swipeUp()
        app.tables.firstMatch.swipeUp()
    }
    
    func testSearchNoResults() {
        
        search(text: "difjwuyah")
        XCTAssert(app.cells.count == 0)
    }
    
    func testCancelSearch() {
        search(text: "difjwuyah", keepActive: true)
        XCTAssert(app.cells.count == 0)
        app.buttons["Cancel"].tap()
        XCTAssert(app.cells.count > 0)
    }
    
    func testTableViewSelection() {
        let cellHeight = app.cells.firstMatch.frame.size.height
        app.cells.firstMatch.tap()
        XCTAssert(cellHeight < app.cells.firstMatch.frame.size.height)
    }
    
    private func search(text: String, keepActive: Bool = false) {
        let searchMoviesSearchField = app.searchFields.firstMatch
        searchMoviesSearchField.tap()
        searchMoviesSearchField.typeText(text)
        if !keepActive {
            app.buttons["Done"].tap()
        }
    }
    
}
