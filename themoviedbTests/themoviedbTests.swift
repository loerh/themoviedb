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

class themoviedbTests: XCTestCase {
    
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
