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
        
        for row in try database.all(GTFS.Stop.self) {
            let stop = try GTFS.Stop(row)
            
            // Does the Stop ID from the database match one of the valid location type prefixes?
            let prefix = stop.id.string.prefixMatch(of: try Regex("^(ENT|NODE|PF|PLF|STN)"))
            
            XCTAssertNotNil(prefix)
            XCTAssertGreaterThan(prefix!.count, 0)
        }
    }
    
    func testCreateAStop() throws {
        let stop = try GTFS.Stop(id: .init("STN_N12"))
        
        XCTAssertEqual(stop.name, "ASHBURN METRORAIL STATION")
    }
    
    func testCreateAStopFromWMATAStation() throws {
        let stop = try GTFS.Stop(station: .ashburn)
        
        XCTAssertEqual(stop.name, "ASHBURN METRORAIL STATION")
    }
    
    func testCreateAllStopsWithParentStation() throws {
        let stops = try GTFS.Stop.all(withParentStation: .init("STN_B01_F01"))
        
        for stop in stops {
            XCTAssert(stop.name.contains("CHINATOWN") || stop.name.contains("GALLERY PL"), stop.name)
        }
    }
    
    func testCreateAllLevels() throws {
        let database = try GTFS.Database()
        
        for row in try database.all(GTFS.Level.self) {
            let level = try GTFS.Level(row)
            
            let stationCode = level.id.string.prefix(3)
            
            XCTAssertNotNil(Station(rawValue: String(stationCode)))
        }
    }
    
    func testCreateALevel() throws {
        let level = try GTFS.Level(id: .init("B05_L1"))
        
        XCTAssertEqual(level.name, "Mezzanine")
    }
}
