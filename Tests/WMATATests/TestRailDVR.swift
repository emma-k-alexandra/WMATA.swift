//
//  TestRailDVR.swift
//  
//
//  Created by Emma on 12/12/21.
//

@testable import WMATA
import XCTest

final class TestRailDVR: DVRTestCase {
    func testLines() {
        let lines = Rail.Lines(key: TEST_API_KEY)
    
        lines.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.lines.count, 6)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testEntrances() {
        let entrances = Rail.StationEntrances(
            key: TEST_API_KEY,
            location: .init(
                radius: 20_000,
                coordinates: .init(
                    latitude: 38.876736,
                    longitude: -76.724502
                )
            )
        )
    
        entrances.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.entrances.count, 24)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testAllEntrances() {
        let entrances = Rail.StationEntrances(
            key: TEST_API_KEY
        )
    
        entrances.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.entrances.count, 246)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStations() {
        let stations = Rail.Stations(
            key: TEST_API_KEY,
            line: .blue
        )
    
        stations.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stations.count, 27)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testAllStations() {
        let stations = Rail.Stations(
            key: TEST_API_KEY
        )
    
        stations.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stations.count, 95)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationToStation() {
        let stations = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper,
            destinationStation: .farragutNorth
        )
    
        stations.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stationToStationInfos.first?.compositeMiles, 0.75)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationToStationNoStart() {
        let stations = Rail.StationToStation(
            key: TEST_API_KEY,
            destinationStation: .farragutNorth
        )
    
        stations.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stationToStationInfos.first?.railFare.seniorDisabled, 1.1)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationToStationNoDestination() {
        let stations = Rail.StationToStation(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )
    
        stations.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stationToStationInfos.first?.railFare.seniorDisabled, 1.1)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationToStationAll() {
        let stations = Rail.StationToStation(
            key: TEST_API_KEY
        )
    
        stations.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stationToStationInfos.count, 8922)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPositions() {
        let positions = Rail.TrainPositions(
            key: TEST_API_KEY
        )
    
        positions.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.trainPositions.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStandardRoutes() {
        let positions = Rail.StandardRoutes(
            key: TEST_API_KEY
        )
    
        positions.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.standardRoutes.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testTrackCircuits() {
        let circuits = Rail.TrackCircuits(
            key: TEST_API_KEY
        )
    
        circuits.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.trackCircuits.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testElevatorAndEscalatorIncidents() {
        let incidents = Rail.ElevatorAndEscalatorIncidents(
            key: TEST_API_KEY,
            station: .shadyGrove
        )
    
        incidents.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.incidents.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testElevatorAndEscalatorIncidentsAll() {
        let incidents = Rail.ElevatorAndEscalatorIncidents(
            key: TEST_API_KEY
        )
    
        incidents.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.incidents.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testIncidents() {
        let incidents = Rail.Incidents(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )
    
        incidents.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.incidents.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testIncidentsAll() {
        let incidents = Rail.Incidents(
            key: TEST_API_KEY
        )
    
        incidents.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.incidents.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testNextTrains() {
        let nextTrains = Rail.NextTrains(
            key: TEST_API_KEY,
            station: .metroCenterUpper
        )
    
        nextTrains.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.trains.first?.location, .metroCenterUpper)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testNextTrainsMultipleStations() {
        let nextTrains = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: .fortTotten
        )
    
        nextTrains.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.trains.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testNextTrainsAll() {
        let nextTrains = Rail.NextTrains(
            key: TEST_API_KEY,
            stations: .all
        )
    
        nextTrains.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.trains.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationInformation() {
        let information = Rail.StationInformation(
            key: TEST_API_KEY,
            station: .mcphersonSquare
        )
    
        information.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.name, "McPhearson Square")
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testParkingInformation() {
        let information = Rail.ParkingInformation(
            key: TEST_API_KEY,
            station: .eastFallsChurch
        )
    
        information.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stationsParking.first?.station,.eastFallsChurch)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testPath() {
        let path = Rail.PathBetweenStations(
            key: TEST_API_KEY,
            startingStation: .eastFallsChurch,
            destinationStation: .dunnLoring
        )
    
        path.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.path.first?.station,.eastFallsChurch)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationTimings() {
        let timings = Rail.StationTimings(
            key: TEST_API_KEY,
            station: .anacostia
        )
    
        timings.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.stationTimes.first?.station,.anacostia)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testStationTimingsAll() {
        let timings = Rail.StationTimings(
            key: TEST_API_KEY
        )
    
        timings.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.stationTimes.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

final class TestRailGTFSDVR: DVRTestCase {
    func testAlerts() {
        let alerts = Rail.GTFS.Alerts(key: TEST_API_KEY)
    
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
        let tripUpdates = Rail.GTFS.TripUpdates(key: TEST_API_KEY)
    
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
        let vehiclePositions = Rail.GTFS.VehiclePositions(key: TEST_API_KEY)
    
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

final class TestRailAsyncDVR: DVRTestCase {
    func testLines() async {
        let lines = Rail.Lines(key: TEST_API_KEY)
        
        let result = await lines.request(with: session)
        
        switch result {
        case let .success(response):
            XCTAssertEqual(response.lines.count, 6)
        case let .failure(error):
            print(error)
            XCTFail()
        }
    }
}
