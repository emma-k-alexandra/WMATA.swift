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

    func toQueryItems() -> [(String, String)] {
        return coordinates.toQueryItems() + [
            ("Radius", String(radius)),
        ]
    }
}

public struct Coordinates {
    public let latitude: Double
    public let longitude: Double

    func toQueryItems() -> [(String, String)] {
        return [
            ("Lat", String(latitude)),
            ("Lon", String(longitude)),
        ]
    }
}
