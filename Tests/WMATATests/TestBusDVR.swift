//
//  TestBusDVR.swift
//  
//
//  Created by Emma on 12/2/21.
//

@testable import WMATA
import XCTest

final class TestBusDVR: DVRTestCase {
    func testPositions() {
        let positions = Bus.Positions(
            key: TEST_API_KEY,
            location: .init(
                radius: 3000,
                coordinates: .init(
                    latitude: 38.876736,
                    longitude: -76.724502
                )
            )
        )
    
        positions.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.busPositions.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testRoutes() {
        let routes = Bus.Routes(key: TEST_API_KEY)

        routes.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.routes.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchStops() {
        let stopsSearch = Bus.StopsSearch(
            key: TEST_API_KEY,
            location: .init(
                radius: 3000,
                coordinates: .init(
                    latitude: 38.876736,
                    longitude: -76.724502
                )
            )
        )

        stopsSearch.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.stops.count, 0)
                self?.expectation.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testIncidents() {
        let incidents = Bus.Incidents(key: TEST_API_KEY)

        incidents.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.busIncidents.count, 0)
                self?.expectation.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testPathDetails() {
        let pathDetails = Bus.PathDetails(
            key: TEST_API_KEY,
            route: "10A"
        )

        pathDetails.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(
                    response.name,
                    "10A - PENTAGON - HUNTINGTON STA"
                )
                self?.expectation.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testRouteSchedule() {
        let routeSchedule = Bus.RouteSchedule(
            key: TEST_API_KEY,
            route: "10A",
            includingVariations: true
        )

        routeSchedule.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(
                    response.name,
                    "10A - PENTAGON - HUNTINGTON STA"
                )
                self?.expectation.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testNextBuses() {
        let nextBuses = Bus.NextBuses(
            key: TEST_API_KEY,
            stop: "1001195"
        )

        nextBuses.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(
                    response.stopName,
                    "7th St + Massachusetts Ave"
                )
                self?.expectation.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testStopSchedule() {
        let stopSchedule = Bus.StopSchedule(
            key: TEST_API_KEY,
            stop: "1001195"
        )

        stopSchedule.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(
                    response.stop.name,
                    "7TH ST NW + MASSACHUSETTS AVE NW"
                )
                self?.expectation.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        wait(for: [expectation], timeout: 1)
    }
}

final class TestBusGTFSDVR: DVRTestCase {
    func testAlerts() {
        let alerts = Bus.GTFS.Alerts(key: TEST_API_KEY)
    
        alerts.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertTrue(response.isInitialized)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testTripUpdates() {
        let tripUpdates = Bus.GTFS.TripUpdates(key: TEST_API_KEY)
    
        tripUpdates.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertTrue(response.isInitialized)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testVehiclePositions() {
        let vehiclePositions = Bus.GTFS.VehiclePositions(key: TEST_API_KEY)
    
        vehiclePositions.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertTrue(response.isInitialized)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
