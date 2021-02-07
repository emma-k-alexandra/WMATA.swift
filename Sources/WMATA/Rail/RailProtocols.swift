//
//  RailProtocols.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Combine
import Foundation

protocol NeedsStation: Fetcher {}

extension NeedsStation {
    /// For requests w/ Delegate
    func station(_ station: Station?, to destinationStation: Station?, key: String, session: URLSession) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
        }

        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
        }

        request(
            request: URLRequest(url: RailURL.stationToStation.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    /// For requests w/o Delegate
    func station(_ station: Station?, to destinationStation: Station?, key: String, session: URLSession, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
        }

        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
        }

        fetch(
            request: URLRequest(url: RailURL.stationToStation.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }

    func elevatorAndEscalatorIncidents(at station: Station?, key: String, session: URLSession) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        request(
            request: URLRequest(url: RailURL.elevatorAndEscalatorIncidents.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func elevatorAndEscalatorIncidents(at station: Station?, key: String, session: URLSession, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        fetch(
            request: URLRequest(url: RailURL.elevatorAndEscalatorIncidents.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }

    func incidents(at station: Station?, key: String, session: URLSession) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        request(
            request: URLRequest(url: RailURL.incidents.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func incidents(at station: Station?, key: String, session: URLSession, completion: @escaping (Result<RailIncidents, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        fetch(
            request: URLRequest(url: RailURL.incidents.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }

    func nextTrains(at station: Station, key: String, session: URLSession) {
        request(
            request: URLRequest(url: "\(RailURL.nextTrains.rawValue)\(station)", key: key),
            session: session
        )
    }

    func nextTrains(at station: Station, key: String, session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: "\(RailURL.nextTrains.rawValue)\(station)", key: key),
            session: session,
            completion: completion
        )
    }

    func nextTrains(at stations: [Station], key: String, session: URLSession) {
        var urlArray = [RailURL.nextTrains.rawValue]
        urlArray.append(contentsOf: stations.map { $0.rawValue })

        request(
            request: URLRequest(url: urlArray.joined(separator: ","), key: key),
            session: session
        )
    }

    func nextTrains(at stations: [Station], key: String, session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        var urlArray = [RailURL.nextTrains.rawValue]
        urlArray.append(contentsOf: stations.map { $0.rawValue })

        fetch(
            request: URLRequest(url: urlArray.joined(separator: ","), key: key),
            session: session,
            completion: completion
        )
    }

    func information(for station: Station, key: String, session: URLSession) {
        request(
            request: URLRequest(url: RailURL.information.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session
        )
    }

    func information(for station: Station, key: String, session: URLSession, completion: @escaping (Result<StationInformation, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.information.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session,
            completion: completion
        )
    }

    func parkingInformation(for station: Station, key: String, session: URLSession) {
        request(
            request: URLRequest(url: RailURL.parkingInformation.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session
        )
    }

    func parkingInformation(for station: Station, key: String, session: URLSession, completion: @escaping (Result<StationsParking, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.parkingInformation.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session,
            completion: completion
        )
    }

    func path(from startingStation: Station, to destinationStation: Station, key: String, session: URLSession) {
        request(
            request: URLRequest(
                url: RailURL.path.rawValue,
                key: key,
                queryItems: [
                    ("FromStationCode", startingStation.rawValue),
                    ("ToStationCode", destinationStation.rawValue),
                ]
            ),
            session: session
        )
    }

    func path(from startingStation: Station, to destinationStation: Station, key: String, session: URLSession, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(
                url: RailURL.path.rawValue,
                key: key,
                queryItems: [
                    ("FromStationCode", startingStation.rawValue),
                    ("ToStationCode", destinationStation.rawValue),
                ]
            ),
            session: session,
            completion: completion
        )
    }

    func timings(for station: Station, key: String, session: URLSession) {
        request(
            request: URLRequest(url: RailURL.timings.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session
        )
    }

    func timings(for station: Station, key: String, session: URLSession, completion: @escaping (Result<StationTimings, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.timings.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session,
            completion: completion
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension NeedsStation {
    /// For requests using Combine
    func stationPublisher(_ station: Station?, to destinationStation: Station?, key: String, session: URLSession) -> AnyPublisher<StationToStationInfos, WMATAError> {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
        }

        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
        }

        return publisher(
            request: URLRequest(url: RailURL.stationToStation.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func elevatorAndEscalatorIncidentsPublisher(at station: Station?, key: String, session: URLSession) -> AnyPublisher<ElevatorAndEscalatorIncidents, WMATAError> {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        return publisher(
            request: URLRequest(url: RailURL.elevatorAndEscalatorIncidents.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func incidentsPublisher(at station: Station?, key: String, session: URLSession) -> AnyPublisher<RailIncidents, WMATAError> {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        return publisher(
            request: URLRequest(url: RailURL.incidents.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func nextTrainsPublisher(at station: Station, key: String, session: URLSession) -> AnyPublisher<RailPredictions, WMATAError> {
        publisher(
            request: URLRequest(url: "\(RailURL.nextTrains.rawValue)\(station)", key: key),
            session: session
        )
    }

    func nextTrainsPublisher(at stations: [Station], key: String, session: URLSession) -> AnyPublisher<RailPredictions, WMATAError> {
        var urlArray = [RailURL.nextTrains.rawValue]
        urlArray.append(contentsOf: stations.map { $0.rawValue })

        return publisher(
            request: URLRequest(url: urlArray.joined(separator: ","), key: key),
            session: session
        )
    }

    func informationPublisher(for station: Station, key: String, session: URLSession) -> AnyPublisher<StationInformation, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.information.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session
        )
    }

    func parkingInformationPublisher(for station: Station, key: String, session: URLSession) -> AnyPublisher<StationsParking, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.parkingInformation.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session
        )
    }

    func pathPublisher(from startingStation: Station, to destinationStation: Station, key: String, session: URLSession) -> AnyPublisher<PathBetweenStations, WMATAError> {
        publisher(
            request: URLRequest(
                url: RailURL.path.rawValue,
                key: key,
                queryItems: [
                    ("FromStationCode", startingStation.rawValue),
                    ("ToStationCode", destinationStation.rawValue),
                ]
            ),
            session: session
        )
    }

    func timingsPublisher(for station: Station, key: String, session: URLSession) -> AnyPublisher<StationTimings, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.timings.rawValue, key: key, queryItems: [("StationCode", station.rawValue)]),
            session: session
        )
    }
}

protocol NeedsLine: Fetcher {}

extension NeedsLine {
    func stations(for line: Line?, key: String, session: URLSession) {
        var queryItems = [(String, String)]()

        if let line = line {
            queryItems.append(("LineCode", line.rawValue))
        }

        request(
            request: URLRequest(url: RailURL.stations.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func stations(for line: Line?, key: String, session: URLSession, completion: @escaping (Result<Stations, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let line = line {
            queryItems.append(("LineCode", line.rawValue))
        }

        fetch(
            request: URLRequest(url: RailURL.stations.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension NeedsLine {
    func stationsPublisher(for line: Line?, key: String, session: URLSession) -> AnyPublisher<Stations, WMATAError> {
        var queryItems = [(String, String)]()

        if let line = line {
            queryItems.append(("LineCode", line.rawValue))
        }

        return publisher(
            request: URLRequest(url: RailURL.stations.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
}
