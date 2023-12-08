//
//  Stop+WMATA.swift
//
//
//  Created by Emma on 12/7/23.
//

#if canImport(WMATA)

import WMATA

extension GTFS.Stop {
    /// Create a GTFS Stop from a ``Station``
    init(station: Station) throws {
        self = try .init(id: .init("STN_\(station.rawValue)"))
    }
}

#endif
