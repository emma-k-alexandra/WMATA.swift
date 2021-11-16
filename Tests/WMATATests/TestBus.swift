//
//  TestBus.swift
//  
//
//  Created by Emma on 11/6/21.
//

@testable import WMATA
import XCTest

final class BusTests: XCTestCase {
    func testPositions() {
        let exp = expectation(description: #function)
        let positions = Bus.Positions(
            key: TEST_API_KEY,
            route: "10A",
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            )
        )

        positions.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testPositionsWithDelegate() {
        let delegate = TestJSONDelegate<Bus.Positions>(expectation: expectation(description: #function))
        
        let positions = Bus.Positions(
            key: TEST_API_KEY,
            route: "10A",
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            ),
            delegate: delegate
        )
        
        positions.request()

        waitForExpectations(timeout: 1)
    }

    func testRoutes() {
        let exp = expectation(description: #function)
        let routes = Bus.Routes(key: TEST_API_KEY)

        routes.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testRoutesWithDelegate() {
        let delegate = TestJSONDelegate<Bus.Routes>(expectation: expectation(description: #function))
        
        let routes = Bus.Routes(
            key: TEST_API_KEY,
            delegate: delegate
        )

        routes.request()

        waitForExpectations(timeout: 1)
    }

    func testSearchStops() {
        let exp = expectation(description: #function)
        let stopsSearch = Bus.StopsSearch(
            key: TEST_API_KEY,
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            )
        )

        stopsSearch.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testSearchStopsWithDelegate() {
        let delegate = TestJSONDelegate<Bus.StopsSearch>(expectation: expectation(description: #function))
        
        let stopsSearch = Bus.StopsSearch(
            key: TEST_API_KEY,
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            ),
            delegate: delegate
        )

        stopsSearch.request()

        waitForExpectations(timeout: 1)
    }

    func testIncidents() {
        let exp = expectation(description: #function)
        let incidents = Bus.Incidents(
            key: TEST_API_KEY,
            route: "10A"
        )

        incidents.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testIncidentsWithDelegate() {
        let delegate = TestJSONDelegate<Bus.Incidents>(expectation: expectation(description: #function))
        
        let incidents = Bus.Incidents(
            key: TEST_API_KEY,
            route: "10A",
            delegate: delegate
        )

        incidents.request()

        waitForExpectations(timeout: 1)
    }

    func testPathDetails() {
        let exp = expectation(description: #function)
        let pathDetails = Bus.PathDetails(
            key: TEST_API_KEY,
            route: "10A"
        )

        pathDetails.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testPathDetailsWithDelegate() {
        let delegate = TestJSONDelegate<Bus.PathDetails>(expectation: expectation(description: #function))
        
        let pathDetails = Bus.PathDetails(
            key: TEST_API_KEY,
            route: "10A",
            delegate: delegate
        )

        pathDetails.request()

        waitForExpectations(timeout: 1)
    }

    func testRouteSchedule() {
        let exp = expectation(description: #function)
        let routeSchedule = Bus.RouteSchedule(
            key: TEST_API_KEY,
            route: "10A",
            includingVariations: true
        )

        routeSchedule.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testRouteScheduleWithDelegate() {
        let delegate = TestJSONDelegate<Bus.RouteSchedule>(expectation: expectation(description: #function))
        
        let routeSchedule = Bus.RouteSchedule(
            key: TEST_API_KEY,
            route: "10A",
            includingVariations: true,
            delegate: delegate
        )

        routeSchedule.request()

        waitForExpectations(timeout: 1)
    }

    func testNextBuses() {
        let exp = expectation(description: #function)
        let nextBuses = Bus.NextBuses(
            key: TEST_API_KEY,
            stop: "1001195"
        )

        nextBuses.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testNextBusesWithDelegate() {
        let delegate = TestJSONDelegate<Bus.NextBuses>(expectation: expectation(description: #function))
        
        let nextBuses = Bus.NextBuses(
            key: TEST_API_KEY,
            stop: "1001195",
            delegate: delegate
        )

        nextBuses.request()

        waitForExpectations(timeout: 1)
    }

    func testSchedule() {
        let exp = expectation(description: #function)
        let stopSchedule = Bus.StopSchedule(
            key: TEST_API_KEY,
            stop: "1001195"
        )

        stopSchedule.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testScheduleWithDelegate() {
        let delegate = TestJSONDelegate<Bus.StopSchedule>(expectation: expectation(description: #function))
        
        let stopSchedule = Bus.StopSchedule(
            key: TEST_API_KEY,
            stop: "1001195",
            delegate: delegate
        )

        stopSchedule.request()

        waitForExpectations(timeout: 1)
    }

    func testAlerts() {
        let exp = expectation(description: #function)
        let alerts = Bus.Alerts(key: TEST_API_KEY)

        alerts.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testAlertsWithDelegate() {
        let delegate = TestGTFSDelegate<Bus.Alerts>(expectation: expectation(description: #function))
        
        let alerts = Bus.Alerts(
            key: TEST_API_KEY,
            delegate: delegate
        )

        alerts.request()

        waitForExpectations(timeout: 1)
    }

    func testTripUpdates() {
        let exp = expectation(description: #function)
        let tripUpdates = Bus.TripUpdates(key: TEST_API_KEY)

        tripUpdates.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testTripUpdatesWithDelegate() {
        let delegate = TestGTFSDelegate<Bus.TripUpdates>(expectation: expectation(description: #function))
        
        let tripUpdates = Bus.TripUpdates(
            key: TEST_API_KEY,
            delegate: delegate
        )

        tripUpdates.request()

        waitForExpectations(timeout: 1)
    }

    func testVehiclePositions() {
        let exp = expectation(description: #function)
        let vehiclePositions = Bus.VehiclePositions(key: TEST_API_KEY)

        vehiclePositions.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testVehiclePositionsWithDelegate() {
        let delegate = TestGTFSDelegate<Bus.VehiclePositions>(expectation: expectation(description: #function))
        
        let vehiclePositions = Bus.VehiclePositions(
            key: TEST_API_KEY,
            delegate: delegate
        )

        vehiclePositions.request()

        waitForExpectations(timeout: 1)
    }
}

final class BusCombineTests: CombineTests {
    func testPositionsPublisher() {
        let exp = expectation(description: #function)
        let positions = Bus.Positions(
            key: TEST_API_KEY,
            route: "10A",
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            )
        )

        let cancellable = positions
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testRoutesPublisher() {
        let exp = expectation(description: #function)
        let routes = Bus.Routes(key: TEST_API_KEY)

        let cancellable = routes
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testSearchStopsPublisher() {
        let exp = expectation(description: #function)
        let stopsSearch = Bus.StopsSearch(
            key: TEST_API_KEY,
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            )
        )

        let cancellable = stopsSearch
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testIncidentsPublisher() {
        let exp = expectation(description: #function)
        let incidents = Bus.Incidents(
            key: TEST_API_KEY,
            route: "10A"
        )

        let cancellable = incidents
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testPathDetailsPublisher() {
        let exp = expectation(description: #function)
        let pathDetails = Bus.PathDetails(
            key: TEST_API_KEY,
            route: "10A"
        )

        let cancellable = pathDetails
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testRouteSchedulePublisher() {
        let exp = expectation(description: #function)
        let routeSchedule = Bus.RouteSchedule(
            key: TEST_API_KEY,
            route: "10A",
            includingVariations: true
        )

        let cancellable = routeSchedule
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testNextBusesPublisher() {
        let exp = expectation(description: #function)
        let nextBuses = Bus.NextBuses(
            key: TEST_API_KEY,
            stop: "1001195"
        )

        let cancellable = nextBuses
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testSchedulePublisher() {
        let exp = expectation(description: #function)
        let stopSchedule = Bus.StopSchedule(
            key: TEST_API_KEY,
            stop: "1001195"
        )

        let cancellable = stopSchedule
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testAlertsPublisher() {
        let exp = expectation(description: #function)
        let alerts = Bus.Alerts(key: TEST_API_KEY)

        let cancellable = alerts
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testTripUpdatesPublisher() {
        let exp = expectation(description: #function)
        let tripUpdates = Bus.TripUpdates(key: TEST_API_KEY)

        let cancellable = tripUpdates
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }

    func testVehiclePositionsPublisher() {
        let exp = expectation(description: #function)
        let vehiclePositions = Bus.VehiclePositions(key: TEST_API_KEY)

        let cancellable = vehiclePositions
            .publisher()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        exp.fulfill()
                    case let .failure(failure):
                        print(failure)
                    }
                },
                receiveValue: { _ in }
            )

        deferCancellable(cancellable)

        waitForExpectations(timeout: 1)
    }
}
