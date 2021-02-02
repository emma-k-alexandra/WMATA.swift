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

    var queryItems: [(String, String)] {
        coordinates.queryItems + [
            ("Radius", String(radius)),
        ]
    }
}

public struct Coordinates {
    public let latitude: Double
    public let longitude: Double

    var queryItems: [(String, String)] {
        [
            ("Lat", String(latitude)),
            ("Lon", String(longitude)),
        ]
    }
}
