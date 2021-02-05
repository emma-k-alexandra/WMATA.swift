//
//  Location.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

public struct RadiusAtCoordinates {
    public let radius: UInt
    public let coordinates: Coordinates

    public init(radius: UInt, coordinates: Coordinates) {
        self.radius = radius
        self.coordinates = coordinates
    }

    public init(radius: UInt, latitude: Double, longitude: Double) {
        self.init(radius: radius, coordinates: Coordinates(latitude: latitude, longitude: longitude))
    }

    var queryItems: [(String, String)] {
        coordinates.queryItems + [("Radius", String(radius))]
    }
}

public struct Coordinates {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var queryItems: [(String, String)] {
        [("Lat", String(latitude)), ("Lon", String(longitude))]
    }
}
