//
//  RailClient.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

/// MetroRail related methods
public struct RailClient: Fetcher, RequestBuilder {
    public let key: String
    public var urlSession: URLSession
    
    init(key: String) {
        self.key = key
        self.urlSession = URLSession.shared
        
    }
    
    init(key: String, urlSession: URLSession) {
        self.key = key
        self.urlSession = urlSession
        
    }
    
}

// These don't required a Station or Line Code
extension RailClient {
    /// General information on all MetroRail lines
    ///
    /// - parameter completion: Completion handler which returns `LinesResponse`
    public func lines(completion: @escaping (Result<LinesResponse, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.lines.rawValue, andQueryItems: []), completion: completion)
        
    }
    
    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter latitude: Latitude to search at
    /// - parameter longitude: Longitude to search at
    /// - parameter radius: Radius in meters to search within
    /// - parameter completion: Completion handler which returns `StationEntrances`
    public func entrances(at radiusAtLatLong: RadiusAtLatLong?, completion: @escaping (Result<StationEntrances, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let radiusAtLatLong = radiusAtLatLong {
            queryItems.append(contentsOf: radiusAtLatLong.toQueryItems())
        }
        
        self.fetch(with: self.buildRequest(fromUrl: RailURL.entrances.rawValue,andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - parameter completion: Completion handler which returns `TrainPositions`
    public func positions(completion: @escaping (Result<TrainPositions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.positions.rawValue, andQueryItems: [("contentType", "json")]), completion: completion)
        
    }
    
    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - parameter completion: Completion handler which returns `StandardRoutes`
    public func routes(completion: @escaping (Result<StandardRoutes, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.routes.rawValue, andQueryItems: [("contentType", "json")]), completion: completion)
        
    }
    
    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - parameter completion: Completion handler which returns `TrackCircuits`
    public func circuits(completion: @escaping (Result<TrackCircuits, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.circuits.rawValue, andQueryItems: [("contentType", "json")]), completion: completion)
        
    }
}

// These require a Station code
extension RailClient {
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    /// - parameter completion: Completion handler which returns `StationToStationInfos`
    public func station(_ station: StationCode?, to destinationStation: StationCode?, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
            
        }
        
        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: RailURL.stationToStation.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Reported elevator and escalator incidents
    ///
    /// - parameter at: Which station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `ElevatorAndEscalatorIncidents`
    public func elevatorAndEscalatorIncidents(at station: StationCode?, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: RailURL.elevatorAndEscalatorIncidents.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Reported MetroRail incidents
    ///
    /// - parameter at: Station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `RailIncidents`
    public func incidents(at station: StationCode?, completion: @escaping (Result<RailIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: RailURL.incidents.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Next train arrival information for this station
    ///
    /// - parameter station: `StationCode` to search for trains at
    /// - parameter completion: Completion handler which returns `RailPredictions`
    public func nextTrains(at station: StationCode, completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: "\(RailURL.nextTrains)/\(station)", andQueryItems: []), completion: completion)
        
    }
    
    /// Location and address information for this station
    ///
    /// - parameter station: `StationCode` search for information for
    /// - parameter completion: Completion handler which returns `StationInformation`
    public func information(for station: StationCode, completion: @escaping (Result<StationInformation, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.information.rawValue, andQueryItems: [("StationCode", station.rawValue)]), completion: completion)
        
    }
    
    /// Parking information for this station
    ///
    /// - parameter station: `StationCode` to search for parking information for
    /// - parameter completion: Completion handler which returns `StationsParking`
    public func parkingInformation(for station: StationCode, completion: @escaping (Result<StationsParking, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.parkingInformation.rawValue, andQueryItems: [("StationCode", station.rawValue)]), completion: completion)
        
    }
    
    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - parameter from: Starting station to pathfind from
    /// - parameter to: Destination station to pathfind to
    /// - parameter completion: Completion handler which returns `PathBetweenStations`
    public func path(from startingStation: StationCode, to destinationStation: StationCode, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.path.rawValue, andQueryItems: [("FromStationCode", startingStation.rawValue), ("ToStationCode", destinationStation.rawValue)]), completion: completion)
        
    }
    
    /// Opening and scheduled first and last trains for this station
    ///
    /// - parameter station: `StationCode` to search for timings for
    /// - parameter completion: Completion handler which returns `StationTimings`
    public func timings(for station: StationCode, completion: @escaping (Result<StationTimings, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: RailURL.timings.rawValue, andQueryItems: [("StationCode", station.rawValue)]), completion: completion)
        
    }
    
}

// These require a Line code
extension RailClient {
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    /// - parameter completion: Completion handler which returns `Stations`
    public func stations(for line: LineCode?, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let line = line {
            queryItems.append(("LineCode", line.rawValue))

        }
        
        self.fetch(with: self.buildRequest(fromUrl: RailURL.stations.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
}

extension RailClient: ApiKey {
    func apiKey() -> String {
        self.key
        
    }
    
}

extension RailClient: Session {
    func session() -> URLSession {
        self.urlSession
        
    }
    
}
