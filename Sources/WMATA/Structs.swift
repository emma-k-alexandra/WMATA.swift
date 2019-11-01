//
//  Structs.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

public struct RadiusAtCoordinates {
    public let radius: UInt
    public let coordinates: Coordinates
    
    func toQueryItems() -> [(String, String)] {
        return coordinates.toQueryItems() + [
            ("Radius", String(radius))
        ]
        
    }
    
}

public struct Coordinates {
    public let latitude: Double
    public let longitude: Double
    
    func toQueryItems() -> [(String, String)] {
        return [
            ("Lat", String(latitude)),
            ("Lon", String(longitude))
        ]
        
    }
    
}

public struct WMATADate {
    public let year: Int
    public let month: Int
    public let day: Int
}

extension WMATADate: CustomStringConvertible {
    public var description: String {
        String(format: "%04d-%02d-%02d", self.year, self.month, self.day)
    }
    
}
