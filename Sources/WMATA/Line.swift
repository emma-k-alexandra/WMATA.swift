//
//  Lines.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// A Metrorail line
///
/// Represents the various, colorful rail lines within the Metrorail system.
/// ![Metrorail system map](metrorail-map)
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
        }
    }
    
    /// Deprecated. All Lines are current. You do not need to check for currency.
    @available(*, deprecated, message: "All lines are now current. You may simply remove all calls to this property.")
    var current: Bool {
        true
    }
    
    /// Deprecated. Use `allCases` instead.
    @available(*, deprecated, renamed: "allCases", message: "All lines are now current.")
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
