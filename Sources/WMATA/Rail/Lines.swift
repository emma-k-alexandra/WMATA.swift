//
//  Lines.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// Line codes as defined by WMATA
public enum Line: String, Codable {
    case RD
    case BL
    case YL
    case OR
    case GR
    case SV
    case YLRP
}

extension Line: NeedsLine {
    /// Stations along this Line
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `Stations`
    public func stations(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<Stations, WMATAError>) -> Void) {
        (self as NeedsLine).stations(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
}

public extension Line {
    var name: String {
        switch self {
        case .RD:
            return "Red"

        case .BL:
            return "Blue"

        case .YL:
            return "Yellow"

        case .OR:
            return "Orange"

        case .GR:
            return "Green"

        case .SV:
            return "Silver"

        case .YLRP:
            return "Yellow Rush Plus"
        }
    }
}

extension Line: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
