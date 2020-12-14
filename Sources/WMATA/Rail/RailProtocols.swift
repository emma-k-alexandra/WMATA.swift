//
//  RailProtocols.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation

protocol NeedsStation: Fetcher {}

extension NeedsStation {
    /// For requests w/ Delegate
    func station(_ station: Station?, to destinationStation: Station?, with apiKey: String, and session: URLSession) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
        }

        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
        }

        request(
            with: URLRequest(url: RailURL.stationToStation.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    /// For requests w/o Delegate
    func station(_ station: Station?, to destinationStation: Station?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
        }

        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
        }

        fetch(
            with: URLRequest(url: RailURL.stationToStation.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func elevatorAndEscalatorIncidents(at station: Station?, with apiKey: String, and session: URLSession) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        request(
            with: URLRequest(url: RailURL.elevatorAndEscalatorIncidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func elevatorAndEscalatorIncidents(at station: Station?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        fetch(
            with: URLRequest(url: RailURL.elevatorAndEscalatorIncidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func incidents(at station: Station?, with apiKey: String, and session: URLSession) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        request(
            with: URLRequest(url: RailURL.incidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func incidents(at station: Station?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailIncidents, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
        }

        fetch(
            with: URLRequest(url: RailURL.incidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func nextTrains(at station: Station, with apiKey: String, and session: URLSession) {
        request(
            with: URLRequest(url: "\(RailURL.nextTrains.rawValue)\(station)", queryItems: [], apiKey: apiKey),
            and: session
        )
    }

    func nextTrains(at station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: "\(RailURL.nextTrains.rawValue)\(station)", queryItems: [], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func nextTrains(at stations: [Station], with apiKey: String, and session: URLSession) {
        var urlArray = [RailURL.nextTrains.rawValue]
        urlArray.append(contentsOf: stations.map { $0.rawValue })

        request(
            with: URLRequest(url: urlArray.joined(separator: ","), queryItems: [], apiKey: apiKey),
            and: session
        )
    }

    func nextTrains(at stations: [Station], withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        var urlArray = [RailURL.nextTrains.rawValue]
        urlArray.append(contentsOf: stations.map { $0.rawValue })

        fetch(
            with: URLRequest(url: urlArray.joined(separator: ","), queryItems: [], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func information(for station: Station, with apiKey: String, and session: URLSession) {
        request(
            with: URLRequest(url: RailURL.information.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            and: session
        )
    }

    func information(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationInformation, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: RailURL.information.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func parkingInformation(for station: Station, with apiKey: String, and session: URLSession) {
        request(
            with: URLRequest(url: RailURL.parkingInformation.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            and: session
        )
    }

    func parkingInformation(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationsParking, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: RailURL.parkingInformation.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func path(from startingStation: Station, to destinationStation: Station, with apiKey: String, and session: URLSession) {
        request(
            with: URLRequest(
                url: RailURL.path.rawValue,
                queryItems: [
                    ("FromStationCode", startingStation.rawValue),
                    ("ToStationCode", destinationStation.rawValue),
                ],
                apiKey: apiKey
            ),
            and: session
        )
    }

    func path(from startingStation: Station, to destinationStation: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(
                url: RailURL.path.rawValue,
                queryItems: [
                    ("FromStationCode", startingStation.rawValue),
                    ("ToStationCode", destinationStation.rawValue),
                ],
                apiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
    }

    func timings(for station: Station, with apiKey: String, and session: URLSession) {
        request(
            with: URLRequest(url: RailURL.timings.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            and: session
        )
    }

    func timings(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationTimings, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: RailURL.timings.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }
}

protocol NeedsLine: Fetcher {}

extension NeedsLine {
    func stations(for line: Line?, with apiKey: String, and session: URLSession) {
        var queryItems = [(String, String)]()

        if let line = line {
            queryItems.append(("LineCode", line.rawValue))
        }

        request(
            with: URLRequest(url: RailURL.stations.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func stations(for line: Line?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<Stations, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let line = line {
            queryItems.append(("LineCode", line.rawValue))
        }

        fetch(
            with: URLRequest(url: RailURL.stations.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }
}
