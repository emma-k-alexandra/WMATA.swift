//
//  BusClient.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

/// MetroBus related methods
public struct BusClient: Fetcher, RequestBuilder {
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
extension BusClient {
    /// All bus routes and variants
    ///
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func routes(completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: BusURL.routes.rawValue, andQueryItems: []), completion: completion)
        
    }
    
    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtLatLong: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    public func searchStops(at radiusAtLatLong: RadiusAtCoordinates?, completion: @escaping (Result<StopsSearchResponse, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let radiusAtLatLong = radiusAtLatLong {
            queryItems.append(contentsOf: radiusAtLatLong.toQueryItems())
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.stops.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
}

// These require Route IDs
extension BusClient {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter routeId: Get bus positions along this route
    /// - parameter radiusAtLatLong: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `BusPositions`
    public func positions(on routeId: RouteID?, at radiusAtLatLong: RadiusAtCoordinates?, completion: @escaping (Result<BusPositions, WMATAError>) -> ()){
        var queryItems = [(String, String)]()
        
        if let routeId = routeId {
            queryItems.append(("RouteID", routeId.rawValue))
            
        }
        
        if let radiusAtLatLong = radiusAtLatLong {
            queryItems.append(contentsOf: radiusAtLatLong.toQueryItems())
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.positions.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - parameter completion: Completion handler which returns `BusIncidents`
    public func incidents(on route: RouteID?, completion: @escaping (Result<BusIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let route = route {
            queryItems.append(("Route", route.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.incidents.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `RouteID` to get path details for
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive path information. Omit for today.
    /// - parameter completion: Completion handler which returns `PathDetails`
    public func pathDetails(for route: RouteID, on date: String? = nil, completion: @escaping (Result<PathDetails, WMATAError>) -> ()) {
           var queryItems = [("RouteID", route.rawValue)]
           
           if let date = date {
               queryItems.append(("Date", date))
               
           }
           
           self.fetch(with: self.buildRequest(fromUrl: BusURL.pathDetails.rawValue, andQueryItems: queryItems), completion: completion)
           
       }
    
    /// Scheduled stops for this Route
    ///
    /// - parameter route: `RouteID` to get stops for
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive scheduled stops
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func schedule(for route: RouteID, on date: String? = nil, includingVariations: Bool? = false, completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        var queryItems = [("RouteID", route.rawValue)]
        
        if let date = date {
            queryItems.append(("Date", date))
            
        }
        
        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.routeSchedule.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
}

// These require Stop IDs
extension BusClient {
    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    /// - parameter completion: Completion handler which returns `BusPredictions`
    public func nextBuses(for stop: String, completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: BusURL.nextBuses.rawValue, andQueryItems: [("StopID", stop)]), completion: completion)
        
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    public func schedule(for stop: String, at date: String? = nil, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        var queryItems = [("StopID", stop)]
        
        if let date = date {
            queryItems.append(("Date", date))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: BusURL.stopSchedule.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
}

extension BusClient: ApiKey {
    func apiKey() -> String {
        self.key
        
    }
    
}

extension BusClient: Session {
    func session() -> URLSession {
        self.urlSession
        
    }
    
}
