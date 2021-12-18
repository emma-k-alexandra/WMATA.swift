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

final class RailTests: XCTestCase {
    func testLines() {
        let exp = expectation(description: name)
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
        let delegate = TestJSONDelegate<Rail.Lines>(expectation: expectation(description: name))

        let lines = Rail.Lines(
            key: TEST_API_KEY,
            delegate: delegate
        )

        lines.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testEntrances() {
        let exp = expectation(description: name)
        let entrances = Rail.StationEntrances(
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
        let delegate = TestJSONDelegate<Rail.StationEntrances>(expectation: expectation(description: name))

        let entrances = Rail.StationEntrances(
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

            entrances.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testAllEntrances() {
        let exp = expectation(description: name)
        let entrances = Rail.StationEntrances(key: TEST_API_KEY)

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
        let delegate = TestJSONDelegate<Rail.StationEntrances>(expectation: expectation(description: name))

        let entrances = Rail.StationEntrances(
            key: TEST_API_KEY,
            delegate: delegate
        )

        entrances.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testStations() {
        let exp = expectation(description: name)
        let stations = Rail.Stations(
            key: TEST_API_KEY,
            line: .blue
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
        let delegate = TestJSONDelegate<Rail.Stations>(expectation: expectation(description: name))

        let stations = Rail.Stations(
            key: TEST_API_KEY,
            line: .blue,
            delegate: delegate
        )

        stations.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testAllStations() {
        let exp = expectation(description: name)
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
        let delegate = TestJSONDelegate<Rail.Stations>(expectation: expectation(description: name))

        let stations = Rail.Stations(
            key: TEST_API_KEY,
            delegate: delegate
        )

        stations.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testStationToStation() {
        let exp = expectation(description: name)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            destinationStation: .farragutNorth
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
        let delegate = TestJSONDelegate<Rail.StationToStation>(expectation: expectation(description: name))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            destinationStation: .farragutNorth,
            delegate: delegate
        )

        stationToStation.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testStationToStationNoStart() {
        let exp = expectation(description: name)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: .farragutNorth
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
        let delegate = TestJSONDelegate<Rail.StationToStation>(expectation: expectation(description: name))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: .farragutNorth,
            delegate: delegate
        )

        stationToStation.backgroundRequest()

        waitForExpectations(timeout: 1)
    }
    
    func testStationToStationNoDestination() {
        let exp = expectation(description: name)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper
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
        let delegate = TestJSONDelegate<Rail.StationToStation>(expectation: expectation(description: name))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            destinationStation: nil,
            delegate: delegate
        )

        stationToStation.backgroundRequest()

        waitForExpectations(timeout: 1)
    }
    
    func testStationToStationAll() {
        let exp = expectation(description: name)
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
        let delegate = TestJSONDelegate<Rail.StationToStation>(expectation: expectation(description: name))

        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: nil,
            destinationStation: nil,
            delegate: delegate
        )

        stationToStation.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testPositions() {
        let exp = expectation(description: name)
        let positions = Rail.TrainPositions(key: TEST_API_KEY)

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
        let delegate = TestJSONDelegate<Rail.TrainPositions>(expectation: expectation(description: name))

        let positions = Rail.TrainPositions(
            key: TEST_API_KEY,
            delegate: delegate
        )

        positions.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testRoutes() {
        let exp = expectation(description: name)
        let routes = Rail.StandardRoutes(key: TEST_API_KEY)

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
        let delegate = TestJSONDelegate<Rail.StandardRoutes>(expectation: expectation(description: name))

        let routes = Rail.StandardRoutes(
            key: TEST_API_KEY,
            delegate: delegate
        )

        routes.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testCircuits() {
        let exp = expectation(description: name)
        let circuits = Rail.TrackCircuits(key: TEST_API_KEY)

        circuits.request { result in
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
        let delegate = TestJSONDelegate<Rail.TrackCircuits>(expectation: expectation(description: name))

        let circuits = Rail.TrackCircuits(
            key: TEST_API_KEY,
            delegate: delegate
        )

        circuits.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testElevatorAndEscalatorIncidents() {
        let exp = expectation(description: name)
        let incidents = Rail.ElevatorAndEscalatorIncidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper
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

    func testElevatorAndEscalatorIncidentsWithDelegate() {
        let delegate = TestJSONDelegate<Rail.ElevatorAndEscalatorIncidents>(expectation: expectation(description: name))

        let incidents = Rail.ElevatorAndEscalatorIncidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            delegate: delegate
        )

        incidents.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testIncidents() {
        let exp = expectation(description: name)
        let incidents = Rail.Incidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper
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
        let delegate = TestJSONDelegate<Rail.Incidents>(expectation: expectation(description: name))

        let incidents = Rail.Incidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            delegate: delegate
        )

        incidents.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testNextTrain() {
        let exp = expectation(description: name)
        let predictions = Rail.NextTrains(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        predictions.request { result in
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
        let delegate = TestJSONDelegate<Rail.NextTrains>(expectation: expectation(description: name))

        let predictions = Rail.NextTrains(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            delegate: delegate
        )

        predictions.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testNextTrains() {
        let exp = expectation(description: name)
        let predictions = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: [.metroCenterUpper, .farragutNorth]
        )

        predictions.request { result in
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
        let delegate = TestJSONDelegate<Rail.NextTrains>(expectation: expectation(description: name))

        let predictions = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: [.metroCenterUpper, .farragutNorth],
            delegate: delegate
        )

        predictions.backgroundRequest()

        waitForExpectations(timeout: 1)
    }
    
    func testNextTrainsAll() {
        let exp = expectation(description: name)
        let predictions = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: .all
        )

        predictions.request { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testNextTrainsAllWithDelegate() {
        let delegate = TestJSONDelegate<Rail.NextTrains>(expectation: expectation(description: name))

        let predictions = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: .all,
            delegate: delegate
        )

        predictions.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testInformation() {
        let exp = expectation(description: name)
        let information = Rail.StationInformation(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        information.request { result in
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
        let delegate = TestJSONDelegate<Rail.StationInformation>(expectation: expectation(description: name))

        let information = Rail.StationInformation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            delegate: delegate
        )

        information.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testParkingInformation() {
        let exp = expectation(description: name)
        let information = Rail.ParkingInformation(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        information.request { result in
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
        let delegate = TestJSONDelegate<Rail.ParkingInformation>(expectation: expectation(description: name))

        let information = Rail.ParkingInformation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            delegate: delegate
        )

        information.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testPath() {
        let exp = expectation(description: name)
        let path = Rail.PathBetweenStations(
            key: TEST_API_KEY,
            startingStation: .metroCenterUpper,
            destinationStation: .farragutNorth
        )

        path.request { result in
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
        let delegate = TestJSONDelegate<Rail.PathBetweenStations>(expectation: expectation(description: name))

        let path = Rail.PathBetweenStations(
            key: TEST_API_KEY,
            startingStation: .metroCenterUpper,
            destinationStation: .farragutNorth,
            delegate: delegate
        )
        
        path.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testTimings() {
        let exp = expectation(description: name)
        let timings = Rail.StationTimings(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        timings.request { result in
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
        let delegate = TestJSONDelegate<Rail.StationTimings>(expectation: expectation(description: name))

        let timings = Rail.StationTimings(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            delegate: delegate
        )

        timings.backgroundRequest()

        waitForExpectations(timeout: 1)
    }
}

final class RailGTFSTests: XCTestCase {
    func testAlerts() {
        let exp = expectation(description: name)
        let alerts = Rail.GTFS.Alerts(
            key: TEST_API_KEY)

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
        let delegate = TestGTFSDelegate<Rail.GTFS.Alerts>(expectation: expectation(description: name))

        let alerts = Rail.GTFS.Alerts(
            key: TEST_API_KEY,
            delegate: delegate
        )

        alerts.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testTripUpdates() {
        let exp = expectation(description: name)
        let tripUpdates = Rail.GTFS.TripUpdates(key: TEST_API_KEY)

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
        let delegate = TestGTFSDelegate<Rail.GTFS.TripUpdates>(expectation: expectation(description: name))

        let tripUpdates = Rail.GTFS.TripUpdates(
            key: TEST_API_KEY,
            delegate: delegate
        )

        tripUpdates.backgroundRequest()

        waitForExpectations(timeout: 1)
    }

    func testVehiclePositions() {
        let exp = expectation(description: name)
        let vehiclePositions = Rail.GTFS.VehiclePositions(key: TEST_API_KEY)

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
        let delegate = TestGTFSDelegate<Rail.GTFS.VehiclePositions>(expectation: expectation(description: name))

        let vehiclePositions = Rail.GTFS.VehiclePositions(
            key: TEST_API_KEY,
            delegate: delegate
        )

        vehiclePositions.backgroundRequest()

        waitForExpectations(timeout: 1)
    }
}

final class RailCombineTests: CombineTests {
    func testLinesPublisher() {
        let exp = expectation(description: name)
        let lines = Rail.Lines(key: TEST_API_KEY)

        let cancellable = lines
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

    func testEntrancesPublisher() {
        let exp = expectation(description: name)
        let entrances = Rail.StationEntrances(
            key: TEST_API_KEY,
            location: .init(
                radius: 1,
                coordinates: .init(
                    latitude: 1.0,
                    longitude: 1.0
                )
            )
        )

        let cancellable = entrances
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

    func testStationsPublisher() {
        let exp = expectation(description: name)
        let stations = Rail.Stations(
            key: TEST_API_KEY,
            line: .blue
        )

        let cancellable = stations
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

    func testStationPublisher() {
        let exp = expectation(description: name)
        let stationToStation = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            destinationStation: .farragutNorth
        )

        let cancellable = stationToStation
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

    func testPositionsPublisher() {
        let exp = expectation(description: name)
        let positions = Rail.TrainPositions(key: TEST_API_KEY)

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
        let exp = expectation(description: name)
        let routes = Rail.StandardRoutes(key: TEST_API_KEY)

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

    func testCircuitsPublisher() {
        let exp = expectation(description: name)
        let circuits = Rail.TrackCircuits(key: TEST_API_KEY)

        let cancellable = circuits
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

    func testElevatorAndEscalatorIncidentsPublisher() {
        let exp = expectation(description: name)
        let incidents = Rail.ElevatorAndEscalatorIncidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper
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

    func testIncidentsPublisher() {
        let exp = expectation(description: name)
        let incidents = Rail.Incidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper
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

    func testNextTrainPublisher() {
        let exp = expectation(description: name)
        let nextTrains = Rail.NextTrains(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        let cancellable = nextTrains
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

    func testNextTrainsPublisher() {
        let exp = expectation(description: name)
        let nextTrains = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: [.metroCenterUpper, .farragutNorth]
        )

        let cancellable = nextTrains
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

    func testInformationPublisher() {
        let exp = expectation(description: name)
        let stationInformation = Rail.StationInformation(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        let cancellable = stationInformation
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

    func testParkingInformationPublisher() {
        let exp = expectation(description: name)
        let parkingInformation = Rail.ParkingInformation(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        let cancellable = parkingInformation
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

    func testPathPublisher() {
        let exp = expectation(description: name)
        let path = Rail.PathBetweenStations(
            key: TEST_API_KEY,
            startingStation: .metroCenterUpper,
            destinationStation: .farragutNorth
        )

        let cancellable = path
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

    func testTimingsPublisher() {
        let exp = expectation(description: name)
        let timings = Rail.StationTimings(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )

        let cancellable = timings
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

final class RailGTFSCombineTests: CombineTests {
    func testAlertsPublisher() {
        let exp = expectation(description: name)
        let alerts = Rail.GTFS.Alerts(key: TEST_API_KEY)

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
        let exp = expectation(description: name)
        let tripUpdates = Rail.GTFS.TripUpdates(key: TEST_API_KEY)

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
        let exp = expectation(description: name)
        let vehiclePositions = Rail.GTFS.VehiclePositions(key: TEST_API_KEY)

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
