//
//  Route+URLQueryItemConvertible.swift
//  
//
//  Created by Emma on 11/12/21.
//

import Foundation

extension Route: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case routeID = "RouteID"
        case route = "Route"
    }
    
    func queryItem(name: URLQueryItemName = .routeID) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: id)
    }
}
