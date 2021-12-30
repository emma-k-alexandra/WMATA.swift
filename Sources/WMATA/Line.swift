//
//  Lines.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// A MetroRail line
///
/// Represents the various, colorful rail lines within the MetroRail system.
/// ![MetroRail system map](metrorail-map)
public enum Line: String, CaseIterable, Codable, Hashable, Equatable, RawRepresentable {
    /// Red Line
    case red = "RD"
    
    /// Blue Line
    case blue = "BL"
    
    /// Yellow Line
    case yellow = "YL"
    
    /// Orange Line
    case orange = "OR"
    
    /// Green Line
    case green = "GR"
    
    /// Silver Line
    case silver = "SV"
    
    /// Yellow Line Rush Plus (not currently used)
    ///
    /// This line is only used in the ``Rail/StandardRoutes`` endpoint, and is not in normal service.
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
    
    /// If this line is currently used. ``YLRP`` is not current.
    ///
    /// True for all other lines.
    var current: Bool {
        Line.allCurrent.contains(self)
    }
    
    /// All of the current Lines. ``YLRP`` is not included.
    static var allCurrent: [Self] {
        [.red, .blue, .yellow, .orange, .green, .silver]
    }
}

extension Line: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case standard = "LineCode"
    }
    
    func queryItem(name: URLQueryItemName = .standard) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: rawValue)
    }
}
