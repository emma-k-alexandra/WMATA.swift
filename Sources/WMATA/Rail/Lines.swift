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
    public func stations(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        (self as NeedsLine).stations(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
}
