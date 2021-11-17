//
//  Stops.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Combine
import Foundation

/// The `Stop` struct represents a MetroBus stop.
///
/// Values are `StopID`s rather than stop names. MetroBus stops are numerous and defining them all explicitly is not feasible. Check the ``Bus/StopsSearch`` endpoint from WMATA to get all avalable stops.
///
/// `StopID`s are the same as you would see on signs at a MetroBus stop.
/// 
public struct Stop {
    /// A WMATA Stop ID
    public let id: String

    /// Create a bus stop
    ///
    /// - Parameters:
    ///     - id: A `StopID`
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

