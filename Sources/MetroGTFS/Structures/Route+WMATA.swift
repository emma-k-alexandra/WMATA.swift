//
//  Route+WMATA.swift
//
//
//  Created by Emma on 3/24/24.
//

import Foundation

#if canImport(WMATA)

import WMATA

public extension GTFSRoute {
    /// Create a ``GTFSRoute`` from a WMATA `Line`.
    ///
    /// - Parameters:
    ///   - line: A WMATA package `Line`.
    init(line: Line) throws {
        try self.init(id: .init(line.name.uppercased()))
    }
}

#endif
