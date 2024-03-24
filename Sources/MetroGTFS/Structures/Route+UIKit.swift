//
//  Route+UIKit.swift
//
//
//  Created by Emma on 3/24/24.
//

import Foundation

#if canImport(UIKit)

import UIKit

public extension GTFSRoute {
    
    /// The color of this route
    var uiColor: UIColor {
        guard let (red, green, blue) = parseRGB(fromHex: self.hexColor) else {
            return UIColor.white /// per GTFS spec
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// The text color of this route. Has high contrast with ``uiColor``.
    var uiTextColor: UIColor {
        guard let (red, green, blue) = parseRGB(fromHex: self.hexTextColor) else {
            return UIColor.black /// per GTFS spec
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#endif
