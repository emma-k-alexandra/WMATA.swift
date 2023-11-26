//
//  GTFSLevel.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation

public extension GTFS {
    /// A [GTFS Level](https://gtfs.org/schedule/reference/#levelstxt). Defines the levels in a station. Can be used with pathways to navigate stations.
    struct Level {
        /// A unique identifer for the level.
        var id: WMATAIdentifier<Self>
        
        /// Numeric index of the level that indicates its relative position.
        ///
        /// For WMATA, these are integers between -3 and 2.
        ///
        ///Ground level should have index 0, with levels above ground indicated by positive indices and levels below ground by negative indices.
        var index: Int
        
        /// Name of the level as seen by the rider inside the building or station.
        var name: String
    }
}
