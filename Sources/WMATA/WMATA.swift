//
//  WMATA.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//
import Foundation

/// Main way of interacting with the WMATA API
public class WMATA {
    /// WMATA API key from dev portal
    public var apiKey: String
    
    /// URLSession to use for all requests
    public var session: URLSession
    
    /// General MetroRail information
    public lazy var rail: Rail = {
        return Rail(apiKey: self.apiKey)
        
    }()
    
    /// General MetroBus information
    public lazy var bus: Bus = {
        return Bus(apiKey: self.apiKey)
        
    }()
    
    /// Set up WMATA
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
        
    }
    
    /// Subscript support for Stations
    public subscript(index: Station.Code) -> Station {
        return Station(apiKey: self.apiKey, code: index)
        
    }
    
    /// Subscript support for Line
    public subscript(index: Line.Code) -> Line {
        return Line(apiKey: self.apiKey, line: index)
        
    }
    
    /// Subscript support for Stops
    public subscript(index: String) -> Stop {
        return Stop(apiKey: self.apiKey, stopId: index)
        
    }
    
    /// Subscript support for Routes
    public subscript(index: Route.Id) -> Route {
        return Route(apiKey: self.apiKey, routeId: index)
        
    }
    
}
