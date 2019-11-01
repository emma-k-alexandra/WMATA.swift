//
//  BusProtocols.swift
//  
//
//  Created by Emma Foster on 10/10/19.
//

import Foundation

protocol NeedsRoute: Fetcher, RequestBuilder {}

extension NeedsRoute {
    func positions(on routeId: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPositions, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let routeId = routeId {
            queryItems.append(("RouteID", routeId.rawValue))
            
        }
        
        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.positions.rawValue, andQueryItems: queryItems, withApiKey: apiKey), andSession: session, completion: completion)
        
    }
    
    func incidents(on route: Route?, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let route = route {
            queryItems.append(("Route", route.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.incidents.rawValue, andQueryItems: queryItems, withApiKey: apiKey), andSession: session, completion: completion)
    }
    
    func pathDetails(for route: Route, on date: String? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<PathDetails, WMATAError>) -> ()) {
        var queryItems = [("RouteID", route.rawValue)]
        
        if let date = date {
            queryItems.append(("Date", date))
            
        }
        
     self.fetch(with: self.buildRequest(fromUrl: BusURL.pathDetails.rawValue, andQueryItems: queryItems, withApiKey: apiKey), andSession: session, completion: completion)
        
    }
    
    func schedule(for route: Route, on date: String? = nil, includingVariations: Bool? = false, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<RouteSchedule, WMATAError>) -> ()) {
        var queryItems = [("RouteID", route.rawValue)]
        
        if let date = date {
            queryItems.append(("Date", date))
            
        }
        
        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.routeSchedule.rawValue, andQueryItems: queryItems, withApiKey: apiKey), andSession: session, completion: completion)
        
    }
    
}

protocol NeedsStop: Fetcher, RequestBuilder {}

extension NeedsStop {
    func nextBuses(for stop: Stop, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: BusURL.nextBuses.rawValue, andQueryItems: [("StopID", stop.id)], withApiKey: apiKey), andSession: session, completion: completion)
        
    }
    
    func schedule(for stop: Stop, at date: String? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        var queryItems = [("StopID", stop.id)]
        
        if let date = date {
            queryItems.append(("Date", date))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.stopSchedule.rawValue, andQueryItems: queryItems, withApiKey: apiKey), andSession: session, completion: completion)
        
    }
}
