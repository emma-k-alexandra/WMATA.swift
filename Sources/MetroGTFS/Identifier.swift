//
//  WMATAIdentifier.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation

public extension GTFS {
    /// A generic identifier. Used to associate a specific type with some structure used within the WMATA.swift project.
    ///
    ///  This type encodes to a single value in JSON.
    ///
    ///  This type uses a Phantom Generic to differentate IDs of different data types.
    struct Identifier<Structure>: Equatable, Hashable {
        
        /// The identifier for the current `Structure`.
        public let string: String
        
        /// Create a new Identifier with the given id.
        public init(_ id: String) {
            self.string = id
        }
    }
}

extension GTFS.Identifier: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.string = try container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.string)
    }
}
