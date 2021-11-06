//
//  TestBus.swift
//  
//
//  Created by Emma on 11/6/21.
//

@testable import WMATA
import XCTest

//final class BusTests: XCTestCase {
//    func testPositions() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.positions(on: "10A", at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testPositionsWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(busPositions result: Result<BusPositions, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.positions(on: "10A", at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRoutes() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.routes { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRoutesWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(routesResponse result: Result<RoutesResponse, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.routes()
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testSearchStops() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.searchStops(at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testSearchStopsWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(stopSearchResponse result: Result<StopsSearchResponse, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.searchStops(at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testIncidents() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.incidents(on: "10A") { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testIncidentsWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(busIncidents result: Result<BusIncidents, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.incidents(on: "10A")
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testPathDetails() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.pathDetails(for: "10A", on: nil) { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testPathDetailsWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(pathDetails result: Result<PathDetails, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.pathDetails(for: "10A", on: nil)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRouteSchedule() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.routeSchedule(for: "10A", on: nil, includingVariations: true) { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRouteScheduleWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(routeSchedule result: Result<RouteSchedule, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.routeSchedule(for: "10A", on: nil, includingVariations: true)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testNextBuses() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.nextBuses(for: "1001195") { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testNextBusesWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(busPredictions result: Result<BusPredictions, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.nextBuses(for: "1001195")
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testSchedule() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.stopSchedule(for: "1001195") { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testScheduleWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(stopSchedule result: Result<StopSchedule, WMATAError>) {
//                switch result {
//                case .success:
//                    expectation.fulfill()
//
//                case let .failure(error):
//                    print(error)
//                }
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.stopSchedule(for: "1001195")
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testAlerts() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.alerts { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testAlertsWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(alerts _: Result<TransitRealtime_FeedMessage, WMATAError>) {
//                expectation.fulfill()
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.alerts()
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testTripUpdates() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.tripUpdates { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testTripUpdatesWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(tripUpdates _: Result<TransitRealtime_FeedMessage, WMATAError>) {
//                expectation.fulfill()
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.tripUpdates()
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testVehiclePositions() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        bus.vehiclePositions { result in
//            switch result {
//            case .success:
//                exp.fulfill()
//
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testVehiclePositionsWithDelegate() {
//        class Delegate: WMATADelegate {
//            let expectation: XCTestExpectation
//
//            init(expectation: XCTestExpectation) {
//                self.expectation = expectation
//            }
//
//            func received(vehiclePositions _: Result<TransitRealtime_FeedMessage, WMATAError>) {
//                expectation.fulfill()
//            }
//        }
//
//        let delegate = Delegate(
//            expectation: expectation(description: #function)
//        )
//        let bus = MetroBus(
//            key: TEST_API_KEY,
//            delegate: delegate
//        )
//
//        bus.vehiclePositions()
//
//        waitForExpectations(timeout: 1)
//    }
//}
//
//final class BusCombineTests: CombineTests {
//    func testPositionsPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .positionsPublisher(on: "10A", at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRoutesPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .routesPublisher()
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testSearchStopsPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .searchStopsPublisher(at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testIncidentsPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .incidentsPublisher(on: "10A")
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testPathDetailsPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .pathDetailsPublisher(for: "10A", on: nil)
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRouteSchedulePublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .routeSchedulePublisher(for: "10A", on: nil, includingVariations: true)
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testNextBusesPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .nextBusesPublisher(for: "1001195")
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testSchedulePublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .stopSchedulePublisher(for: "1001195")
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testAlertsPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .alertsPublisher()
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testTripUpdatesPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .tripUpdatesPublisher()
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testVehiclePositionsPublisher() {
//        let exp = expectation(description: #function)
//        let bus = MetroBus(key: TEST_API_KEY)
//
//        let cancellable = bus
//            .vehiclePositionsPublisher()
//            .sink(
//                receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        exp.fulfill()
//                    case let .failure(failure):
//                        print(failure)
//                    }
//                },
//                receiveValue: { _ in }
//            )
//
//        deferCancellable(cancellable)
//
//        waitForExpectations(timeout: 1)
//    }
//
//    func testRadiusAtCoordinatesLatLongInit() {
//        let radius = WMATALocation(radius: 1, latitude: 1.0, longitude: 1.0)
//        XCTAssertEqual(radius.coordinates.latitude, 1.0)
//        XCTAssertEqual(radius.coordinates.longitude, 1.0)
//    }
//}
