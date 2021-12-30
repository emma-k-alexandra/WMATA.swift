//
//  TestLine.swift
//  
//
//  Created by Randall Wood on 2021-12-30.
//

@testable import WMATA
import XCTest

class LineTests: XCTestCase {

    func testCurrent() {
        Line.allCurrent.forEach({ XCTAssertTrue($0.current, "expected \($0) to be current") })
        Line.allCases
            .filter({ !Line.allCurrent.contains($0) })
            .forEach({ XCTAssertFalse($0.current, "expected \($0) to not be current") })
    }
}
