//
//  File.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

/// Line codes as defined by WMATA
public enum Line: String {
    case RD
    case BL
    case YL
    case OR
    case GR
    case SV
}

extension Line: NeedsLine {
    /// Stations along this Line
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `Stations`
    public func stations(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        (self as NeedsLine).stations(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
}
