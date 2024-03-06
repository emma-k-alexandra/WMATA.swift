//
//  GTFSCoordinates.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation

public extension GTFS {
    /// Location with latitude and longitude coordinates
    struct Coordinates: Equatable, Hashable, Codable {
        /// Latitude in degrees, for the DMV this value is positive.
        var latitude: Double
        
        /// Longitude in degrees, For the DMV this value is negative.
        var longitude: Double

        /// Create a new location
        ///
        /// - Parameters:
        ///     - latitude: Latitude of location in degrees, positive for the DMV.
        ///     - longitude: Longitude of location in degrees, negative for the DMV.
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
