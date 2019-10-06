//
//  Rail.swift
//  
//
//  Created by Emma Foster on 6/17/19.
//

import Foundation

/// General information for MetroRail
public class Rail: Fetcher, RequestBuilder {
    
    /// URLs of WMATA endpoints relating to MetroRail
    enum Urls: String {
        case lines = "https://api.wmata.com/Rail.svc/json/jLines"
        case entrances = "https://api.wmata.com/Rail.svc/json/jStationEntrances"
        case positions = "https://api.wmata.com/TrainPositions/TrainPositions"
        case routes = "https://api.wmata.com/TrainPositions/StandardRoutes"
        case circuits = "https://api.wmata.com/TrainPositions/TrackCircuits"
        case elevatorAndEscalatorIncidents = "https://api.wmata.com/Incidents.svc/json/ElevatorIncidents"
        case incidents = "https://api.wmata.com/Incidents.svc/json/Incidents"
    }
    
    /// WMATA API key from dev portal
    public var key: String
    
    /// URLSession to use for all requests
    public var urlSession: URLSession
    
    private var decoder = JSONDecoder()
    
    /// Set up Rail
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, session: URLSession = URLSession.shared) {
        self.key = apiKey
        self.urlSession = session
        
    }
    
    /// General information on all MetroRail lines
    ///
    /// - parameter completion: Completion handler which returns `LinesResponse`
    public func lines(completion: @escaping (Result<LinesResponse, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.lines.rawValue, andQueryItems: []), completion: completion)
        
    }
    
    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter latitude: Latitude to search at
    /// - parameter longitude: Longitude to search at
    /// - parameter radius: Radius in meters to search within
    /// - parameter completion: Completion handler which returns `StationEntrances`
    public func entrances(latitude: Double?, longitude: Double?, radius: Double?, completion: @escaping (Result<StationEntrances, WMATAError>) -> ()) {
        
        var queryItems = [(String, String)]()
        
        if let latitude = latitude {
            queryItems.append(("Lat", String(latitude)))
            
        }
        
        if let longitude = longitude {
            queryItems.append(("Lon", String(longitude)))
            
        }
        
        if let radius = radius {
            queryItems.append(("Radius", String(radius)))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.entrances.rawValue,andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    /// - parameter completion: Completion handler which returns `Stations`
    public func stations(for line: Line.Code?, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let line = line {
            queryItems.append(("LineCode", line.rawValue))

        }
        
        self.fetch(with: self.buildRequest(fromUrl: Line.Urls.stations.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    /// - parameter completion: Completion handler which returns `StationToStationInfos`
    public func station(_ station: Station.Code?, to destinationStation: Station.Code?, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
            
        }
        
        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Station.Urls.stationToStation.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - parameter completion: Completion handler which returns `TrainPositions`
    public func positions(completion: @escaping (Result<TrainPositions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.positions.rawValue, andQueryItems: [("contentType", "json")]), completion: completion)
        
    }
    
    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - parameter completion: Completion handler which returns `StandardRoutes`
    public func routes(completion: @escaping (Result<StandardRoutes, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.routes.rawValue, andQueryItems: [("contentType", "json")]), completion: completion)
        
    }
    
    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - parameter completion: Completion handler which returns `TrackCircuits`
    public func circuits(completion: @escaping (Result<TrackCircuits, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.circuits.rawValue, andQueryItems: [("contentType", "json")]), completion: completion)
        
    }
    
    /// Reported elevator and escalator incidents
    ///
    /// - parameter at: Which station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `ElevatorAndEscalatorIncidents`
    public func elevatorAndEscalatorIncidents(at station: Station.Code?, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.elevatorAndEscalatorIncidents.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Reported MetroRail incidents
    ///
    /// - parameter at: Station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `RailIncidents`
    public func incidents(at station: Station.Code?, completion: @escaping (Result<RailIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Rail.Urls.incidents.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
}

extension Rail: Session {
    func session() -> URLSession {
        self.urlSession
        
    }
    
}

extension Rail: ApiKey {
    func apiKey() -> String {
        self.key
        
    }
    
}
