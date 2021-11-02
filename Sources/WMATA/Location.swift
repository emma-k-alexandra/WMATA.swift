//
//  Location.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// For defining a location and radius from that location
public struct RadiusAtCoordinates {
    /// Radius from location in meters
    public let radius: UInt
    
    /// Location in latlong
    public let coordinates: Coordinates

    /// Create a new location and radius
    ///
    /// - Parameters:
    ///     - radius: Radius in meters from the given coordinates
    ///     - coordinates: Coordinates of location
    public init(radius: UInt, coordinates: Coordinates) {
        self.radius = radius
        self.coordinates = coordinates
    }

    /// Create a new location and radius
    ///
    /// - Parameters:
    ///     - radius: Radius in meters from the given coordinates
    ///     - latitude: Latitude of location
    ///     - longitude: Longitude of location
    public init(radius: UInt, latitude: Double, longitude: Double) {
        self.init(radius: radius, coordinates: Coordinates(latitude: latitude, longitude: longitude))
    }
    
    func queryItems() -> [URLQueryItem] {
        coordinates.queryItems() + [URLQueryItem(name: "Radius", value: String(radius))]
    }
}

/// Location in latlong
public struct Coordinates {
    /// Latitude in degrees, positive
    public let latitude: Double
    
    /// Longitude in degrees, negative
    public let longitude: Double

    /// Create a new location
    ///
    /// - Parameters:
    ///     - latitude: Latitude of location in degrees, positive
    ///     - longitude: Longitude of location in degrees, negative
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
