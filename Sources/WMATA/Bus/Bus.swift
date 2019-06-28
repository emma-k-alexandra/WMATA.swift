//
//  Bus.swift
//  
//
//  Created by Emma Foster on 6/18/19.
//

import Foundation

/// General information for MetroBus
public class Bus {
    
    /// URLs of WMATA endpoints relating to MetroBus
    enum Urls: String {
        case routes = "https://api.wmata.com/Bus.svc/json/jRoutes"
        case stops = "https://api.wmata.com/Bus.svc/json/jStops"
        case incidents = "https://api.wmata.com/Incidents.svc/json/BusIncidents"
    }
    
    /// WMATA API key from dev portal
    public var apiKey: String
    
    /// URLSession to use for all requests
    public var session: URLSession
    
    private var decoder = JSONDecoder()
    
    /// Set up Bus
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
        
    }
    
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter routeId: Get bus positions along this route
    /// - parameter latitude: Latitude to search around
    /// - parameter longitude: Longitude to search around
    /// - parameter radius: Radius in meters to search along given latlong
    /// - parameter completion: Completion handler which returns `BusPositions`
    public func positions(routeId: Route.Id?, latitude: Double?, longitude: Double?, radius: Double?, completion: @escaping (_ result: BusPositions?, _ error: WMATAError?) -> ()){
        var urlComponents = URLComponents(string: Route.Urls.positions.rawValue)!
        
        if let populatedRouteId = routeId {
            urlComponents.queryItems?.append(URLQueryItem(name: "RouteID", value: populatedRouteId.rawValue))
            
        }
        
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
            
            decode(data: populatedData, ofType: BusPositions.self, completion: completion)
            
        }.resume()
        
    }
    
    /// All bus routes and variants
    ///
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func routes(completion: @escaping (_ result: RoutesResponse?, _ error: WMATAError?) -> ()) {
        var request = URLRequest(url: URL(string: Bus.Urls.routes.rawValue)!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: RoutesResponse.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter latitude: Latitude to search around
    /// - parameter longitude: Longitude to search around
    /// - parameter radius: Radius in meters to search within
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    public func searchStops(latitude: Double?, longitude: Double?, radius: Double?, completion: @escaping (_ result: StopsSearchResponse?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Bus.Urls.stops.rawValue)!
        
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
            
            decode(data: populatedData, ofType: StopsSearchResponse.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - parameter completion: Completion handler which returns `BusIncidents`
    public func incidents(route: Route.Id?, completion: @escaping (_ result: BusIncidents?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Bus.Urls.incidents.rawValue)!
        
        if let populatedRoute = route {
            urlComponents.queryItems?.append(URLQueryItem(name: "Route", value: populatedRoute.rawValue))
            
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: BusIncidents.self, completion: completion)
            
        }.resume()
        
    }
    
}
