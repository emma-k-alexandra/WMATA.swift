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
    
    func testSharesTracksWith() {
        XCTAssertEqual(Line.red.sharesTracksWith, [])
        XCTAssertEqual(
            Line.blue.sharesTracksWith,
            [.yellow, .orange, .silver]
        )
        XCTAssertEqual(
            Line.yellow.sharesTracksWith,
            [.blue, .green]
        )
        XCTAssertEqual(
            Line.orange.sharesTracksWith,
            [.silver, .blue]
        )
        XCTAssertEqual(
            Line.green.sharesTracksWith,
            [.yellow]
        )
        XCTAssertEqual(
            Line.silver.sharesTracksWith,
            [.orange, .blue]
        )
    }
    
    func testLineOrder() {
        XCTAssertEqual(
            Line.allCases,
            [.red, .orange, .blue, .green, .yellow, .silver]
        )
    }
}
