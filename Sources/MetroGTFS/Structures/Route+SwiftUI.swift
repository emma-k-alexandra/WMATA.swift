//
//  Route+SwiftUI.swift
//
//
//  Created by Emma on 3/24/24.
//

import Foundation

#if canImport(SwiftUI)

import SwiftUI

public extension GTFSRoute {
    /// The color of this route
    var color: Color {
        guard let (red, green, blue) = parseRGB(fromHex: self.hexColor) else {
            return Color.white /// per GTFS spec
        }
        
        return Color(red: red, green: green, blue: blue)
    }
    
    /// The text color of this route. Has high contrast with ``textColor``.
    var textColor: Color {
        guard let (red, green, blue) = parseRGB(fromHex: self.hexTextColor) else {
            return Color.black /// per GTFS spec
        }
        
        return Color(red: red, green: green, blue: blue)
    }
}

#endif
