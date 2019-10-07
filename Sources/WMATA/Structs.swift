//
//  Structs.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

public struct RadiusAtLatLong {
    let radius: UInt
    let latitude: Double
    let longitude: Double
    
    func toQueryItems() -> [(String, String)] {
        return [
            ("Lat", String(latitude)),
            ("Lon", String(longitude)),
            ("Radius", String(radius))
        ]
        
    }
    
}
