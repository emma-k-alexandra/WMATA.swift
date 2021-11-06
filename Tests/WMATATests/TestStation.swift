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
        XCTAssertEqual(Station.A01.name, "Metro Center")
    }

    func testLines() {
        XCTAssertEqual(Station.A01.lines, [.BL, .OR, .SV, .RD])
    }

    func testOpenTimeSaturday() {
        let date = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2020, month: 1, day: 11, hour: 7, minute: 14).date!

        XCTAssertEqual(Station.A01.openingTime(on: date), date)
    }

    func testOpenTimeSunday() {
        let date = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2020, month: 1, day: 12, hour: 8, minute: 14).date!

        XCTAssertEqual(Station.A01.openingTime(on: date), date)
    }

    func testOpenTimeWeekday() {
        let date = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2020, month: 1, day: 13, hour: 5, minute: 14).date!

        XCTAssertEqual(Station.A01.openingTime(on: date), date)
    }

    func testTogether() {
        XCTAssertEqual(Station.A01.together, Station.C01)
        XCTAssertEqual(Station.C01.together, Station.A01)
        XCTAssertNil(Station.A02.together)
    }

    func testAllTogether() {
        XCTAssertEqual(Station.A01.allTogether, [Station.A01, Station.C01])
        XCTAssertEqual(Station.C01.allTogether, [Station.C01, Station.A01])
        XCTAssertEqual(Station.A02.allTogether, [Station.A02])
    }
}
