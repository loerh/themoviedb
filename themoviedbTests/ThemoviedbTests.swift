//
//  themoviedbTests.swift
//  themoviedbTests
//
//  Created by Laurent Meert on 30/04/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import themoviedb

class ThemoviedbTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoviesParsing() {
        guard let path = Bundle.main.path(forResource: "MoviesSample", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSON(data: data)
            
            guard let results = json["results"].array else {
                XCTFail()
                return
            }
            
            for result in results {
                XCTAssertNotNil(Movie.parseJSON(json: result))
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
        
    }
    
    func testFailingParsing() {
        
        guard let path = Bundle.main.path(forResource: "MoviesSampleMissingFields", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSON(data: data)
            
            guard let results = json["results"].array else {
                XCTFail()
                return
            }
            
            for result in results {
                XCTAssertNil(Movie.parseJSON(json: result))
            }
            
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testMoviesViewModel() {
        let viewModel = MoviesViewModel()
        viewModel.fetchMostPopularMovies { (movies) in
            XCTAssertNotNil(movies)
        }
    }
    
    func testMoviesAPI() {
        let expect = expectation(description: "API Movies Test")
        APIManager.shared.fetchMostPopularMovies { (movies) in
            XCTAssertNotNil(movies)
            expect.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testPerformanceAPIResponse() {
        
        var flag = 0
        let expect = expectation(description: "API Response performance")
        self.measure {
            
            APIManager.shared.fetchMostPopularMovies { (movies) in
                flag += 1
                print("FLAG: \(flag)")
                XCTAssertNotNil(movies)
                if flag == 10 { expect.fulfill() }
            }
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }
    
}
