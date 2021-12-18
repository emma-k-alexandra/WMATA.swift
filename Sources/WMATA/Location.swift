//
//  Location.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// A location and radius from that location in meters.
///
/// Used in several location-based endpoints like ``Rail/StationEntrances``.
public struct WMATALocation: Equatable, Hashable {
    /// Radius from location in meters
    public let radius: UInt
    
    /// Latitude and longitude of a location.
    ///
    /// For the DMV area, latitude is positive and longitude is negative.
    public let coordinates: Coordinates

    /// Create a new location and radius
    ///
    /// - Parameters:
    ///     - radius: Radius in meters from the given coordinates
    ///     - coordinates: Latitude and longitude for a location
    public init(radius: UInt, coordinates: Coordinates) {
        self.radius = radius
        self.coordinates = coordinates
    }

    /// Create a new location and radius
    ///
    /// - Parameters:
    ///     - radius: Radius in meters from the given coordinates
    ///     - latitude: Latitude of location in degrees, positive for the DMV.
    ///     - longitude: Longitude of location in degrees, negative for the DMV.
    public init(radius: UInt, latitude: Double, longitude: Double) {
        self.init(
            radius: radius,
            coordinates: .init(latitude: latitude, longitude: longitude)
        )
    }
    
    func queryItems() -> [URLQueryItem] {
        coordinates.queryItems() + [URLQueryItem(name: "Radius", value: String(radius))]
    }
    
    /// Location in latlong
    public struct Coordinates: Equatable, Hashable {
        /// Latitude in degrees, for the DMV this value is positive.
        public let latitude: Double
        
        /// Longitude in degrees, For this DMV this value is negative.
        public let longitude: Double

        /// Create a new location
        ///
        /// - Parameters:
        ///     - latitude: Latitude of location in degrees, positive for the DMV.
        ///     - longitude: Longitude of location in degrees, negative for the DMV.
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
        
        func queryItems() -> [URLQueryItem] {
            [
                URLQueryItem(name: "Lat", value: String(latitude)),
                URLQueryItem(name: "Lon", value: String(longitude))
            ]
        }
    }
}
