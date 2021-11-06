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
    /// Red line
    case RD
    
    /// Blue line
    case BL
    
    /// Yellow line
    case YL
    
    /// Orange line
    case OR
    
    /// Green line
    case GR
    
    /// Silver line
    case SV
    
    /// Yellow Line Rush Plus (not current).
    /// This line is only used in the `Standard Routes` endpoint, and is not in normal service.
    case YLRP
}

extension Line: NeedsLine {}

public extension Line {
    /// Stations along this Line
    ///
    /// - Note:
    ///     [WMATA Stations Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
    ///
    /// - Parameters:
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: A completion handler
    ///     - result: [Stations](x-source-tag://Stations) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func stations(key: APIKey, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<Stations, WMATAError>) -> Void) {
        (self as NeedsLine).stations(for: self, key: key, session: session, completion: completion)
    }
}

public extension Line {
    /// Stations along this Line
    ///
    /// - Note:
    ///     [WMATA Stations Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
    ///
    /// - Parameters:
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [Stations](x-source-tag://Stations)
    func stationsPublisher(key: APIKey, session: URLSession = URLSession.shared) -> AnyPublisher<Stations, WMATAError> {
        (self as NeedsLine).stationsPublisher(for: self, key: key, session: session)
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
    
    /// If this line is current. `.YLRP` is not current. True for all other Lines.
    var current: Bool {
        switch self {
        case .RD, .BL, .YL, .OR, .GR, .SV:
            return true
        case .YLRP:
            return false
        }
    }
    
    /// All of the current Lines. `.YLRP` is not included.
    static var allCurrent: [Self] {
        [.RD, .BL, .YL, .OR, .GR, .SV]
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
