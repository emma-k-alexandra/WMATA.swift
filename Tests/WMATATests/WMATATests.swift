import XCTest
import Foundation
@testable import WMATA

let TEST_API_KEY = "9e38c3eab34c4e6c990828002828f5ed" // Get your own @ https://developer.wmata.com using this one will probably result in some weird behavior

final class MetroRailTests: XCTestCase {
    func testRailLines() {
        let exp = self.expectation(description: "testRailLines")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.lines { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailLinesWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(linesResponse result: Result<LinesResponse, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailLinesWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.lines()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailEntrances() {
        let exp = self.expectation(description: "testRailEntrances")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.entrances(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            switch result {
            case .success:
                exp.fulfill()
            
            case.failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailEntrancesWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stationEntrances result: Result<StationEntrances, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailEntrancesWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.entrances(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testAllRailEntrances() {
        let exp = self.expectation(description: "testRailEntrances")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.entrances(at: nil) { result in
            switch result {
            case .success:
                exp.fulfill()
            
            case.failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testAllRailEntrancesWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stationEntrances result: Result<StationEntrances, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testAllRailEntrancesWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.entrances(at: nil)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailStations() {
        let exp = self.expectation(description: "testRailStations")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.stations(for: .BL) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailStationsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stations result: Result<Stations, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailStationsWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.stations(for: .BL)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailStation() {
        let exp = self.expectation(description: "testRailStation")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.station(.A01, to: .A02) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailStationWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }

            func received(stationToStationInfos result: Result<StationToStationInfos, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailStationWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.station(.A01, to: .A02)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailPositions() {
        let exp = self.expectation(description: "testRailPositions")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.positions { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailPositionsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(trainPositions result: Result<TrainPositions, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailStationWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.positions()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailRoutes() {
        let exp = self.expectation(description: "testRailRoutes")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.routes { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailRoutesWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(standardRoutes result: Result<StandardRoutes, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailRoutesWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.routes()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailCircuits() {
        let exp = self.expectation(description: "testRailCircuits")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.circuits { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailCircuitsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(trackCircuits result: Result<TrackCircuits, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailRoutesWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.circuits()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailElevatorAndEscalatorIncidents() {
        let exp = self.expectation(description: "testRailElevatorAndEscalatorIncidents")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.elevatorAndEscalatorIncidents(at: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailElevatorAndEscalatorIncidentsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(elevatorAndEscalatorIncidents result: Result<ElevatorAndEscalatorIncidents, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailElevatorAndEscalatorIncidentsWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.elevatorAndEscalatorIncidents(at: .A01)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailIncidents() {
        let exp = self.expectation(description: "testRailIncidents")
        let rail = MetroRail(key: TEST_API_KEY)
        
        rail.incidents(at: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRailIncidentsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }

            func received(railIncidents result: Result<RailIncidents, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRailIncidentsWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.incidents(at: .A01)
        
        waitForExpectations(timeout: 1)
        
    }

    func testStationNextTrains() {
        let exp = self.expectation(description: "testStationNextTrains")
        let station = MetroRail(key: TEST_API_KEY)
        
        station.nextTrains(at: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationNextTrainsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(railPredictions result: Result<RailPredictions, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testStationNextTrainsWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.nextTrains(at: .A01)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationsNextTrains() {
        let exp = self.expectation(description: "testStationsNextTrains")
        let metroRail = MetroRail(key: TEST_API_KEY)
        
        metroRail.nextTrains(at: [.A01, .A02]) { result in
            switch result {
            case .success:
                exp.fulfill()
            
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationsNextTrainsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(railPredictions result: Result<RailPredictions, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testStationsNextTrainsWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.nextTrains(at: [.A01, .A02])
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationInformation() {
        let exp = self.expectation(description: "testStationInformation")
        let station = MetroRail(key: TEST_API_KEY)
        
        station.information(for: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationInformationWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stationInformation result: Result<StationInformation, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testStationInformationWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.information(for: .A01)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationParkingInformation() {
        let exp = self.expectation(description: "testStationParkingInformation")
        let station = MetroRail(key: TEST_API_KEY)
        
        station.parkingInformation(for: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationParkingInformationWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stationsParking result: Result<StationsParking, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testStationParkingInformationWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.parkingInformation(for: .A01)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationPath() {
        let exp = self.expectation(description: "testStationPath")
        let station = MetroRail(key: TEST_API_KEY)
        
        station.path(from: .A01, to: .A02) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationPathWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(pathBetweenStations result: Result<PathBetweenStations, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testStationPathWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.path(from: .A01, to: .A02)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationTimings() {
        let exp = self.expectation(description: "testStationTimings")
        let station = MetroRail(key: TEST_API_KEY)
        
        station.timings(for: .A01) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStationTimingsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stationTimings result: Result<StationTimings, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testStationPathWithDelegate")
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        rail.timings(for: .A01)
        
        waitForExpectations(timeout: 1)
        
    }
    
}

final class MetroBusTests: XCTestCase {
    func testBusPositions() {
        let exp = self.expectation(description: "testBusPositions")
        let bus = MetroBus(key: TEST_API_KEY)
        
        bus.positions(on: ._10A, at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusPositionsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(busPositions result: Result<BusPositions, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testBusPositionsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.positions(on: ._10A, at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusRoutes() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = MetroBus(key: TEST_API_KEY)
        
        bus.routes { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusRoutesWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(routesResponse result: Result<RoutesResponse, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testBusPositionsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.routes()
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusSearchStops() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = MetroBus(key: TEST_API_KEY)
        
        bus.searchStops(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusSearchStopsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stopSearchResponse result: Result<StopsSearchResponse, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testBusPositionsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.searchStops(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusIncidents() {
        let exp = self.expectation(description: "testBusRoutes")
        let bus = MetroBus(key: TEST_API_KEY)
        
        bus.incidents(on: ._10A) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testBusIncidentsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(busIncidents result: Result<BusIncidents, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testBusPositionsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.incidents(on: ._10A)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRoutePositions() {
        let exp = self.expectation(description: "testRoutePositions")
        let route = MetroBus(key: TEST_API_KEY)
        
        route.positions(on: ._10A, at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRoutePositionsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(busPositions result: Result<BusPositions, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testBusPositionsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.positions(on: ._10A, at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRoutePathDetails() {
        let exp = self.expectation(description: "testRoutePathDetails")
        let route = MetroBus(key: TEST_API_KEY)
        
        route.pathDetails(for: ._10A, on: nil) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRoutePathDetailsWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(pathDetails result: Result<PathDetails, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRoutePathDetailsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.pathDetails(for: ._10A, on: nil)
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRouteSchedule() {
        let exp = self.expectation(description: "testRouteSchedule")
        let route = MetroBus(key: TEST_API_KEY)
        
        route.schedule(for: ._10A, on: nil, includingVariations: true) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testRouteScheduleWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(routeSchedule result: Result<RouteSchedule, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRoutePathDetailsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.schedule(for: ._10A, on: nil, includingVariations: true)
        
        waitForExpectations(timeout: 1)
        
    }

    func testStopNextBuses() {
        let exp = self.expectation(description: "testStopNextBuses")
        let stop = MetroBus(key: TEST_API_KEY)
        
        stop.nextBuses(for: Stop(id: "1001195")) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStopNextBusesWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(busPredictions result: Result<BusPredictions, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRoutePathDetailsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.nextBuses(for: Stop(id: "1001195"))
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStopSchedule() {
        let exp = self.expectation(description: "testStopSchedule")
        let stop = MetroBus(key: TEST_API_KEY)
        
        stop.schedule(for: Stop(id: "1001195")) { result in
            switch result {
            case .success:
                exp.fulfill()
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    func testStopScheduleWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
                
            }
            
            func received(stopSchedule result: Result<StopSchedule, WMATAError>) {
                switch result {
                case .success:
                    self.expectation.fulfill()
                
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
        
        let delegate = Delegate(
            expectation: self.expectation(description: "testRoutePathDetailsWithDelegate")
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )
        
        bus.schedule(for: Stop(id: "1001195"))
        
        waitForExpectations(timeout: 1)
        
    }
    
}
