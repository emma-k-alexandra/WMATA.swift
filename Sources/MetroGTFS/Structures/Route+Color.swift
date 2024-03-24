//
//  Route=Color.swift
//
//
//  Created by Emma on 3/24/24.
//

import Foundation

/// Convert a hex color string (`FF00FF`) to RGB values between 0 and 1.
internal func parseRGB(fromHex hexString: String) -> (red: Double, green: Double, blue: Double)? {
    guard let hex = Int(hexString, radix: 16) else { return nil }
    
    return (
        red: Double((hex >> 16) & 0xff) / 255,
        green: Double((hex >> 8) & 0xff) / 255,
        blue: Double(hex & 0xff) / 255
    )
}
