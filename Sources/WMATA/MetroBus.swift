//
//  BusClient.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

/// MetroBus related methods
public struct MetroBus: Fetcher, RequestBuilder {
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

// These don't require any Route or Stop IDs
extension MetroBus {
    /// All bus routes and variants
    ///
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func routes(completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: BusURL.routes.rawValue, andQueryItems: [], withApiKey: self.key), andSession: self.urlSession, completion: completion)
        
    }
    
    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    public func searchStops(at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<StopsSearchResponse, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.stops.rawValue, andQueryItems: queryItems, withApiKey: self.key), andSession: self.urlSession, completion: completion)
        
    }
    
}

extension MetroBus: NeedsRoute {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter routeId: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `BusPositions`
    public func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<BusPositions, WMATAError>) -> ()) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, withApiKey: self.key, andSession: self.urlSession, completion: completion)
    }
    
    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - parameter completion: Completion handler which returns `BusIncidents`
    public func incidents(on route: Route?, completion: @escaping (Result<BusIncidents, WMATAError>) -> ()) {
        (self as NeedsRoute).incidents(on: route, withApiKey: self.key, andSession: self.urlSession, completion: completion)
    }
    
    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive path information. Omit for today.
    /// - parameter completion: Completion handler which returns `PathDetails`
    public func pathDetails(for route: Route, on date: String? = nil, completion: @escaping (Result<PathDetails, WMATAError>) -> ()) {
        (self as NeedsRoute).pathDetails(for: route, on: date, withApiKey: self.key, andSession: self.urlSession, completion: completion)
    }
    
    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive scheduled stops
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func schedule(for route: Route, on date: String? = nil, includingVariations: Bool? = false, completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, withApiKey: self.key, andSession: self.urlSession, completion: completion)
    }
}

extension MetroBus: NeedsStop {
    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    /// - parameter completion: Completion handler which returns `BusPredictions`
    public func nextBuses(for stop: Stop, completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        (self as NeedsStop).nextBuses(for: stop, withApiKey: self.key, andSession: self.urlSession, completion: completion)
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    public func schedule(for stop: Stop, at date: String? = nil, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        (self as NeedsStop).schedule(for: stop, at: date, withApiKey: self.key, andSession: self.urlSession, completion: completion)
    }
}
