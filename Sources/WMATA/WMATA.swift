//
//  WMATA.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//
import Foundation

/// Main way of interacting with the WMATA API
class WMATA {
    /// WMATA API key from dev portal
    var apiKey: String
    
    /// URLSession to use for all requests
    var session: URLSession
    
    /// General MetroRail information
    lazy var rail: Rail = {
        return Rail(apiKey: self.apiKey)
        
    }()
    
    /// General MetroBus information
    lazy var bus: Bus = {
        return Bus(apiKey: self.apiKey)
        
    }()
    
    /// Set up WMATA
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter session: Session to call on requests on
    init(apiKey: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
        
    }
    
    /// Subscript support for Stations
    subscript(index: Station.Code) -> Station {
        return Station(apiKey: self.apiKey, code: index)
        
    }
    
    /// Subscript support for Line
    subscript(index: Line.Code) -> Line {
        return Line(apiKey: self.apiKey, line: index)
        
    }
    
    /// Subscript support for Stops
    subscript(index: String) -> Stop {
        return Stop(apiKey: self.apiKey, stopId: index)
        
    }
    
    /// Subscript support for Routes
    subscript(index: Route.Id) -> Route {
        return Route(apiKey: self.apiKey, routeId: index)
        
    }
    
}
