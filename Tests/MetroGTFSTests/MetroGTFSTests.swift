//
//  GTFSTests.swift
//  
//
//  Created by Emma on 11/25/23.
//

import XCTest
@testable import MetroGTFS

final class MetroGTFSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreateAllStops() throws {
        let database = try GTFS.Database.connection()
        
        for row in try GTFS.Database.stops(from: database) {
            let stop = try GTFS.Stop.from(row: row)
            
            // Does the Stop ID from the database match one of the valid location type prefixes?
            let prefix = stop.id.string.prefixMatch(of: try Regex("^(ENT|NODE|PF|PLF|STN)"))
            
            if let prefix {
                XCTAssert(!prefix.isEmpty)
            } else {
                XCTFail("Stop ID does not have a valid prefix. \(stop). ID: \(stop.id)")
            }
        }
    }

}
