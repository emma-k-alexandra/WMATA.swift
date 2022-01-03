//
//  TestLine.swift
//  
//
//  Created by Randall Wood on 2021-12-30.
//

@testable import WMATA
import XCTest

class LineTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Line.red.name, "Red")
        XCTAssertEqual(Line.blue.name, "Blue")
        XCTAssertEqual(Line.yellow.name, "Yellow")
        XCTAssertEqual(Line.orange.name, "Orange")
        XCTAssertEqual(Line.green.name, "Green")
        XCTAssertEqual(Line.silver.name, "Silver")
    }
}
