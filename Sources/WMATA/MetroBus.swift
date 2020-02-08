//
//  MetroBus.swift
//  
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation
import GTFS

/// MetroBus related methods
public struct MetroBus: Fetcher {
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

// These don't require any Route or Stop IDs
extension MetroBus {
    /// All bus routes and variants
    public func routes() {
        self.request(
            with: URLRequest(url: BusURL.routes.rawValue, queryItems: [], apiKey: self.key),
            and: self.urlSession
        )
        
    }
    
    /// All bus routes and variants
    ///
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func routes(completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: BusURL.routes.rawValue, queryItems: [], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    public func searchStops(at radiusAtCoordinates: RadiusAtCoordinates?) {
        var queryItems = [(String, String)]()
        
        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
            
        }
        
        self.request(
            with: URLRequest(url: BusURL.stops.rawValue, queryItems: queryItems, apiKey: self.key),
            and: self.urlSession
        )
        
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
        
        self.fetch(
            with: URLRequest(url: BusURL.stops.rawValue, queryItems: queryItems, apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
}

extension MetroBus: NeedsRoute {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    public func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, with: self.key, and: self.urlSession)
        
    }
    
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `BusPositions`
    public func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<BusPositions, WMATAError>) -> ()) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    public func incidents(on route: Route?) {
        (self as NeedsRoute).incidents(on: route, with: self.key, and: self.urlSession)
        
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
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    public func pathDetails(for route: Route, on date: WMATADate? = nil) {
        (self as NeedsRoute).pathDetails(for: route, on: date, with: self.key, and: self.urlSession)
        
    }
    
    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    /// - parameter completion: Completion handler which returns `PathDetails`
    public func pathDetails(for route: Route, on date: WMATADate? = nil, completion: @escaping (Result<PathDetails, WMATAError>) -> ()) {
        (self as NeedsRoute).pathDetails(for: route, on: date, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    public func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, withApiKey: self.key, andSession: urlSession)
        
    }
    
    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, completion: @escaping (Result<RouteSchedule, WMATAError>) -> ()) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
}

extension MetroBus: NeedsStop {
    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    public func nextBuses(for stop: Stop) {
        (self as NeedsStop).nextBuses(for: stop, with: self.key, and: self.urlSession)
        
    }
    
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
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    public func schedule(for stop: Stop, at date: WMATADate? = nil) {
        (self as NeedsStop).schedule(for: stop, at: date, with: self.key, and: self.urlSession)
        
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    public func schedule(for stop: Stop, at date: WMATADate? = nil, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        (self as NeedsStop).schedule(for: stop, at: date, withApiKey: self.key, andSession: self.urlSession, completion: completion)
        
    }
    
}

extension MetroBus: GTFSRTFetcher {}

/// GTFS-RT
extension MetroBus {
    public func alerts(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: GTFSRTBusURL.alerts.rawValue, queryItems: [], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    public func alerts() {
        self.request(
            with: URLRequest(
                url: GTFSRTBusURL.alerts.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            and: self.urlSession
        )
        
    }
    
    public func tripUpdates(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(
                url: GTFSRTBusURL.tripUpdates.rawValue,
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
                url: GTFSRTBusURL.tripUpdates.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            and: self.urlSession
        )
        
    }
    
    public func vehiclePositions(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: GTFSRTBusURL.vehiclePositions.rawValue, queryItems: [], apiKey: self.key),
            andSession: self.urlSession,
            completion: completion
        )
        
    }
    
    public func vehiclePositions() {
        self.request(
            with: URLRequest(
                url: GTFSRTBusURL.vehiclePositions.rawValue,
                queryItems: [],
                apiKey: self.key
            ),
            and: self.urlSession
        )
        
    }

}
