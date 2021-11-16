//
//  TestLocation.swift
//  
//
//  Created by Emma on 11/15/21.
//

@testable import WMATA
import XCTest

final class WMATALocationTests: XCTestCase {
    func testInit() {
        let location = WMATALocation(radius: 1, latitude: 1.0, longitude: 1.0)
        
        XCTAssertEqual(location.coordinates.latitude, 1.0)
        XCTAssertEqual(location.coordinates.longitude, 1.0)
    }
    
    func testCoordinatesInit() {
        let location = WMATALocation(
            radius: 1,
            coordinates: .init(latitude: 1.0, longitude: 1.0)
        )
        
        XCTAssertEqual(location.coordinates.latitude, 1.0)
        XCTAssertEqual(location.coordinates.longitude, 1.0)
    }
    
    func testLocationQueryItems() {
        let location = WMATALocation(
            radius: 1,
            coordinates: .init(latitude: 1.0, longitude: 1.0)
        )
        
        let queryItems = location.queryItems()
        
        XCTAssertEqual(queryItems[0], .init(name: "Lat", value: "1.0"))
        XCTAssertEqual(queryItems[1], .init(name: "Lon", value: "1.0"))
        XCTAssertEqual(queryItems[2], .init(name: "Radius", value: "1"))
    }
    
    func testCoordinatesQueryItems() {
        let location = WMATALocation(
            radius: 1,
            coordinates: .init(latitude: 1.0, longitude: 1.0)
        )
        
        let queryItems = location.coordinates.queryItems()
        
        XCTAssertEqual(queryItems.first!, .init(name: "Lat", value: "1.0"))
        XCTAssertEqual(queryItems.last!, .init(name: "Lon", value: "1.0"))
    }
}
