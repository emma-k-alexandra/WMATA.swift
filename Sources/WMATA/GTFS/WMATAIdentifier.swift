//
//  WMATAIdentifier.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation

/// A generic identifier. Used to associate a specific type with some structure used within the WMATA.swift project.
///
///  This type encodes to a single value in JSON.
public struct WMATAIdentifier<Structure>: Hashable, Codable {
    let string: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.string = try container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.string)
    }
}
