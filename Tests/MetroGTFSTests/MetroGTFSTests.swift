//
//  GTFSTests.swift
//  
//
//  Created by Emma on 11/25/23.
//

import XCTest
@testable import MetroGTFS
import WMATA

final class MetroGTFSTests: XCTestCase {
    func testCreateAllStops() throws {
        let database = try GTFS.Database()
        
        for row in try database.all(GTFSStop.self) {
            let stop = try GTFSStop(row: row)
            
            // Does the Stop ID from the database match one of the valid location type prefixes?
            let prefix = stop.id.rawValue.prefixMatch(of: try Regex("^(ENT|NODE|PF|PLF|STN)"))
            
            XCTAssertNotNil(prefix)
            XCTAssertGreaterThan(prefix!.count, 0)
        }
    }
    
    func testCreateAStop() throws {
        let stop = try GTFSStop(id: .init("STN_N12"))
        
        XCTAssertEqual(stop.name, "ASHBURN METRORAIL STATION")
    }
    
    func testCreateAStopWithShorthand() throws {
        let stop = try GTFSStop("STN_N12")
        
        XCTAssertEqual(stop.name, "ASHBURN METRORAIL STATION")
    }
    
    func testCreateAStopFromWMATAStation() throws {
        let stop = try GTFSStop(station: .ashburn)
        
        XCTAssertEqual(stop.name, "ASHBURN METRORAIL STATION")
    }
    
    func testCreateAllStopsWithParentStation() throws {
        let stops = try GTFSStop.all(withParentStation: .init("STN_B01_F01"))
        
        for stop in stops {
            XCTAssert(stop.name.contains("CHINATOWN") || stop.name.contains("GALLERY PL"), stop.name)
        }
    }
    
    func testCreateAllLevels() throws {
        let database = try GTFS.Database()
        
        for row in try database.all(GTFSLevel.self) {
            let level = try GTFSLevel(row: row)
            
            let stationCode = level.id.rawValue.prefix(3)
            
            XCTAssertNotNil(Station(rawValue: String(stationCode)))
        }
    }
    
    func testCreateALevel() throws {
        let level = try GTFSLevel(id: .init("B05_L1"))
        
        XCTAssertEqual(level.name, "Mezzanine")
    }
    
    func testCreateALevelWithShorthand() throws {
        let level = try GTFSLevel("B05_L1")
        
        XCTAssertEqual(level.name, "Mezzanine")
    }
}
