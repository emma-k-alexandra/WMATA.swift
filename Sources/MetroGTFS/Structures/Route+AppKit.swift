//
//  Route+AppKit.swift
//  
//
//  Created by Emma on 3/24/24.
//

import Foundation

#if canImport(AppKit)

import AppKit

public extension GTFSRoute {
    /// The color of this route
    var nsColor: NSColor {
        guard let (red, green, blue) = parseRGB(fromHex: self.hexColor) else {
            return NSColor.white /// per GTFS spec
        }
        
        return NSColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// The text color of this route. Has high contrast with ``nsColor``.
    var nsTextColor: NSColor {
        guard let (red, green, blue) = parseRGB(fromHex: self.hexTextColor) else {
            return NSColor.white /// per GTFS spec
        }
        
        return NSColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#endif
