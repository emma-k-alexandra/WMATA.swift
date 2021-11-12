//
//  Lines.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// A WMATA train line
public enum Line: String, CaseIterable, Codable {
    case red = "RD"
    case blue = "BL"
    case yellow = "YL"
    case orange = "OR"
    case green = "GR"
    case silver = "SV"
    
    /// Yellow Line Rush Plus (not current).
    /// This line is only used in the `Standard Routes` endpoint, and is not in normal service.
    case yellowLineRushPlus = "YLRP"
}

public extension Line {
    /// A human readable and presentable line name
    var name: String {
        switch self {
        case .red:
            return "Red"

        case .blue:
            return "Blue"

        case .yellow:
            return "Yellow"

        case .orange:
            return "Orange"

        case .green:
            return "Green"

        case .silver:
            return "Silver"
            
        case .yellowLineRushPlus:
            return "Yellow Line Rush Plus"
        }
    }
    
    /// If this line is current. `.YLRP` is not current. True for all other Lines.
    var current: Bool {
        switch self {
        case .red, .blue, .yellow, .orange, .green, .silver:
            return true
        case .yellowLineRushPlus:
            return false
        }
    }
    
    /// All of the current Lines. `.YLRP` is not included.
    static var allCurrent: [Self] {
        [.red, .blue, .yellow, .orange, .green, .silver]
    }
}
