//
//  MetroRail.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation
import GTFS

/// For accessing MetroRail related APIs
public struct MetroRail: Fetcher {
    /// WMATA API Key
    public let key: String
    
    /// Delegate for use with delegate calls
    public var delegate: WMATADelegate? {
        didSet {
            if let delegate = self.delegate {
                urlSession = generateURLSession(with: delegate, sharedContainerIdentifier: sharedContainerIdentifier)
            }
        }
    }

    /// The shared container identifier for use with app extensions. See [URLSessionConfiguration](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/1409450-sharedcontaineridentifier)
    public private(set) var sharedContainerIdentifier: String?

    /// URL session to use for all calls
    private var urlSession: URLSession

    /// Create a new MetroRail instance
    ///
    /// - Parameters:
    ///     - key: Your WMATA API key
    ///     - delegate: The delegate to use for all delegate calls. Optional.
    ///     - sharedContainerIdentifier: Identifier for use with app extensions. Optional.
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
    /// General information on all MetroRail lines.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateLinesResponse)
    ///
    /// - Note:
    ///     [WMATA Lines API Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
    func lines() {
        request(
            request: URLRequest(url: RailURL.lines.rawValue, key: key),
            session: urlSession
        )
    }

    /// General information on all MetroRail lines
    ///
    /// - Note:
    ///     [WMATA Lines Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: [LinesResponse](x-source-tag://LinesResponse) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func lines(completion: @escaping (_ result: Result<LinesResponse, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.lines.rawValue, key: key),
            session: urlSession,
            completion: completion
        )
    }

    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStationEntrances)
    ///
    /// - Note:
    ///     [WMATA Entrances Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f)
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    func entrances(at radiusAtCoordinates: RadiusAtCoordinates? = nil) {
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
    /// - Note:
    ///     [WMATA Entrances Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f)
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    ///     - completion: A completion handler
    ///     - result: [StationEntrances](x-source-tag://StationEntrances) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func entrances(at radiusAtCoordinates: RadiusAtCoordinates? = nil, completion: @escaping (_ result: Result<StationEntrances, WMATAError>) -> Void) {
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
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateTrainPositions)
    ///
    /// - Note:
    ///     [WMATA Positions Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
    func positions() {
        request(
            request: URLRequest(url: RailURL.positions.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - Note:
    ///     [WMATA Positions Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: [TrainPositions](x-source-tag://TrainPositions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func positions(completion: @escaping (_ result: Result<TrainPositions, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.positions.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession,
            completion: completion
        )
    }

    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStandardRoutes)
    ///
    /// - Note:
    ///     [WMATA Routes Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
    func routes() {
        request(
            request: URLRequest(url: RailURL.routes.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - Note:
    ///     [WMATA Routes Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: [StandardRoutes](x-source-tag://StandardRoutes) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func routes(completion: @escaping (_ result: Result<StandardRoutes, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: RailURL.routes.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession,
            completion: completion
        )
    }

    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateTrackCircuits)
    ///
    /// - Note:
    ///     [WMATA Circuits Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
    func circuits() {
        request(
            request: URLRequest(url: RailURL.circuits.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - Note:
    ///     [WMATA Circuits Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: [TrackCircuits](x-source-tag://TrackCircuits) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func circuits(completion: @escaping (_ result: Result<TrackCircuits, WMATAError>) -> Void) {
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
    /// - Note:
    ///     [WMATA Lines Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
    ///
    /// - Returns: A Combine Publisher for [LinesResponse](x-source-tag://LinesResponse)
    func linesPublisher() -> AnyPublisher<LinesResponse, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.lines.rawValue, key: key),
            session: urlSession
        )
    }

    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - Note:
    ///     [WMATA Entrances Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f)
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    ///
    /// - Returns: A Combine Publisher for [StationEntrances](x-source-tag://StationEntrances)
    func entrancesPublisher(at radiusAtCoordinates: RadiusAtCoordinates? = nil) -> AnyPublisher<StationEntrances, WMATAError> {
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
    /// - Note:
    ///     [WMATA Positions Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
    ///
    /// - Returns: A Combine Publisher for [TrainPositions](x-source-tag://TrainPositions)
    func positionsPublisher() -> AnyPublisher<TrainPositions, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.positions.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - Note:
    ///     [WMATA Routes Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
    ///
    /// - Returns: A Combine Publisher for [StandardRoutes](x-source-tag://StandardRoutes)
    func routesPublisher() -> AnyPublisher<StandardRoutes, WMATAError> {
        publisher(
            request: URLRequest(url: RailURL.routes.rawValue, key: key, queryItems: [("contentType", "json")]),
            session: urlSession
        )
    }

    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - Note:
    ///     [WMATA Circuits Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
    ///
    /// - Returns: A Combine Publisher for [TrackCircuits](x-source-tag://TrackCircuits)
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
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStationToStationInfos)
    ///
    /// - Note:
    ///     [WMATA Station To Station Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
    ///
    /// - Parameters:
    ///     - station: Station to start trip at. Optional.
    ///     - destinationStation: Station to travel to. Optional.
    func station(_ station: Station? = nil, to destinationStation: Station? = nil) {
        (self as NeedsStation).station(station, to: destinationStation, key: key, session: urlSession)
    }

    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - Note:
    ///     [WMATA Station To Station Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
    ///
    /// - Parameters:
    ///     - station: Station to start trip at. Optional.
    ///     - destinationStation: Station to travel to. Optional.
    ///     - completion: A completion handler
    ///     - result: [StationToStationInfos](x-source-tag://StationToStationInfos) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func station(_ station: Station? = nil, to destinationStation: Station? = nil, completion: @escaping (_ result: Result<StationToStationInfos, WMATAError>) -> Void) {
        (self as NeedsStation).station(station, to: destinationStation, key: key, session: urlSession, completion: completion)
    }

    /// Reported elevator and escalator incidents
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateElevatorAndEscalatorIncidents)
    ///
    /// - Note:
    ///     [WMATA Elevator and Escalator Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76)
    ///
    /// - Parameters:
    ///     - station: Which station to search for incidents at. Optional.
    func elevatorAndEscalatorIncidents(at station: Station? = nil) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, key: key, session: urlSession)
    }

    /// Reported elevator and escalator incidents
    ///
    /// - Note:
    ///     [WMATA Elevator and Escalator Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76)
    ///
    /// - Parameters:
    ///     - station: Which station to search for incidents at. Optional.
    ///     - completion: A completion handler
    ///     - result: [ElevatorAndEscalatorIncidents](x-source-tag://ElevatorAndEscalatorIncidents) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func elevatorAndEscalatorIncidents(at station: Station? = nil, completion: @escaping (_ result: Result<ElevatorAndEscalatorIncidents, WMATAError>) -> Void) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, key: key, session: urlSession, completion: completion)
    }

    /// Reported MetroRail incidents
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateRailIncidents)
    ///
    /// - Note:
    ///     [WMATA Rail Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77)
    ///
    /// - Parameters:
    ///     - station: Station to search for incidents at. Optional.
    func incidents(at station: Station? = nil) {
        (self as NeedsStation).incidents(at: station, key: key, session: urlSession)
    }

    /// Reported MetroRail incidents
    ///
    /// - Note:
    ///     [WMATA Rail Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77)
    ///
    /// - Parameters:
    ///     - station: Station to search for incidents at. Optional.
    ///     - completion: A completion handler
    ///     - result: [RailIncidents](x-source-tag://RailIncidents) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func incidents(at station: Station? = nil, completion: @escaping (_ result: Result<RailIncidents, WMATAError>) -> Void) {
        (self as NeedsStation).incidents(at: station, key: key, session: urlSession, completion: completion)
    }

    /// Next train arrival information for this station
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateRailPredictions)
    ///
    /// - Note:
    ///     [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    ///
    /// - Parameters:
    ///     - station: Station to search for trains at
    func nextTrains(at station: Station) {
        (self as NeedsStation).nextTrains(at: station, key: key, session: urlSession)
    }

    /// Next train arrival information for this station
    ///
    /// - Note:
    ///     [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    ///
    /// - Parameters:
    ///     - station: `Station` to search for trains at
    ///     - completion: A completion handler
    ///     - result: [RailPredictions](x-source-tag://RailPredictions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func nextTrains(at station: Station, completion: @escaping (_ result: Result<RailPredictions, WMATAError>) -> Void) {
        (self as NeedsStation).nextTrains(at: station, key: key, session: urlSession, completion: completion)
    }

    /// Next train arrival information for the given stations
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateRailPredictions)
    ///
    /// - Note:
    ///     [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    ///
    /// - Parameters:
    ///     - stations: Stations to look up next trains for
    func nextTrains(at stations: [Station]) {
        (self as NeedsStation).nextTrains(at: stations, key: key, session: urlSession)
    }

    /// Next train arrival information for the given stations
    ///
    /// - Note:
    ///     [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    ///
    /// - Parameters:
    ///     - stations: Stations to look up next trains for
    ///     - completion: A completion handler
    ///     - result: [RailPredictions](x-source-tag://RailPredictions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func nextTrains(at stations: [Station], completion: @escaping (_ result: Result<RailPredictions, WMATAError>) -> Void) {
        (self as NeedsStation).nextTrains(at: stations, key: key, session: urlSession, completion: completion)
    }

    /// Location and address information for this station
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStationInformation)
    ///
    /// - Note:
    ///     [WMATA Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
    ///
    /// - Parameters:
    ///     - station: Station to search for information on
    func information(for station: Station) {
        (self as NeedsStation).information(for: station, key: key, session: urlSession)
    }

    /// Location and address information for this station
    ///
    /// - Note:
    ///     [WMATA Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
    ///
    /// - Parameters:
    ///     - station: Station to search for information on
    ///     - completion: A completion handler
    ///     - result: [StationInformation](x-source-tag://StationInformation) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func information(for station: Station, completion: @escaping (_ result: Result<StationInformation, WMATAError>) -> Void) {
        (self as NeedsStation).information(for: station, key: key, session: urlSession, completion: completion)
    }

    /// Parking information for this station
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStationsParking)
    ///
    /// - Note:
    ///     [WMATA Station Parking Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
    ///
    /// - Parameters:
    ///     - station: Station to search for parking information on
    func parkingInformation(for station: Station) {
        (self as NeedsStation).parkingInformation(for: station, key: key, session: urlSession)
    }

    /// Parking information for this station
    ///
    /// - Note:
    ///     [WMATA Station Parking Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
    ///
    /// - Parameters:
    ///     - station: Station  to search for parking information on
    ///     - completion: A completion handler
    ///     - result: [StationsParking](x-source-tag://StationsParking) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func parkingInformation(for station: Station, completion: @escaping (_ result: Result<StationsParking, WMATAError>) -> Void) {
        (self as NeedsStation).parkingInformation(for: station, key: key, session: urlSession, completion: completion)
    }

    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegatePathBetweenStations)
    ///
    /// - Note:
    ///     [WMATA Path Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e)
    ///
    /// - Parameters:
    ///     - startingStation: Starting station to pathfind from
    ///     - destinationStation: Destination station to pathfind to
    func path(from startingStation: Station, to destinationStation: Station) {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, key: key, session: urlSession)
    }

    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - Note:
    ///     [WMATA Path Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e)
    ///
    /// - Parameters:
    ///     - startingStation: Starting station to pathfind from
    ///     - destinationStation: Destination station to pathfind to
    ///     - completion: A completion handler
    ///     - result: [PathBetweenStations](x-source-tag://PathBetweenStations) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func path(from startingStation: Station, to destinationStation: Station, completion: @escaping (_ result: Result<PathBetweenStations, WMATAError>) -> Void) {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, key: key, session: urlSession, completion: completion)
    }

    /// Opening and scheduled first and last trains for this station
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStationTimings)
    ///
    /// - Note:
    ///     [WMATA Timings Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
    ///
    /// - Parameters:
    ///     - station: Station to search for timings on
    func timings(for station: Station) {
        (self as NeedsStation).timings(for: station, key: key, session: urlSession)
    }

    /// Opening and scheduled first and last trains for this station
    ///
    /// - Note:
    ///     [WMATA Timings Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
    ///
    /// - Parameters:
    ///     - station: Station to search for timings on
    ///     - completion: Completion handler which returns `StationTimings`
    ///     - result: [StationTimings](x-source-tag://StationTimings) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func timings(for station: Station, completion: @escaping (_ result: Result<StationTimings, WMATAError>) -> Void) {
        (self as NeedsStation).timings(for: station, key: key, session: urlSession, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroRail {
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - Note:
    ///     [WMATA Station To Station Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
    ///
    /// - Parameters:
    ///     - station: Station to start trip at. Optional.
    ///     - destinationStation: Station to travel to. Optional.
    ///
    /// - Returns: A Combine Publisher for [StationToStationInfos](x-source-tag://StationToStationInfos)
    func stationPublisher(_ station: Station? = nil, to destinationStation: Station? = nil) -> AnyPublisher<StationToStationInfos, WMATAError> {
        (self as NeedsStation).stationPublisher(station, to: destinationStation, key: key, session: urlSession)
    }

    /// Reported elevator and escalator incidents
    ///
    /// - Note:
    ///     [WMATA Elevator to Escalator Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76)
    ///
    /// - Parameters:
    ///     - station: Which station to search for incidents at. Optional.
    ///
    /// - Returns: A Combine Publisher for [ElevatorAndEscalatorIncidents](x-source-tag://ElevatorAndEscalatorIncidents)
    func elevatorAndEscalatorIncidentsPublisher(at station: Station? = nil) -> AnyPublisher<ElevatorAndEscalatorIncidents, WMATAError> {
        (self as NeedsStation).elevatorAndEscalatorIncidentsPublisher(at: station, key: key, session: urlSession)
    }

    /// Reported MetroRail incidents
    ///
    /// - Note:
    ///     [WMATA Rail Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77)
    ///
    /// - Parameters:
    ///     - station: Station to search for incidents at. Optional.
    ///
    /// - Returns: A Combine Publisher for [RailIncidents](x-source-tag://RailIncidents)
    func incidentsPublisher(at station: Station? = nil) -> AnyPublisher<RailIncidents, WMATAError> {
        (self as NeedsStation).incidentsPublisher(at: station, key: key, session: urlSession)
    }

    /// Next train arrival information for this station
    ///
    /// - Note:
    ///     [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    ///
    /// - Parameters:
    ///     - station: Station to search for trains at
    ///
    /// - Returns: A Combine Publisher for [RailPredictions](x-source-tag://RailPredictions)
    func nextTrainsPublisher(at station: Station) -> AnyPublisher<RailPredictions, WMATAError> {
        (self as NeedsStation).nextTrainsPublisher(at: station, key: key, session: urlSession)
    }

    /// Next train arrival information for the given stations
    ///
    /// - Note:
    ///     [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    ///
    /// - Parameters:
    ///     - stations: Stations to look up next trains for
    ///
    /// - Returns: A Combine Publisher for  [RailPredictions](x-source-tag://RailPredictions)
    func nextTrainsPublisher(at stations: [Station]) -> AnyPublisher<RailPredictions, WMATAError> {
        (self as NeedsStation).nextTrainsPublisher(at: stations, key: key, session: urlSession)
    }

    /// Location and address information for this station
    ///
    /// - Note:
    ///     [WMATA Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
    ///
    /// - Parameters:
    ///     - station: Station search for information on
    ///
    /// - Returns: A Combine Publisher for  [StationInformation](x-source-tag://StationInformation)
    func informationPublisher(for station: Station) -> AnyPublisher<StationInformation, WMATAError> {
        (self as NeedsStation).informationPublisher(for: station, key: key, session: urlSession)
    }

    /// Parking information for this station
    ///
    /// - Note:
    ///     [WMATA Station Parking Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
    ///
    /// - Parameters:
    ///     - station: Station to search for parking information on
    ///
    /// - Returns: A Combine Publisher for [StationsParking](x-source-tag://StationsParking)
    func parkingInformationPublisher(for station: Station) -> AnyPublisher<StationsParking, WMATAError> {
        (self as NeedsStation).parkingInformationPublisher(for: station, key: key, session: urlSession)
    }

    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - Note:
    ///     [WMATA Path Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e)
    ///
    /// - Parameters:
    ///     - startingStation: Starting station to pathfind from
    ///     - destinationStation: Destination station to pathfind to
    ///
    /// - Returns: A Combine Publisher for  [PathBetweenStations](x-source-tag://PathBetweenStations)
    func pathPublisher(from startingStation: Station, to destinationStation: Station) -> AnyPublisher<PathBetweenStations, WMATAError> {
        (self as NeedsStation).pathPublisher(from: startingStation, to: destinationStation, key: key, session: urlSession)
    }

    /// Opening and scheduled first and last trains for this station
    ///
    /// - Note:
    ///     [WMATA Timings Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
    ///
    /// - Parameters:
    ///     - station: Station to search for timings for
    ///
    /// - Returns: A Combine Publisher for  [StationTimings](x-source-tag://StationTimings)
    func timingsPublisher(for station: Station) -> AnyPublisher<StationTimings, WMATAError> {
        (self as NeedsStation).timingsPublisher(for: station, key: key, session: urlSession)
    }
}

extension MetroRail: NeedsLine {}

public extension MetroRail {
    /// Stations along a Line
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStations)
    ///
    /// - Note:
    ///     [WMATA Stations Documentation]( https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
    ///
    /// - Parameters:
    ///     - line: Line to receive stations along. Omit to receive all stations.
    func stations(for line: Line? = nil) {
        (self as NeedsLine).stations(for: line, key: key, session: urlSession)
    }

    /// Stations along a Line
    ///
    /// - Note:
    ///     [WMATA Stations Documentation]( https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
    ///
    /// - Parameters:
    ///     - line: Line to receive stations along. Omit to receive all stations.
    ///     - completion: A completion handler
    ///     - result: [Stations](x-source-tag://Stations) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func stations(for line: Line? = nil, completion: @escaping (_ result: Result<Stations, WMATAError>) -> Void) {
        (self as NeedsLine).stations(for: line, key: key, session: urlSession, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroRail {
    /// Stations along a Line
    ///
    /// - Note:
    ///     [WMATA Stations Documentation]( https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
    ///
    /// - Parameters:
    ///     - line: Line to receive stations along. Omit to receive all stations.
    ///
    /// - Returns: A Combine Publisher for [Stations](x-source-tag://Stations)
    func stationsPublisher(for line: Line? = nil) -> AnyPublisher<Stations, WMATAError> {
        (self as NeedsLine).stationsPublisher(for: line, key: key, session: urlSession)
    }
}

extension MetroRail: GTFSRTFetcher {}

/// GTFS-RT Calls
public extension MetroRail {
    /// GTFS RT 2.0 service alerts feed for WMATA rail.
    ///
    /// - Note:
    ///     [Google Alerts Documentation](https://developers.google.com/transit/gtfs-realtime/guides/service-alerts)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: `TransitRealtime_FeedMessage` if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func alerts(completion: @escaping (_ result: Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTRailURL.alerts.rawValue, key: key),
            session: urlSession,
            completion: completion
        )
    }

    /// GTFS RT 2.0 service alerts feed for WMATA rail.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateAlerts)
    ///
    /// - Note:
    ///     [Google Alerts Documentation](https://developers.google.com/transit/gtfs-realtime/guides/service-alerts)
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
    ///
    /// - Note:
    ///     [Google Trip Updates Documentation](https://developers.google.com/transit/gtfs-realtime/guides/trip-updates)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: `TransitRealtime_FeedMessage` if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func tripUpdates(completion: @escaping (_ result: Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
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
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateTripUpdates)
    ///
    /// - Note:
    ///     [Google Trip Updates Documentation](https://developers.google.com/transit/gtfs-realtime/guides/trip-updates)
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
    ///
    /// - Note:
    ///     [Google Vehicle Positions Documentation]( https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: `TransitRealtime_FeedMessage` if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func vehiclePositions(completion: @escaping (_ result: Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTRailURL.vehiclePositions.rawValue, key: key),
            session: urlSession,
            completion: completion
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA rail.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateVehiclePositions)
    ///
    /// - Note:
    ///     [Google Vehicle Positions Documentation]( https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions)
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
    ///
    /// - Note:
    ///     [Google Alerts Documentation](https://developers.google.com/transit/gtfs-realtime/guides/service-alerts)
    ///
    /// - Returns: A Combine Publisher for `TransitRealtime_FeedMessage`
    func alertsPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(url: GTFSRTRailURL.alerts.rawValue, key: key),
            session: urlSession
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA rail.
    ///
    /// - Note:
    ///     [WMATA Trip Updates Documentation](https://developers.google.com/transit/gtfs-realtime/guides/trip-updates)
    ///
    /// - Returns: A Combine Publisher for `TransitRealtime_FeedMessage`
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
    ///
    /// - Note:
    ///     [WMATA Vehicle Positions Documentation](https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions)
    ///
    /// - Returns: A Combine Publisher for`TransitRealtime_FeedMessage`
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
