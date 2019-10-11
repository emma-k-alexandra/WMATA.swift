//
//  Stops.swift
//  
//
//  Created by Emma Foster on 10/10/19.
//

import Foundation

public struct Stop {
    public let id: String
}

extension Stop: NeedsStop {
    func nextBuses(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        (self as NeedsStop).nextBuses(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    func schedule(at date: String? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        (self as NeedsStop).schedule(for: self, at: date, withApiKey: apiKey, andSession: session, completion: completion)
    }
}
