//
//  Routes.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// A WMATA Route
public struct Route {
    /// A WMATA Route ID
    public let id: String

    /// Create a Route ID
    ///
    /// - Parameters:
    ///     - id: A Route ID
    public init(id: String) {
        self.id = id
    }
}

extension Route: Codable {
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        
        self.id = try value.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(id)
    }
}

extension Route: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        id = value
    }
}

extension Route: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case routeID = "RouteID"
        case route = "Route"
    }
    
    func queryItem(name: URLQueryItemName = .routeID) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: id)
    }
}
