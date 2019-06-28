//
//  Rail.swift
//  
//
//  Created by Emma Foster on 6/17/19.
//

import Foundation

/// General information for MetroRail
public class Rail {
    
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
    public var apiKey: String
    
    /// URLSession to use for all requests
    public var session: URLSession
    
    private var decoder = JSONDecoder()
    
    /// Set up Rail
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
        
    }
    
    /// General information on all MetroRail lines
    ///
    /// - parameter completion: Completion handler which returns `LinesResponse`
    public func lines(completion: @escaping (_ result: LinesResponse?, _ error: WMATAError?) -> ()) {
        var request = URLRequest(url: URL(string: Rail.Urls.lines.rawValue)!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: LinesResponse.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Station entrances within a radius of a lat long pair, omit all parameters to receive all entrances
    ///
    /// - parameter latitude: Latitude to search at
    /// - parameter longitude: Longitude to search at
    /// - parameter radius: Radius in meters to search within
    /// - parameter completion: Completion handler which returns `StationEntrances`
    public func entrances(latitude: Double?, longitude: Double?, radius: Double?, completion: @escaping (_ result: StationEntrances?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Rail.Urls.entrances.rawValue)!
        
        if let populatedLatitude = latitude {
            urlComponents.queryItems?.append(URLQueryItem(name: "Lat", value: String(populatedLatitude)))
            
        }
        
        if let populatedLongitude = longitude {
            urlComponents.queryItems?.append(URLQueryItem(name: "Lon", value: String(populatedLongitude)))
            
        }
        
        if let populatedRadius = radius {
            urlComponents.queryItems?.append(URLQueryItem(name: "Radius", value: String(populatedRadius)))
            
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: StationEntrances.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along. Omit to receive all stations.
    /// - parameter completion: Completion handler which returns `Stations`
    public func stations(for line: Line.Code?, completion: @escaping (_ result: Stations?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Line.Urls.stations.rawValue)!
        
        if let populatedLine = line {
            urlComponents.queryItems = [
                URLQueryItem(name: "LineCode", value: populatedLine.rawValue)
            ]
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: Stations.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Distance, fare information, and estimated travel time between any two stations. Omit both station codes to receive information for all possible trips.
    ///
    /// - parameter station: Station to start trip at
    /// - parameter destinationStation: Station to travel to
    /// - parameter completion: Completion handler which returns `StationToStationInfos`
    public func station(_ station: Station.Code?, to destinationStation: Station.Code?, completion: @escaping (_ result: StationToStationInfos?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Station.Urls.stationToStation.rawValue)!
        
        if let populatedStation = station {
            urlComponents.queryItems?.append(URLQueryItem(name: "FromStationCode", value: populatedStation.rawValue))
            
        }
        
        if let populatedDestinationStation = destinationStation {
            urlComponents.queryItems?.append(URLQueryItem(name: "ToStationCode", value: populatedDestinationStation.rawValue))
            
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: StationToStationInfos.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// - parameter completion: Completion handler which returns `TrainPositions`
    public func positions(completion: @escaping (_ result: TrainPositions?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Rail.Urls.positions.rawValue)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "contentType", value: "json")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: TrainPositions.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Ordered list of track circuits, arranged by line and track number
    ///
    /// - parameter completion: Completion handler which returns `StandardRoutes`
    public func routes(completion: @escaping (_ result: StandardRoutes?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Rail.Urls.routes.rawValue)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "contentType", value: "json")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: StandardRoutes.self, completion: completion)
            
        }.resume()
        
    }
    
    /// List of all track circuits - See https://developer.wmata.com/TrainPositionsFAQ
    ///
    /// - parameter completion: Completion handler which returns `TrackCircuits`
    public func circuits(completion: @escaping (_ result: TrackCircuits?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Rail.Urls.circuits.rawValue)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "contentType", value: "json")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: TrackCircuits.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Reported elevator and escalator incidents
    ///
    /// - parameter at: Which station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `ElevatorAndEscalatorIncidents`
    public func elevatorAndEscalatorIncidents(at station: Station.Code?, completion: @escaping (_ result: ElevatorAndEscalatorIncidents?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Rail.Urls.elevatorAndEscalatorIncidents.rawValue)!
        
        if let populatedStation = station {
            urlComponents.queryItems?.append(URLQueryItem(name: "StationCode", value: populatedStation.rawValue))
            
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: ElevatorAndEscalatorIncidents.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Reported MetroRail incidents
    ///
    /// - parameter at: Station to search for incidents at. Optional.
    /// - parameter completion: Completion handler which returns `RailIncidents`
    public func incidents(at station: Station.Code?, completion: @escaping (_ result: RailIncidents?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Rail.Urls.incidents.rawValue)!
        
        if let populatedStation = station {
            urlComponents.queryItems?.append(URLQueryItem(name: "StationCode", value: populatedStation.rawValue))
            
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: RailIncidents.self, completion: completion)
            
        }.resume()
        
    }
        
}
