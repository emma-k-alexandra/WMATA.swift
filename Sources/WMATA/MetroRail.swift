//
//  MetroRail.swift
//  
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation
import GTFS

/// MetroRail related methods
public struct MetroRail: Fetcher {
    public let key: String
    public var delegate: WMATADelegate? = nil {
        didSet {
            if let delegate = self.delegate {
                self.urlSession = generateURLSession(with: delegate)
                
            }
            
        }
        
    }
    private var urlSession: URLSession
    
    public init(key: String) {
        self.key = key
        self.urlSession = URLSession.shared
        
    }
    
    public init(key: String, delegate: WMATADelegate) {
        self.key = key
        self.delegate = delegate
        self.urlSession = generateURLSession(with: delegate)
        
    }
    
}

// These don't require a Station or Line
extension MetroRail {
    /// General information on all MetroRail lines
    public func lines() {
        self.request(
            with: URLRequest(url: RailURL.lines.rawValue, queryItems: [], apiKey: self.key),
            and: self.urlSession
        )
        
    }
    
    /// General information on all MetroRail lines
    ///
    /// - parameter completion: Completion handler which returns `LinesResponse`
    public func lines(completion: @escaping (Result<LinesResponse, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.lines.rawValue, queryItems: [], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter radiusAtCoordinates:`RadiusAtCoordinates` to search at
    public func entrances(at radiusAtCoordinates: RadiusAtCoordinates?) {
        var queryItems = [(String, String)]()
        
        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
            
        }
        
        self.request(
            with: URLRequest(url: RailURL.entrances.rawValue, queryItems: queryItems, apiKey: self.key),
            and: self.urlSession
        )
        
    }
    
    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter radiusAtCoordinates:`RadiusAtCoordinates` to search at
    /// - parameter completion: Completion handler which returns `StationEntrances`
    public func entrances(at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<StationEntrances, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
            
        }
        
        self.fetch(
            with: URLRequest(url: RailURL.entrances.rawValue, queryItems: queryItems, apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    public func positions() {
        self.request(
            with: URLRequest(url: RailURL.positions.rawValue, queryItems: [("contentType", "json")], apiKey: self.key),
            and: self.urlSession
        )
        
    }
    
    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - parameter completion: Completion handler which returns `TrainPositions`
    public func positions(completion: @escaping (Result<TrainPositions, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.positions.rawValue, queryItems: [("contentType", "json")], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    /// Ordered list of track circuits, arranged by line and track number
    public func routes() {
        self.request(
            with: URLRequest(url: RailURL.routes.rawValue, queryItems: [("contentType", "json")], apiKey: self.key),
            and: self.urlSession
        )
        
    }
    
    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - parameter completion: Completion handler which returns `StandardRoutes`
    public func routes(completion: @escaping (Result<StandardRoutes, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.routes.rawValue, queryItems: [("contentType", "json")], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    public func circuits() {
        self.request(
            with: URLRequest(url: RailURL.circuits.rawValue, queryItems: [("contentType", "json")], apiKey: self.key),
            and: self.urlSession
        )
        
    }
    
    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - parameter completion: Completion handler which returns `TrackCircuits`
    public func circuits(completion: @escaping (Result<TrackCircuits, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.circuits.rawValue, queryItems: [("contentType", "json")], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
}

extension MetroRail: NeedsStation {
    
    public func station(_ station: Station?, to destinationStation: Station?) {
        (self as NeedsStation).station(station, to: destinationStation, with: self.key, and: self.urlSession)
        
    }
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    /// - parameter completion: Completion handler which returns
    public func station(_ station: Station?, to destinationStation: Station?, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> ()) {
        (self as NeedsStation).station(station, to: destinationStation, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Reported elevator and escalator incidents
    ///
    /// - parameter station: Which station to search for incidents at. Optional.
    public func elevatorAndEscalatorIncidents(at station: Station?) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, with: self.key, and: self.urlSession)
        
    }
    
    /// Reported elevator and escalator incidents
    ///
    /// - parameter station: Which station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns
    public func elevatorAndEscalatorIncidents(at station: Station?, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> ()) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: station, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Reported MetroRail incidents
    ///
    /// - parameter station: Station to search for incidents at. Optional.
    public func incidents(at station: Station?) {
        (self as NeedsStation).incidents(at: station, with: self.key, and: self.urlSession)
        
    }
    
    /// Reported MetroRail incidents
    ///
    /// - parameter station: Station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `RailIncidents`
    public func incidents(at station: Station?, completion: @escaping (Result<RailIncidents, WMATAError>) -> ()) {
        (self as NeedsStation).incidents(at: station, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Next train arrival information for this station
    ///
    /// - parameter station: `Station` to search for trains at
    public func nextTrains(at station: Station) {
        (self as NeedsStation).nextTrains(at: station, with: self.key, and: self.urlSession)
        
    }
    
    /// Next train arrival information for this station
    ///
    /// - parameter station: `Station` to search for trains at
    /// - parameter completion: Completion handler which returns `RailPredictions`
    public func nextTrains(at station: Station, completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        (self as NeedsStation).nextTrains(at: station, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Next train arrival information for the given stations
    ///
    /// - parameter stations: `[Station]`s to look up next trains for
    public func nextTrains(at stations: [Station]) {
        (self as NeedsStation).nextTrains(at: stations, with: self.key, and: self.urlSession)
        
    }
    
    /// Next train arrival information for the given stations
    ///
    /// - parameter stations: `[Station]`s to look up next trains for
    /// - parameter completion: Completion handler which returns `RailPredictions`
    public func nextTrains(at stations: [Station], completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        (self as NeedsStation).nextTrains(at: stations, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Location and address information for this station
    ///
    /// - parameter station: `StationCode` search for information for
    public func information(for station: Station) {
        (self as NeedsStation).information(for: station, with: self.key, and: self.urlSession)
        
    }
    
    /// Location and address information for this station
    ///
    /// - parameter station: `StationCode` search for information for
    /// - parameter completion: Completion handler which returns `StationInformation`
    public func information(for station: Station, completion: @escaping (Result<StationInformation, WMATAError>) -> ()) {
        (self as NeedsStation).information(for: station, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Parking information for this station
    ///
    /// - parameter station: `StationCode` to search for parking information for
    public func parkingInformation(for station: Station) {
        (self as NeedsStation).parkingInformation(for: station, with: self.key, and: self.urlSession)
        
    }
    
    /// Parking information for this station
    ///
    /// - parameter station: `StationCode` to search for parking information for
    /// - parameter completion: Completion handler which returns `StationsParking`
    public func parkingInformation(for station: Station, completion: @escaping (Result<StationsParking, WMATAError>) -> ()) {
        (self as NeedsStation).parkingInformation(for: station, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - parameter startingStation: Starting station to pathfind from
    /// - parameter destinationStation: Destination station to pathfind to
    public func path(from startingStation: Station, to destinationStation: Station) {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, with: self.key, and: self.urlSession)
        
    }
    
    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - parameter startingStation: Starting station to pathfind from
    /// - parameter destinationStation: Destination station to pathfind to
    /// - parameter completion: Completion handler which returns `PathBetweenStations`
    public func path(from startingStation: Station, to destinationStation: Station, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> ()) {
        (self as NeedsStation).path(from: startingStation, to: destinationStation, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Opening and scheduled first and last trains for this station
    ///
    /// - parameter station: `StationCode` to search for timings for
    public func timings(for station: Station) {
        (self as NeedsStation).timings(for: station, with: self.key, and: self.urlSession)
        
    }
    
    /// Opening and scheduled first and last trains for this station
    ///
    /// - parameter station: `StationCode` to search for timings for
    /// - parameter completion: Completion handler which returns `StationTimings`
    public func timings(for station: Station, completion: @escaping (Result<StationTimings, WMATAError>) -> ()) {
        (self as NeedsStation).timings(for: station, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
}

extension MetroRail: NeedsLine {
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    public func stations(for line: Line?) {
        (self as NeedsLine).stations(for: line, with: self.key, and: self.urlSession)
        
    }
    
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    /// - parameter completion: Completion handler which returns `Stations`
    public func stations(for line: Line?, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        (self as NeedsLine).stations(for: line, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
}

extension MetroRail: GTFSRTFetcher {}

/// GTFS-RT Calls
extension MetroRail {
    public func alerts(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: GTFSRTRailURL.alerts.rawValue, queryItems: [], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    public func alerts() {
        self.request(
            with: URLRequest(
                url: GTFSRTRailURL.alerts.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            and: self.urlSession
        )
        
    }
    
    public func tripUpdates(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(
                url: GTFSRTRailURL.tripUpdates.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    public func tripUpdates() {
        self.request(
            with: URLRequest(
                url: GTFSRTRailURL.tripUpdates.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            and: self.urlSession
        )
        
    }
    
    public func vehiclePositions(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: GTFSRTRailURL.vehiclePositions.rawValue, queryItems: [], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    public func vehiclePositions() {
        self.request(
            with: URLRequest(
                url: GTFSRTRailURL.vehiclePositions.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            and: self.urlSession
        )
        
    }
    
}
