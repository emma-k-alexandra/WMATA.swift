//
//  MetroRail.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation
import GTFS

/// MetroRail related methods
public struct MetroRail: Fetcher {
    public let key: String
    public private(set) var delegate: WMATADelegate? {
        didSet {
            if let delegate = self.delegate {
                urlSession = generateURLSession(with: delegate, sharedContainerIdentifier: sharedContainerIdentifier)
            }
        }
    }

    public private(set) var sharedContainerIdentifier: String?

    private var urlSession: URLSession

    public init(key: String, delegate: WMATADelegate? = nil, sharedContainerIdentifier: String? = nil) {
        self.key = key

        self.sharedContainerIdentifier = sharedContainerIdentifier

        if let delegate = delegate {
            self.delegate = delegate
            urlSession = generateURLSession(with: delegate, sharedContainerIdentifier: sharedContainerIdentifier)

        } else {
            self.delegate = nil
            urlSession = URLSession.shared
        }
    }
}

// These don't require a Station or Line
public extension MetroRail {
    /// General information on all MetroRail lines
    /// For use with a `WMATADelegate`
    func lines() {
        request(
            request: URLRequest(url: RailURL.lines.rawValue, key: key),
            session: urlSession
        )
    }

    /// General information on all MetroRail lines
    ///
    /// - parameter completion: Completion handler which returns `LinesResponse`
    func lines(completion: @escaping (Result<LinesResponse, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.lines.rawValue, key: key),
            session: urlSession,
            completion: completion
        )
    }

    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    /// For use with a `WMATADelegate`
    ///
    /// - parameter radiusAtCoordinates:`RadiusAtCoordinates` to search at
    func entrances(at radiusAtCoordinates: RadiusAtCoordinates?) {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        request(
            request: URLRequest(url: RailURL.entrances.rawValue, key: key, queryItems: queryItems),
            session: urlSession
        )
    }

    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter radiusAtCoordinates:`RadiusAtCoordinates` to search at
    /// - parameter completion: Completion handler which returns `StationEntrances`
    func entrances(at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<StationEntrances, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        fetch(
            request: URLRequest(url: RailURL.entrances.rawValue, key: key, queryItems: queryItems),
            session: urlSession,
            completion: completion
        )
    }

    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    /// For use with a `WMATADelegate`
    func positions() {
        request(
            request: URLRequest(url: RailURL.positions.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - parameter completion: Completion handler which returns `TrainPositions`
    func positions(completion: @escaping (Result<TrainPositions, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.positions.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession,
            completion: completion
        )
    }

    /// Ordered list of track circuits, arranged by line and track number
    /// For use with a `WMATADelegate`
    func routes() {
        request(
            request: URLRequest(url: RailURL.routes.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - parameter completion: Completion handler which returns `StandardRoutes`
    func routes(completion: @escaping (Result<StandardRoutes, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.routes.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession,
            completion: completion
        )
    }

    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    /// For use with a `WMATADelegate`
    func circuits() {
        request(
            request: URLRequest(url: RailURL.circuits.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - parameter completion: Completion handler which returns `TrackCircuits`
    func circuits(completion: @escaping (Result<TrackCircuits, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.circuits.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession,
            completion: completion
        )
    }
}

// These don't require a Station or Line & return Combine Publishers
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroRail {
    /// General information on all MetroRail lines
    ///
    /// - returns: A Combine Publisher for `LinesResponse`
    func linesPublisher() -> AnyPublisher<LinesResponse, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.lines.rawValue, key: key),
            session: urlSession
        )
    }

    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter radiusAtCoordinates:`RadiusAtCoordinates` to search at
    /// - returns: A Combine Publisher for `StationEntrances`
    func entrancesPublisher(at radiusAtCoordinates: RadiusAtCoordinates?) -> AnyPublisher<StationEntrances, WMATAError> {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        return publisher(
            request: URLRequest(url: RailURL.entrances.rawValue, key: key, queryItems: queryItems),
            session: urlSession
        )
    }

    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - returns: A Combine Publisher for `TrainPositions`
    func positionsPublisher() -> AnyPublisher<TrainPositions, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.positions.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - returns: A Combine Publisher for `StandardRoutes`
    func routesPublisher() -> AnyPublisher<StandardRoutes, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.routes.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - returns: A Combine Publisher for `TrackCircuits`
    func circuitsPublisher() -> AnyPublisher<TrackCircuits, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.circuits.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }
}

extension MetroRail: NeedsStation {}

public extension MetroRail {
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    func station(_ station: Station?, to destinationStation: Station?) {
        (self as NeedsStation).station(station, to: destinationStation, key: key, session: urlSession)
    }

    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    /// - parameter completion: Completion handler which returns `StationToStationInfos`
    func station(_ station: Station?, to destinationStation: Station?, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> Void) {
        (self as NeedsStation).station(station, to: destinationStation, key: key, session: urlSession, completion: completion)
    }

    /// Reported elevator and escalator incidents
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: Which station to search for incidents at. Optional.
    func elevatorAndEscalatorIncidents(at station: Station?) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, key: key, session: urlSession)
    }

    /// Reported elevator and escalator incidents
    ///
    /// - parameter station: Which station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `ElevatorAndEscalatorIncidents`
    func elevatorAndEscalatorIncidents(at station: Station?, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> Void) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, key: key, session: urlSession, completion: completion)
    }

    /// Reported MetroRail incidents
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: Station to search for incidents at. Optional.
    func incidents(at station: Station?) {
        (self as NeedsStation).incidents(at: station, key: key, session: urlSession)
    }

    /// Reported MetroRail incidents
    ///
    /// - parameter station: Station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `RailIncidents`
    func incidents(at station: Station?, completion: @escaping (Result<RailIncidents, WMATAError>) -> Void) {
        (self as NeedsStation).incidents(at: station, key: key, session: urlSession, completion: completion)
    }

    /// Next train arrival information for this station
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: `Station` to search for trains at
    func nextTrains(at station: Station) {
        (self as NeedsStation).nextTrains(at: station, key: key, session: urlSession)
    }

    /// Next train arrival information for this station
    ///
    /// - parameter station: `Station` to search for trains at
    /// - parameter completion: Completion handler which returns `RailPredictions`
    func nextTrains(at station: Station, completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        (self as NeedsStation).nextTrains(at: station, key: key, session: urlSession, completion: completion)
    }

    /// Next train arrival information for the given stations
    /// For use with a `WMATADelegate`
    ///
    /// - parameter stations: `[Station]`s to look up next trains for
    func nextTrains(at stations: [Station]) {
        (self as NeedsStation).nextTrains(at: stations, key: key, session: urlSession)
    }

    /// Next train arrival information for the given stations
    ///
    /// - parameter stations: `[Station]`s to look up next trains for
    /// - parameter completion: Completion handler which returns `RailPredictions`
    func nextTrains(at stations: [Station], completion: @escaping (Result<RailPredictions, WMATAError>) -> Void) {
        (self as NeedsStation).nextTrains(at: stations, key: key, session: urlSession, completion: completion)
    }

    /// Location and address information for this station
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: `StationCode` search for information for
    func information(for station: Station) {
        (self as NeedsStation).information(for: station, key: key, session: urlSession)
    }

    /// Location and address information for this station
    ///
    /// - parameter station: `StationCode` search for information for
    /// - parameter completion: Completion handler which returns `StationInformation`
    func information(for station: Station, completion: @escaping (Result<StationInformation, WMATAError>) -> Void) {
        (self as NeedsStation).information(for: station, key: key, session: urlSession, completion: completion)
    }

    /// Parking information for this station
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: `StationCode` to search for parking information for
    func parkingInformation(for station: Station) {
        (self as NeedsStation).parkingInformation(for: station, key: key, session: urlSession)
    }

    /// Parking information for this station
    ///
    /// - parameter station: `StationCode` to search for parking information for
    /// - parameter completion: Completion handler which returns `StationsParking`
    func parkingInformation(for station: Station, completion: @escaping (Result<StationsParking, WMATAError>) -> Void) {
        (self as NeedsStation).parkingInformation(for: station, key: key, session: urlSession, completion: completion)
    }

    /// Returns a set of ordered stations and distances between two stations _on the same line_
    /// For use with a `WMATADelegate`
    ///
    /// - parameter startingStation: Starting station to pathfind from
    /// - parameter destinationStation: Destination station to pathfind to
    func path(from startingStation: Station, to destinationStation: Station) {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, key: key, session: urlSession)
    }

    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - parameter startingStation: Starting station to pathfind from
    /// - parameter destinationStation: Destination station to pathfind to
    /// - parameter completion: Completion handler which returns `PathBetweenStations`
    func path(from startingStation: Station, to destinationStation: Station, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> Void) {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, key: key, session: urlSession, completion: completion)
    }

    /// Opening and scheduled first and last trains for this station
    /// For use with a `WMATADelegate`
    ///
    /// - parameter station: `StationCode` to search for timings for
    func timings(for station: Station) {
        (self as NeedsStation).timings(for: station, key: key, session: urlSession)
    }

    /// Opening and scheduled first and last trains for this station
    ///
    /// - parameter station: `StationCode` to search for timings for
    /// - parameter completion: Completion handler which returns `StationTimings`
    func timings(for station: Station, completion: @escaping (Result<StationTimings, WMATAError>) -> Void) {
        (self as NeedsStation).timings(for: station, key: key, session: urlSession, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroRail {
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    /// - returns: A Combine Publisher for `StationToStationInfos`
    func stationPublisher(_ station: Station?, to destinationStation: Station?) -> AnyPublisher<StationToStationInfos, WMATAError> {
        (self as NeedsStation).station(station, to: destinationStation, key: key, session: urlSession)
    }

    /// Reported elevator and escalator incidents
    ///
    /// - parameter station: Which station to search for incidents at. Optional.
    /// - returns: A Combine Publisher for `ElevatorAndEscalatorIncidents`
    func elevatorAndEscalatorIncidentsPublisher(at station: Station?) -> AnyPublisher<ElevatorAndEscalatorIncidents, WMATAError> {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, key: key, session: urlSession)
    }

    /// Reported MetroRail incidents
    ///
    /// - parameter station: Station to search for incidents at. Optional.
    /// - returns: A Combine Publisher for `RailIncidents`
    func incidentsPublisher(at station: Station?) -> AnyPublisher<RailIncidents, WMATAError> {
        (self as NeedsStation).incidents(at: station, key: key, session: urlSession)
    }

    /// Next train arrival information for this station
    ///
    /// - parameter station: `Station` to search for trains at
    /// - returns: A Combine Publisher for  `RailPredictions`
    func nextTrainsPublisher(at station: Station) -> AnyPublisher<RailPredictions, WMATAError> {
        (self as NeedsStation).nextTrains(at: station, key: key, session: urlSession)
    }

    /// Next train arrival information for the given stations
    ///
    /// - parameter stations: `[Station]`s to look up next trains for
    /// - returns: A Combine Publisher for  `RailPredictions`
    func nextTrainsPublisher(at stations: [Station]) -> AnyPublisher<RailPredictions, WMATAError> {
        (self as NeedsStation).nextTrains(at: stations, key: key, session: urlSession)
    }

    /// Location and address information for this station
    ///
    /// - parameter station: `StationCode` search for information for
    /// - returns: A Combine Publisher for `StationInformation`
    func informationPublisher(for station: Station) -> AnyPublisher<StationInformation, WMATAError> {
        (self as NeedsStation).information(for: station, key: key, session: urlSession)
    }

    /// Parking information for this station
    ///
    /// - parameter station: `StationCode` to search for parking information for
    /// - returns: A Combine Publisher for `StationsParking`
    func parkingInformationPublisher(for station: Station) -> AnyPublisher<StationsParking, WMATAError> {
        (self as NeedsStation).parkingInformation(for: station, key: key, session: urlSession)
    }

    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - parameter startingStation: Starting station to pathfind from
    /// - parameter destinationStation: Destination station to pathfind to
    /// - returns: A Combine Publisher for  `PathBetweenStations`
    func pathPublisher(from startingStation: Station, to destinationStation: Station) -> AnyPublisher<PathBetweenStations, WMATAError> {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, key: key, session: urlSession)
    }

    /// Opening and scheduled first and last trains for this station
    ///
    /// - parameter station: `StationCode` to search for timings for
    /// - returns: A Combine Publisher for  `StationTimings`
    func timingsPublisher(for station: Station) -> AnyPublisher<StationTimings, WMATAError> {
        (self as NeedsStation).timings(for: station, key: key, session: urlSession)
    }
}

extension MetroRail: NeedsLine {}

public extension MetroRail {
    /// Stations along a Line
    /// For use with a `WMATADelegate`
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    func stations(for line: Line?) {
        (self as NeedsLine).stations(for: line, key: key, session: urlSession)
    }

    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    /// - parameter completion: Completion handler which returns `Stations`
    func stations(for line: Line?, completion: @escaping (Result<Stations, WMATAError>) -> Void) {
        (self as NeedsLine).stations(for: line, key: key, session: urlSession, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroRail {
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    /// - returns: A Combine Publisher for `Stations`
    func stationsPublisher(for line: Line?) -> AnyPublisher<Stations, WMATAError> {
        (self as NeedsLine).stations(for: line, key: key, session: urlSession)
    }
}

extension MetroRail: GTFSRTFetcher {}

/// GTFS-RT Calls
public extension MetroRail {
    /// GTFS RT 2.0 service alerts feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
    ///
    /// - parameter completion: Completion handler which returns `TransitRealtime_FeedMessage`
    func alerts(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTRailURL.alerts.rawValue, key: key),
            session: urlSession,
            completion: completion
        )
    }

    /// GTFS RT 2.0 service alerts feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
    /// For use with a `WMATADelegate`
    func alerts() {
        request(
            request: URLRequest(
                url: GTFSRTRailURL.alerts.rawValue,
                key: key
            ),
            session: urlSession
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
    ///
    /// - parameter completion: Completion handler which returns `TransitRealtime_FeedMessage`
    func tripUpdates(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(
                url: GTFSRTRailURL.tripUpdates.rawValue,
                key: key
            ),
            session: urlSession,
            completion: completion
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
    /// For use with a `WMATADelegate`
    func tripUpdates() {
        request(
            request: URLRequest(
                url: GTFSRTRailURL.tripUpdates.rawValue,
                key: key
            ),
            session: urlSession
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
    ///
    /// - parameter completion: Completion handler which returns `TransitRealtime_FeedMessage`
    func vehiclePositions(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTRailURL.vehiclePositions.rawValue, key: key),
            session: urlSession,
            completion: completion
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
    /// For use with a `WMATADelegate`
    func vehiclePositions() {
        request(
            request: URLRequest(
                url: GTFSRTRailURL.vehiclePositions.rawValue,
                key: key
            ),
            session: urlSession
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroRail {
    /// GTFS RT 2.0 service alerts feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
    ///
    /// - returns: A Combine Publisher for `TransitRealtime_FeedMessage`
    func alertsPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(url: GTFSRTRailURL.alerts.rawValue, key: key),
            session: urlSession
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
    ///
    /// - returns: A Combine Publisher for `TransitRealtime_FeedMessage`
    func tripUpdatesPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(
                url: GTFSRTRailURL.tripUpdates.rawValue,
                key: key
            ),
            session: urlSession
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA rail.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
    ///
    /// - returns: A Combine Publisher for`TransitRealtime_FeedMessage`
    func vehiclePositionsPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(
                url: GTFSRTRailURL.vehiclePositions.rawValue,
                key: key
            ),
            session: urlSession
        )
    }
}
