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
    func station(_ station: Station?, to destinationStation: Station?, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.StationToStation(
                key: key,
                station: station,
                destinationStation: destinationStation
            ),
            session: session
        )
    }

    /// For requests w/o Delegate
    func station(_ station: Station?, to destinationStation: Station?, key: APIKey, session: URLSession, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.StationToStation(
                key: key,
                station: station,
                destinationStation: destinationStation
            ),
            session: session,
            completion: completion
        )
    }

    func elevatorAndEscalatorIncidents(at station: Station?, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.ElevatorAndEscalatorIncidents(key: key, station: station),
            session: session
        )
    }

    func elevatorAndEscalatorIncidents(at station: Station?, key: APIKey, session: URLSession, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.ElevatorAndEscalatorIncidents(key: key, station: station),
            session: session,
            completion: completion
        )
    }

    func incidents(at station: Station?, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.Incidents(key: key, station: station),
            session: session
        )
    }

    func incidents(at station: Station?, key: APIKey, session: URLSession, completion: @escaping (Result<RailIncidents, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.Incidents(key: key, station: station),
            session: session,
            completion: completion
        )
    }

    func nextTrains(at station: Station, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.NextTrains(key: key, station: station),
            session: session
        )
    }

    func nextTrains(at station: Station, key: APIKey, session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.NextTrains(key: key, station: station),
            session: session,
            completion: completion
        )
    }

    func nextTrains(at stations: [Station], key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.NextTrains(key: key, stations: stations),
            session: session
        )
    }

    func nextTrains(at stations: [Station], key: APIKey, session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.NextTrains(key: key, stations: stations),
            session: session,
            completion: completion
        )
    }

    func information(for station: Station, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.Information(key: key, station: station),
            session: session
        )
    }

    func information(for station: Station, key: APIKey, session: URLSession, completion: @escaping (Result<StationInformation, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.Information(key: key, station: station),
            session: session,
            completion: completion
        )
    }

    func parkingInformation(for station: Station, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.ParkingInformation(key: key, station: station),
            session: session
        )
    }

    func parkingInformation(for station: Station, key: APIKey, session: URLSession, completion: @escaping (Result<StationsParking, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.ParkingInformation(key: key, station: station),
            session: session,
            completion: completion
        )
    }

    func path(from startingStation: Station, to destinationStation: Station, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.Path(
                key: key,
                startingStation: startingStation,
                destinationStation: destinationStation
            ),
            session: session
        )
    }

    func path(from startingStation: Station, to destinationStation: Station, key: APIKey, session: URLSession, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.Path(
                key: key,
                startingStation: startingStation,
                destinationStation: destinationStation
            ),
            session: session,
            completion: completion
        )
    }

    func timings(for station: Station, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.Timings(key: key, station: station),
            session: session
        )
    }

    func timings(for station: Station, key: APIKey, session: URLSession, completion: @escaping (Result<StationTimings, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.Timings(key: key, station: station),
            session: session,
            completion: completion
        )
    }
}


extension NeedsStation {
    /// For requests using Combine
    func stationPublisher(_ station: Station?, to destinationStation: Station?, key: APIKey, session: URLSession) -> AnyPublisher<StationToStationInfos, WMATAError> {
        publisher(
            endpoint: API.Rail.StationToStation(
                key: key,
                station: station,
                destinationStation: destinationStation
            ),
            session: session
        )
    }

    func elevatorAndEscalatorIncidentsPublisher(at station: Station?, key: APIKey, session: URLSession) -> AnyPublisher<ElevatorAndEscalatorIncidents, WMATAError> {
        publisher(
            endpoint: API.Rail.ElevatorAndEscalatorIncidents(
                key: key,
                station: station
            ),
            session: session
        )
    }

    func incidentsPublisher(at station: Station?, key: APIKey, session: URLSession) -> AnyPublisher<RailIncidents, WMATAError> {
        publisher(
            endpoint: API.Rail.Incidents(key: key, station: station),
            session: session
        )
    }

    func nextTrainsPublisher(at station: Station, key: APIKey, session: URLSession) -> AnyPublisher<RailPredictions, WMATAError> {
        publisher(
            endpoint: API.Rail.NextTrains(key: key, station: station),
            session: session
        )
    }

    func nextTrainsPublisher(at stations: [Station], key: APIKey, session: URLSession) -> AnyPublisher<RailPredictions, WMATAError> {
        publisher(
            endpoint: API.Rail.NextTrains(key: key, stations: stations),
            session: session
        )
    }

    func informationPublisher(for station: Station, key: APIKey, session: URLSession) -> AnyPublisher<StationInformation, WMATAError> {
        publisher(
            endpoint: API.Rail.Information(key: key, station: station),
            session: session
        )
    }

    func parkingInformationPublisher(for station: Station, key: APIKey, session: URLSession) -> AnyPublisher<StationsParking, WMATAError> {
        publisher(
            endpoint: API.Rail.ParkingInformation(key: key, station: station),
            session: session
        )
    }

    func pathPublisher(from startingStation: Station, to destinationStation: Station, key: APIKey, session: URLSession) -> AnyPublisher<PathBetweenStations, WMATAError> {
        publisher(
            endpoint: API.Rail.Path(
                key: key,
                startingStation: startingStation,
                destinationStation: destinationStation
            ),
            session: session
        )
    }

    func timingsPublisher(for station: Station, key: APIKey, session: URLSession) -> AnyPublisher<StationTimings, WMATAError> {
        publisher(
            endpoint: API.Rail.Timings(key: key, station: station),
            session: session
        )
    }
}

protocol NeedsLine: Fetcher {}

extension NeedsLine {
    func stations(for line: Line?, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Rail.Stations(key: key, line: line),
            session: session
        )
    }

    func stations(for line: Line?, key: APIKey, session: URLSession, completion: @escaping (Result<Stations, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Rail.Stations(key: key, line: line),
            session: session,
            completion: completion
        )
    }
}


extension NeedsLine {
    func stationsPublisher(for line: Line?, key: APIKey, session: URLSession) -> AnyPublisher<Stations, WMATAError> {
        publisher(
            endpoint: API.Rail.Stations(key: key, line: line),
            session: session
        )
    }
}
