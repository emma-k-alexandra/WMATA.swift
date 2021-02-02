//
//  Lines.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// Line codes as defined by WMATA
public enum Line: String, CaseIterable, Codable {
    case RD
    case BL
    case YL
    case OR
    case GR
    case SV
    case YLRP
}

extension Line: NeedsLine {}

public extension Line {
    /// Stations along this Line
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `Stations`
    func stations(key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<Stations, WMATAError>) -> Void) {
        (self as NeedsLine).stations(for: self, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Line {
    /// Stations along this Line
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `Stations`
    func stationsPublisher(key: String, session: URLSession = URLSession.shared) -> AnyPublisher<Stations, WMATAError> {
        (self as NeedsLine).stations(for: self, key: key, session: session)
    }
}

public extension Line {
    /// A human readable and presentable line name
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
