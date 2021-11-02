//
//  BusEndpoints.swift
//  
//
//  Created by Emma on 11/1/21.
//

import Foundation

internal extension API.Bus {
    struct Positions: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jBusPositions")
        
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
