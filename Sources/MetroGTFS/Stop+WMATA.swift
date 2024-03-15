//
//  Stop+WMATA.swift
//
//
//  Created by Emma on 12/7/23.
//

#if canImport(WMATA)

import WMATA

public extension GTFSStop {
    /// Create a GTFS Stop from a WMATA `Station`.
    ///
    /// - Parameters:
    ///   - station: A WMATA package station
    init(station: Station) throws {
        try self.init(id: .init("STN_\(station.rawValue)"))
    }
}

#endif
