import XCTest
import Foundation
@testable import WMATA

let TEST_API_KEY = "9e38c3eab34c4e6c990828002828f5ed" // Get your own @ https://developer.wmata.com using this one will probably result in some weird behavior

final class RailTests: XCTestCase {
    
    func testRailLines() {
        let exp = self.expectation(description: "testRailLines")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.lines { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailEntrances() {
        let exp = self.expectation(description: "testRailEntrances")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.entrances(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailStations() {
        let exp = self.expectation(description: "testRailStations")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.stations(for: .BL) { error in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailStation() {
        let exp = self.expectation(description: "testRailStation")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.station(.A01, to: .A02) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailPositions() {
        let exp = self.expectation(description: "testRailPositions")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.positions { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailRoutes() {
        let exp = self.expectation(description: "testRailRoutes")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.routes { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailCircuits() {
        let exp = self.expectation(description: "testRailCircuits")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.circuits { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailElevatorAndEscalatorIncidents() {
        let exp = self.expectation(description: "testRailElevatorAndEscalatorIncidents")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.elevatorAndEscalatorIncidents(at: .A01) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailIncidents() {
        let exp = self.expectation(description: "testRailIncidents")
        let rail = RailClient(key: TEST_API_KEY)
        
        rail.incidents(at: .A01) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }

    func testStationNextTrains() {
        let exp = self.expectation(description: "testStationNextTrains")
        let station = RailClient(key: TEST_API_KEY)
        
        station.nextTrains(at: .A01) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationInformation() {
        let exp = self.expectation(description: "testStationInformation")
        let station = RailClient(key: TEST_API_KEY)
        
        station.information(for: .A01) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationParkingInformation() {
        let exp = self.expectation(description: "testStationParkingInformation")
        let station = RailClient(key: TEST_API_KEY)
        
        station.parkingInformation(for: .A01) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationPath() {
        let exp = self.expectation(description: "testStationPath")
        let station = RailClient(key: TEST_API_KEY)
        
        station.path(from: .A01, to: .A02) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationTimings() {
        let exp = self.expectation(description: "testStationTimings")
        let station = RailClient(key: TEST_API_KEY)
        
        station.timings(for: .A01) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

final class BusTests: XCTestCase {
    func testBusPositions() {
        let exp = self.expectation(description: "testBusPositions")
        let bus = BusClient(key: TEST_API_KEY)
        
        bus.positions(on: ._10A, at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testBusRoutes() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = BusClient(key: TEST_API_KEY)
        
        bus.routes { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testBusSearchStops() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = BusClient(key: TEST_API_KEY)
        
        bus.searchStops(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testBusIncidents() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = BusClient(key: TEST_API_KEY)
        
        bus.incidents(on: ._10A) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRoutePositions() {
        let exp = self.expectation(description: "testRoutePositions")
        let route = BusClient(key: TEST_API_KEY)
        
        route.positions(on: ._10A, at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRoutePathDetails() {
        let exp = self.expectation(description: "testRoutePathDetails")
        let route = BusClient(key: TEST_API_KEY)
        
        route.pathDetails(for: ._10A, on: nil) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRouteSchedule() {
        let exp = self.expectation(description: "testRouteSchedule")
        let route = BusClient(key: TEST_API_KEY)
        
        route.schedule(for: ._10A, on: nil, includingVariations: true) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }

    func testStopNextBuses() {
        let exp = self.expectation(description: "testStopNextBuses")
        let stop = BusClient(key: TEST_API_KEY)
        
        stop.nextBuses(for: Stop(id: "1001195")) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStopSchedule() {
        let exp = self.expectation(description: "testStopSchedule")
        let stop = BusClient(key: TEST_API_KEY)
        
        stop.schedule(for: Stop(id: "1001195")) { result in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
