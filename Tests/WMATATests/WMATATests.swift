import Combine
import Foundation
import GTFS
@testable import WMATA
import XCTest

let TEST_API_KEY = "9e38c3eab34c4e6c990828002828f5ed" // Get your own @ https://developer.wmata.com using this one will probably result in some weird behavior

final class RailTests: XCTestCase {
    func testLines() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.lines { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(linesResponse result: Result<LinesResponse, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.lines()

        waitForExpectations(timeout: 1)
    }

    func testEntrances() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.entrances(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stationEntrances result: Result<StationEntrances, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.entrances(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))

        waitForExpectations(timeout: 1)
    }

    func testAllEntrances() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.entrances(at: nil) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stationEntrances result: Result<StationEntrances, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.entrances(at: nil)

        waitForExpectations(timeout: 1)
    }

    func testStations() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.stations(for: .BL) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stations result: Result<Stations, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.stations(for: .BL)

        waitForExpectations(timeout: 1)
    }

    func testStation() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.station(.A01, to: .A02) { result in
            switch result {
            case .success:
                exp.fulfill()

            case let .failure(error):
                print(error)
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testStationWithDelegate() {
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stationToStationInfos result: Result<StationToStationInfos, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.station(.A01, to: .A02)

        waitForExpectations(timeout: 1)
    }

    func testPositions() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.positions { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(trainPositions result: Result<TrainPositions, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.positions()

        waitForExpectations(timeout: 1)
    }

    func testRoutes() {
        let exp = expectation(description: #function)
        let rail = MetroRail(key: TEST_API_KEY)

        rail.routes { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(standardRoutes result: Result<StandardRoutes, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.routes()

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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(trackCircuits result: Result<TrackCircuits, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(elevatorAndEscalatorIncidents result: Result<ElevatorAndEscalatorIncidents, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(railIncidents result: Result<RailIncidents, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(railPredictions result: Result<RailPredictions, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(railPredictions result: Result<RailPredictions, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stationInformation result: Result<StationInformation, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stationsParking result: Result<StationsParking, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(pathBetweenStations result: Result<PathBetweenStations, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stationTimings result: Result<StationTimings, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(alerts _: Result<TransitRealtime_FeedMessage, WMATAError>) {
                expectation.fulfill()
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(tripUpdates _: Result<TransitRealtime_FeedMessage, WMATAError>) {
                expectation.fulfill()
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(vehiclePositions _: Result<TransitRealtime_FeedMessage, WMATAError>) {
                expectation.fulfill()
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let rail = MetroRail(
            key: TEST_API_KEY,
            delegate: delegate
        )

        rail.vehiclePositions()

        waitForExpectations(timeout: 1)
    }
}

final class StationTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Station.A01.name, "Metro Center")
    }

    func testLines() {
        XCTAssertEqual(Station.A01.lines, [.BL, .OR, .SV, .RD])
    }

    func testOpenTimeSaturday() {
        let date = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2020, month: 1, day: 11, hour: 7, minute: 14).date!

        XCTAssertEqual(Station.A01.openingTime(on: date), date)
    }

    func testOpenTimeSunday() {
        let date = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2020, month: 1, day: 12, hour: 8, minute: 14).date!

        XCTAssertEqual(Station.A01.openingTime(on: date), date)
    }

    func testOpenTimeWeekday() {
        let date = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, year: 2020, month: 1, day: 13, hour: 5, minute: 14).date!

        XCTAssertEqual(Station.A01.openingTime(on: date), date)
    }

    func testTogether() {
        XCTAssertEqual(Station.A01.together, Station.C01)
        XCTAssertEqual(Station.C01.together, Station.A01)
        XCTAssertNil(Station.A02.together)
    }

    func testAllTogether() {
        XCTAssertEqual(Station.A01.allTogether, [Station.A01, Station.C01])
        XCTAssertEqual(Station.C01.allTogether, [Station.C01, Station.A01])
        XCTAssertEqual(Station.A02.allTogether, [Station.A02])
    }
}

final class BusTests: XCTestCase {
    func testPositions() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.positions(on: "10A", at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(busPositions result: Result<BusPositions, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.positions(on: "10A", at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))

        waitForExpectations(timeout: 1)
    }

    func testRoutes() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.routes { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(routesResponse result: Result<RoutesResponse, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.routes()

        waitForExpectations(timeout: 1)
    }

    func testSearchStops() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.searchStops(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0))) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stopSearchResponse result: Result<StopsSearchResponse, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.searchStops(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))

        waitForExpectations(timeout: 1)
    }

    func testIncidents() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.incidents(on: "10A") { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(busIncidents result: Result<BusIncidents, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.incidents(on: "10A")

        waitForExpectations(timeout: 1)
    }

    func testPathDetails() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.pathDetails(for: "10A", on: nil) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(pathDetails result: Result<PathDetails, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.pathDetails(for: "10A", on: nil)

        waitForExpectations(timeout: 1)
    }

    func testRouteSchedule() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.routeSchedule(for: "10A", on: nil, includingVariations: true) { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(routeSchedule result: Result<RouteSchedule, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.routeSchedule(for: "10A", on: nil, includingVariations: true)

        waitForExpectations(timeout: 1)
    }

    func testNextBuses() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.nextBuses(for: "1001195") { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(busPredictions result: Result<BusPredictions, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.nextBuses(for: "1001195")

        waitForExpectations(timeout: 1)
    }

    func testSchedule() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.stopSchedule(for: "1001195") { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(stopSchedule result: Result<StopSchedule, WMATAError>) {
                switch result {
                case .success:
                    expectation.fulfill()

                case let .failure(error):
                    print(error)
                }
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.stopSchedule(for: "1001195")

        waitForExpectations(timeout: 1)
    }

    func testAlerts() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.alerts { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(alerts _: Result<TransitRealtime_FeedMessage, WMATAError>) {
                expectation.fulfill()
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.alerts()

        waitForExpectations(timeout: 1)
    }

    func testTripUpdates() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.tripUpdates { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(tripUpdates _: Result<TransitRealtime_FeedMessage, WMATAError>) {
                expectation.fulfill()
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.tripUpdates()

        waitForExpectations(timeout: 1)
    }

    func testVehiclePositions() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        bus.vehiclePositions { result in
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
        class Delegate: WMATADelegate {
            let expectation: XCTestExpectation

            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }

            func received(vehiclePositions _: Result<TransitRealtime_FeedMessage, WMATAError>) {
                expectation.fulfill()
            }
        }

        let delegate = Delegate(
            expectation: expectation(description: #function)
        )
        let bus = MetroBus(
            key: TEST_API_KEY,
            delegate: delegate
        )

        bus.vehiclePositions()

        waitForExpectations(timeout: 1)
    }
}

class CombineTests: XCTestCase {
    // Thanks to eskimo for this solution
    // https://developer.apple.com/forums/thread/121814?answerId=378975022#378975022
    var deferredCancellables = [AnyCancellable]()

    func deferCancellable(_ cancellable: AnyCancellable) {
        deferredCancellables.append(cancellable)
    }

    override func tearDown() {
        deferredCancellables.removeAll()
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
            .entrancesPublisher(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
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

final class BusCombineTests: CombineTests {
    func testPositionsPublisher() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .positionsPublisher(on: "10A", at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
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

    func testSearchStopsPublisher() {
        let exp = expectation(description: #function)
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .searchStopsPublisher(at: RadiusAtCoordinates(radius: 1, coordinates: Coordinates(latitude: 1.0, longitude: 1.0)))
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .incidentsPublisher(on: "10A")
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .pathDetailsPublisher(for: "10A", on: nil)
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .routeSchedulePublisher(for: "10A", on: nil, includingVariations: true)
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .nextBusesPublisher(for: "1001195")
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
            .stopSchedulePublisher(for: "1001195")
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
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
        let bus = MetroBus(key: TEST_API_KEY)

        let cancellable = bus
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
