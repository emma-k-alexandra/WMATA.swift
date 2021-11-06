//
//  Stops.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Combine
import Foundation

/// A bus stop
public struct Stop {
    /// A WMATA Stop ID
    public let id: String

    /// Create a bus stop
    ///
    /// - Parameters:
    ///     - id: A Stop ID
    public init(id: String) {
        self.id = id
    }
}

extension Stop: Codable {
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        
        self.id = try value.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(id)
    }
}

extension Stop: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        id = value
    }
}

extension Stop: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case standard = "StopID"
    }
    
    func queryItem(name: URLQueryItemName = .standard) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: id)
    }
}
