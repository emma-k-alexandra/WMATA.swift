//
//  Bus.swift
//  
//
//  Created by Emma Foster on 6/18/19.
//

import Foundation

/// General information for MetroBus
public class Bus: Fetcher, RequestBuilder {
    
    /// URLs of WMATA endpoints relating to MetroBus
    enum Urls: String {
        case routes = "https://api.wmata.com/Bus.svc/json/jRoutes"
        case stops = "https://api.wmata.com/Bus.svc/json/jStops"
        case incidents = "https://api.wmata.com/Incidents.svc/json/BusIncidents"
    }
    
    /// WMATA API key from dev portal
    public var key: String
    
    /// URLSession to use for all requests
    public var urlSession: URLSession
    
    private var decoder = JSONDecoder()
    
    /// Set up Bus
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, session: URLSession = URLSession.shared) {
        self.key = apiKey
        self.urlSession = session
        
    }
    
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter routeId: Get bus positions along this route
    /// - parameter latitude: Latitude to search around
    /// - parameter longitude: Longitude to search around
    /// - parameter radius: Radius in meters to search along given latlong
    /// - parameter completion: Completion handler which returns `BusPositions`
    public func positions(routeId: Route.Id?, latitude: Double?, longitude: Double?, radius: Double?, completion: @escaping (Result<BusPositions, WMATAError>) -> ()){
        var queryItems = [(String, String)]()
        
        if let routeId = routeId {
            queryItems.append(("RouteID", routeId.rawValue))
            
        }
        
        if let latitude = latitude {
            queryItems.append(("Lat", String(latitude)))
            
        }
        
        if let longitude = longitude {
            queryItems.append(("Lon", String(longitude)))
            
        }
        
        if let radius = radius {
            queryItems.append(("Radius", String(radius)))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Route.Urls.positions.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// All bus routes and variants
    ///
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func routes(completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Bus.Urls.routes.rawValue, andQueryItems: []), completion: completion)
        
    }
    
    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter latitude: Latitude to search around
    /// - parameter longitude: Longitude to search around
    /// - parameter radius: Radius in meters to search within
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    public func searchStops(latitude: Double?, longitude: Double?, radius: Double?, completion: @escaping (Result<StopsSearchResponse, WMATAError>) -> ()) {
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
        
        self.fetch(with: self.buildRequest(fromUrl: Bus.Urls.stops.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - parameter completion: Completion handler which returns `BusIncidents`
    public func incidents(route: Route.Id?, completion: @escaping (Result<BusIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let route = route {
            queryItems.append(("Route", route.rawValue))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Bus.Urls.incidents.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
}

extension Bus: ApiKey {
    func apiKey() -> String {
        self.key
    }
    
    
}

extension Bus: Session {
    func session() -> URLSession {
        self.urlSession
    }
    
    
}
