//
//  API.swift
//  
//
//  Created by Emma on 11/1/21.
//

import Foundation

internal protocol Endpoint {
    /// Endpoint URL for the Request
    var url: URLComponents { get }
    
    var key: APIKey { get }
    
    func request() -> URLRequest
}

internal enum API {
    internal enum Bus {}
    internal enum Rail {}
}

internal extension API.Rail {
    struct Lines: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jLines")
        
        let key: APIKey
        
        init(_ key: APIKey) {
            self.key = key
        }
        
        func request() -> URLRequest {
            URLRequest(url: url.url!, key: key)
        }
    }

    struct Entrances: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationEntrances")
        
        var key: APIKey
        let radiusAtCoordinates: RadiusAtCoordinates?
        
        init(key: APIKey, radiusAtCoordinates: RadiusAtCoordinates?) {
            self.key = key
            self.radiusAtCoordinates = radiusAtCoordinates
        }
        
        func request() -> URLRequest {
            var url = self.url
            url.queryItems = radiusAtCoordinates?.queryItems()
            
            return URLRequest(url: url.url!, key: key)
        }
    }

    struct Positions: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrainPositions")
        
        let key: APIKey
        let route: Route?
        let radiusAtCoordinates: RadiusAtCoordinates?
        
        init(key: APIKey, route: Route?, radiusAtCoordinates: RadiusAtCoordinates?) {
            self.key = key
            self.route = route
            self.radiusAtCoordinates = radiusAtCoordinates
        }
        
        func request() -> URLRequest {
            var queryItems = radiusAtCoordinates?.queryItems() ?? [URLQueryItem?]()
            queryItems.append(route?.queryItem(name: "RouteID"))
            
            var url = self.url
            url.queryItems = queryItems.compactMap { $0 }
            
            return URLRequest(url: url.url!, key: key)
        }
    }
}
