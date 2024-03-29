//
//  TestStation.swift
//  
//
//  Created by Emma on 11/6/21.
//

@testable import WMATA
import XCTest

final class StationTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Station.metroCenterUpper.name, "Metro Center")
    }

    func testLines() {
        XCTAssertEqual(Station.metroCenterUpper.lines, [.red])
    }

    func testTogether() {
        XCTAssertEqual(Station.metroCenterUpper.together, Station.metroCenterLower)
        XCTAssertEqual(Station.metroCenterLower.together, Station.metroCenterUpper)
        XCTAssertNil(Station.farragutNorth.together)
    }

    func testAllTogether() {
        XCTAssertEqual(Station.metroCenterUpper.allTogether, [Station.metroCenterUpper, Station.metroCenterLower])
        XCTAssertEqual(Station.metroCenterLower.allTogether, [Station.metroCenterLower, Station.metroCenterUpper])
        XCTAssertEqual(Station.farragutNorth.allTogether, [Station.farragutNorth])
    }

    func testConnections() {
        XCTAssertEqual([], Station.farragutNorth.connections(to: .red))
        XCTAssertEqual([.red], Station.farragutNorth.connections(to: nil))
        XCTAssertEqual([.yellow], Station.fortTottenLower.connections(to: .green))
        XCTAssertEqual([.green, .yellow], Station.fortTottenLower.connections(to: nil))
    }

    func testAllConnections() {
        XCTAssertEqual([], Station.farragutNorth.allConnections(to: .red))
        XCTAssertEqual([.red], Station.farragutNorth.allConnections(to: nil))
        XCTAssertEqual([.yellow, .red], Station.fortTottenLower.allConnections(to: .green))
        XCTAssertEqual([.green, .yellow, .red], Station.fortTottenLower.allConnections(to: nil))
    }

    func testOpen() {
        Station.allOpen.forEach({ XCTAssertTrue($0.open, "expected \($0) to be open") })
        Station.allCases
            .filter({ !Station.allOpen.contains($0) })
            .forEach({ XCTAssertFalse($0.open, "expected \($0) to be closed") })
    }
}
