//
//  BusProtocols.swift
//  
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation

protocol NeedsRoute: Fetcher {}

extension NeedsRoute {
    func positions(on routeId: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPositions, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let routeId = routeId {
            queryItems.append(("RouteID", routeId.rawValue))
            
        }
        
        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }
        
        self.fetch(
            with: URLRequest(url: BusURL.positions.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func incidents(on route: Route?, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let route = route {
            queryItems.append(("Route", route.rawValue))
            
        }
        
        self.fetch(
            with:  URLRequest(url: BusURL.incidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }
    
    func pathDetails(for route: Route, on date: WMATADate? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<PathDetails, WMATAError>) -> ()) {
        var queryItems = [("RouteID", route.rawValue)]
        
        if let date = date {
            queryItems.append(("Date", date.description))
            
        }
        
         self.fetch(
            with:  URLRequest(url: BusURL.pathDetails.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<RouteSchedule, WMATAError>) -> ()) {
        var queryItems = [("RouteID", route.rawValue)]
        
        if let date = date {
            queryItems.append(("Date", date.description))
            
        }
        
        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
            
        }
        
        self.fetch(
            with: URLRequest(url: BusURL.routeSchedule.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
}

protocol NeedsStop: Fetcher {}

extension NeedsStop {
    func nextBuses(for stop: Stop, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        self.fetch(
            with:  URLRequest(url: BusURL.nextBuses.rawValue, queryItems: [("StopID", stop.id)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func schedule(for stop: Stop, at date: WMATADate? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        var queryItems = [("StopID", stop.id)]
        
        if let date = date {
            queryItems.append(("Date", date.description))
            
        }
        
        self.fetch(
            with:  URLRequest(url: BusURL.stopSchedule.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
}
