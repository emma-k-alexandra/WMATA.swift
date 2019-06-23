import XCTest
import Foundation
@testable import WMATA

let TEST_API_KEY = "9e38c3eab34c4e6c990828002828f5ed" // Get your own @ https://developer.wmata.com using this one will probably result in some weird behavior

final class WMATATests: XCTestCase {
    func testWmataBasicInit() {
        let wmata = WMATA(apiKey: "test")
        
        XCTAssertEqual("test", wmata.apiKey)
        
    }
    
    func testWmataSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "A"))
        let wmata = WMATA(apiKey: "test", session: session)
        
        XCTAssertEqual(wmata.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testWmataStationCodeSubscript() {
        let metroCenter = WMATA(apiKey: TEST_API_KEY)[.A01]
        
        XCTAssertEqual(metroCenter.code, .A01)
        
    }
    
    func testWmataLineSubscript() {
        let redLine = WMATA(apiKey: TEST_API_KEY)[.RD]
        
        XCTAssertEqual(redLine.line, .RD)
        
    }
    
    func testWmataStopSubscript() {
        let seventhAndMass = WMATA(apiKey: TEST_API_KEY)["1001195"]
        
        XCTAssertEqual(seventhAndMass.stopId, "1001195")
        
    }
    
    func testWmataRouteSubscript() {
        let a12 = WMATA(apiKey: TEST_API_KEY)[Route.Id.A12] // Note that A12 is both a Station and a Route
        
        XCTAssertEqual(a12.routeId, .A12)
        
    }
    
    func testWmataRail() {
        let rail = WMATA(apiKey: TEST_API_KEY).rail
        
        XCTAssertEqual(rail.apiKey, TEST_API_KEY)
        
    }
    
    func testWmataBus() {
        let bus = WMATA(apiKey: TEST_API_KEY).bus
        
        XCTAssertEqual(bus.apiKey, TEST_API_KEY)
        
    }
    
}

final class LineTests: XCTestCase {
    func testBasicLinesInit() {
        let line = Line(apiKey: "test", line: .BL)
        
        XCTAssertEqual("test", line.apiKey)
        
    }
    
    func testLineSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "C"))
        let line = Line(apiKey: "test", line: .BL, session: session)
        
        XCTAssertEqual(line.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testLineStations() {
        let exp = self.expectation(description: "testLineStations")
        let line = Line(apiKey: TEST_API_KEY, line: .BL)
        
        line.stations { (stations, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

final class RailTests: XCTestCase {
    func testBasicRailInit() {
        let rail = Rail(apiKey: "test")
        
        XCTAssertEqual("test", rail.apiKey)
        
    }
    
    func testRailSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "D"))
        let rail = Rail(apiKey: "test", session: session)
        
        XCTAssertEqual(rail.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testRailLines() {
        let exp = self.expectation(description: "testRailLines")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.lines { (lines, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailEntrances() {
        let exp = self.expectation(description: "testRailEntrances")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.entrances(latitude: 1, longitude: 1, radius: 1) { (entrances, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailStations() {
        let exp = self.expectation(description: "testRailStations")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.stations(for: .BL) { (stations, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailStation() {
        let exp = self.expectation(description: "testRailStation")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.station(.A01, to: .A02) { (stationToStationInfos, error) in
            exp.fulfill()
    
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailPositions() {
        let exp = self.expectation(description: "testRailPositions")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.positions { (positions, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailRoutes() {
        let exp = self.expectation(description: "testRailRoutes")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.routes { (routes, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailCircuits() {
        let exp = self.expectation(description: "testRailCircuits")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.circuits { (circuits, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailElevatorAndEscalatorIncidents() {
        let exp = self.expectation(description: "testRailElevatorAndEscalatorIncidents")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.elevatorAndEscalatorIncidents(at: .A01) { (incidents, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRailIncidents() {
        let exp = self.expectation(description: "testRailIncidents")
        let rail = Rail(apiKey: TEST_API_KEY)
        
        rail.incidents(at: .A01) { (incidents, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

final class StationTests: XCTestCase {
    func testBasicStationInit() {
        let station = Station(apiKey: "test", code: .A01)
        
        XCTAssertEqual(station.apiKey, "test")
        
    }
    
    func testStationSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "E"))
        let station = Station(apiKey: "test", code: .A01, session: session)
        
        XCTAssertEqual(station.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testStationNextTrains() {
        let exp = self.expectation(description: "testStationNextTrains")
        let station = Station(apiKey: TEST_API_KEY, code: .A01)
        
        station.nextTrains { (railPredictions, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationInformation() {
        let exp = self.expectation(description: "testStationInformation")
        let station = Station(apiKey: TEST_API_KEY, code: .A01)
        
        station.information { (stationInformation, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationParkingInformation() {
        let exp = self.expectation(description: "testStationParkingInformation")
        let station = Station(apiKey: TEST_API_KEY, code: .A01)
        
        station.parkingInformation { (stationsParking, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationPath() {
        let exp = self.expectation(description: "testStationPath")
        let station = Station(apiKey: TEST_API_KEY, code: .A01)
        
        station.path(to: .A02) { (pathBetweenStations, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationTimings() {
        let exp = self.expectation(description: "testStationTimings")
        let station = Station(apiKey: TEST_API_KEY, code: .A01)
        
        station.timings { (timings, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStationTo() {
        let exp = self.expectation(description: "testStationTo")
        let station = Station(apiKey: TEST_API_KEY, code: .A01)
        
        station.to(.A02) { (stationToStationInfos, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

final class BusTests: XCTestCase {
    func testBusBasicInit() {
        let bus = Bus(apiKey: "test")
        
        XCTAssertEqual(bus.apiKey, "test")
        
    }
    
    func testBusSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "F"))
        let bus = Bus(apiKey: "test", session: session)
        
        XCTAssertEqual(bus.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testBusPositions() {
        let exp = self.expectation(description: "testBusPositions")
        let bus = Bus(apiKey: TEST_API_KEY)
        
        bus.positions(routeId: ._10A, latitude: 1, longitude: 1, radius: 1) { (positions, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testBusRoutes() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = Bus(apiKey: TEST_API_KEY)
        
        bus.routes { (routes, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testBusSearchStops() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = Bus(apiKey: TEST_API_KEY)
        
        bus.searchStops(latitude: 1, longitude: 1, radius: 1) { (stops, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testBusIncidents() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = Bus(apiKey: TEST_API_KEY)
        
        bus.incidents(route: ._10A) { (incidents, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

final class RouteTests: XCTestCase {
    func testRouteBasicInit() {
        let route = Route(apiKey: "test", routeId: ._10A)
        
        XCTAssertEqual(route.apiKey, "test")
        XCTAssertEqual(route.routeId, ._10A)
        
    }
    
    func testRouteSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "G"))
        let route = Route(apiKey: "test", routeId: ._10A, session: session)
        
        XCTAssertEqual(route.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testRoutePositions() {
        let exp = self.expectation(description: "testRoutePositions")
        let route = Route(apiKey: TEST_API_KEY, routeId: ._10A)
        
        route.positions(latitude: 1, longitude: 1, radius: 1) { (positions, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRoutePathDetails() {
        let exp = self.expectation(description: "testRoutePathDetails")
        let route = Route(apiKey: TEST_API_KEY, routeId: ._10A)
        
        route.pathDetails(date: nil) { (pathDetails, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testRouteSchedule() {
        let exp = self.expectation(description: "testRouteSchedule")
        let route = Route(apiKey: TEST_API_KEY, routeId: ._10A)
        
        route.schedule(date: nil, includingVariations: true) { (stops, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

final class StopTests: XCTestCase {
    func testStopBasicInit() {
        let stop = Stop(apiKey: "test", stopId: "1001195")
        
        XCTAssertEqual(stop.apiKey, "test")
        XCTAssertEqual(stop.stopId, "1001195")
        
    }
    
    func testStopSessionInit() {
        let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "H"))
        let stop = Stop(apiKey: "test", stopId: "1001195", session: session)
        
        XCTAssertEqual(stop.session.configuration.identifier, session.configuration.identifier)
        
    }
    
    func testStopNextBuses() {
        let exp = self.expectation(description: "testStopNextBuses")
        let stop = Stop(apiKey: TEST_API_KEY, stopId: "1001195")
        
        stop.nextBuses { (buses, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testStopSchedule() {
        let exp = self.expectation(description: "testStopSchedule")
        let stop = Stop(apiKey: TEST_API_KEY, stopId: "1001195")
        
        stop.schedule(at: nil) { (schedule, error) in
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}


