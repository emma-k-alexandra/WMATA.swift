import XCTest
import Foundation
@testable import WMATA

let TEST_API_KEY = "9e38c3eab34c4e6c990828002828f5ed" // Get your own @ https://developer.wmata.com using this one will probably result in some weird behavior

final class RailTests: XCTestCase {
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
    
}

final class BusTests: XCTestCase {
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
    
}
