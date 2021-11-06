//
//  TestRail.swift
//  
//
//  Created by Emma on 11/6/21.
//

import Combine
import Foundation
import GTFS
@testable import WMATA
import XCTest

class TestDelegate: EndpointDelegate {
    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    func received<Response>(_ result: Result<Response, WMATAError>)
    where
        Response: Codable
    {
        switch result {
        case .success:
            expectation.fulfill()

        case let .failure(error):
            print(error)
        }
    }
}

final class RailTests: XCTestCase {
    func testLines() {
        let exp = expectation(description: #function)
        let lines = Rail.Lines(key: TEST_API_KEY)
        
        lines.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testLinesWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let lines = Rail.Lines(
            key: TEST_API_KEY,
            delegate: delegate
        )

        lines.request()

        waitForExpectations(timeout: 1)
    }

    func testEntrances() {
        let exp = expectation(description: #function)
        let entrances = Rail.Entrances(
            key: TEST_API_KEY,
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            )
        )

        entrances.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testEntrancesWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let entrances = Rail.Entrances(
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

            entrances.request()

        waitForExpectations(timeout: 1)
    }

    func testAllEntrances() {
        let exp = expectation(description: #function)
        let entrances = Rail.Entrances(key: TEST_API_KEY)

        entrances.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testAllEntrancesWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let entrances = Rail.Entrances(
            key: TEST_API_KEY,
            delegate: delegate
        )

        entrances.request()

        waitForExpectations(timeout: 1)
    }

    func testStations() {
        let exp = expectation(description: #function)
        let stations = Rail.Stations(
            key: TEST_API_KEY,
            line: .BL
        )

        stations.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testStationsWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let stations = Rail.Stations(
            key: TEST_API_KEY,
            line: .BL,
            delegate: delegate
        )

        stations.request()

        waitForExpectations(timeout: 1)
    }

    func testAllStations() {
        let exp = expectation(description: #function)
        let stations = Rail.Stations(key: TEST_API_KEY)

        stations.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testAllStationsWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let stations = Rail.Stations(
            key: TEST_API_KEY,
            delegate: delegate
        )

        stations.request()

        waitForExpectations(timeout: 1)
    }

    func testStationToStation() {
        let exp = expectation(description: #function)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .A01,
            destinationStation: .A02
        )

        stationToStation.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testStationToStationWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .A01,
            destinationStation: .A02,
            delegate: delegate
        )

        stationToStation.request()

        waitForExpectations(timeout: 1)
    }

    func testStationToStationNoStart() {
        let exp = expectation(description: #function)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: .A02
        )

        stationToStation.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testStationToStationNoStartWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: .A02,
            delegate: delegate
        )

        stationToStation.request()

        waitForExpectations(timeout: 1)
    }
    
    func testStationToStationNoDestination() {
        let exp = expectation(description: #function)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .A01,
            destinationStation: nil
        )

        stationToStation.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testStationToStationNoDestinationWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .A01,
            destinationStation: nil,
            delegate: delegate
        )

        stationToStation.request()

        waitForExpectations(timeout: 1)
    }
    
    func testStationToStationAll() {
        let exp = expectation(description: #function)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: nil
        )

        stationToStation.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testStationToStationAllWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: nil,
            delegate: delegate
        )

        stationToStation.request()

        waitForExpectations(timeout: 1)
    }

    func testPositions() {
        let exp = expectation(description: #function)
        let positions = Rail.Positions(key: TEST_API_KEY)

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
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let positions = Rail.Positions(
            key: TEST_API_KEY,
            delegate: delegate
        )

        positions.request()

        waitForExpectations(timeout: 1)
    }

    func testRoutes() {
        let exp = expectation(description: #function)
        let routes = Rail.Routes(key: TEST_API_KEY)

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
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let routes = Rail.Routes(
            key: TEST_API_KEY,
            delegate: delegate
        )

        routes.request()

        waitForExpectations(timeout: 1)
    }

    func testCircuits() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.circuits { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testCircuitsWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.circuits()

        waitForExpectations(timeout: 1)
    }

    func testElevatorAndEscalatorIncidents() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.elevatorAndEscalatorIncidents(at: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testElevatorAndEscalatorIncidentsWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.elevatorAndEscalatorIncidents(at: .A01)

        waitForExpectations(timeout: 1)
    }

    func testIncidents() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.incidents(at: .A01) { result in
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
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.incidents(at: .A01)

        waitForExpectations(timeout: 1)
    }

    func testNextTrain() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.nextTrains(at: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testNextTrainWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.nextTrains(at: .A01)

        waitForExpectations(timeout: 1)
    }

    func testNextTrains() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.nextTrains(at: [.A01, .A02]) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testNextTrainsWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.nextTrains(at: [.A01, .A02])

        waitForExpectations(timeout: 1)
    }

    func testInformation() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.information(for: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testInformationWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.information(for: .A01)

        waitForExpectations(timeout: 1)
    }

    func testParkingInformation() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.parkingInformation(for: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testParkingInformationWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.parkingInformation(for: .A01)

        waitForExpectations(timeout: 1)
    }

    func testPath() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.path(from: .A01, to: .A02) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testPathWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.path(from: .A01, to: .A02)

        waitForExpectations(timeout: 1)
    }

    func testTimings() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.timings(for: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testTimingsWithDelegate() {
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.timings(for: .A01)

        waitForExpectations(timeout: 1)
    }

    func testAlerts() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.alerts { result in
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
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.alerts()

        waitForExpectations(timeout: 1)
    }

    func testTripUpdates() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.tripUpdates { result in
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
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.tripUpdates()

        waitForExpectations(timeout: 1)
    }

    func testVehiclePositions() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.vehiclePositions { result in
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
        let delegate = TestDelegate(expectation: expectation(description: #function))

        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.vehiclePositions()

        waitForExpectations(timeout: 1)
    }
}

final class RailCombineTests: CombineTests {
    func testLinesPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .linesPublisher()
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

    func testEntrancesPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .entrancesPublisher(at: WMATALocation(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
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

    func testStationsPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .stationsPublisher(for: .BL)
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

    func testStationPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .stationPublisher(.A01, to: .A02)
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

    func testPositionsPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .positionsPublisher()
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
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .routesPublisher()
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

    func testCircuitsPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .circuitsPublisher()
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

    func testElevatorAndEscalatorIncidentsPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .elevatorAndEscalatorIncidentsPublisher(at: .A01)
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
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .incidentsPublisher(at: .A01)
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

    func testNextTrainPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .nextTrainsPublisher(at: .A01)
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

    func testNextTrainsPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .nextTrainsPublisher(at: [.A01, .A02])
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

    func testInformationPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .informationPublisher(for: .A01)
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

    func testParkingInformationPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .parkingInformationPublisher(for: .A01)
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

    func testPathPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .pathPublisher(from: .A01, to: .A02)
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

    func testTimingsPublisher() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .timingsPublisher(for: .A01)
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
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .alertsPublisher()
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
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .tripUpdatesPublisher()
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
        let rail = MetroRail(key: TEST_API_KEY)

        let cancellable = rail
            .vehiclePositionsPublisher()
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
