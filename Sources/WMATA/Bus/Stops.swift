//
//  Stops.swift
//  
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation

public struct Stop: Codable {
    public let id: String
    
    public init(id: String) {
        self.id = id
        
    }
    
}

extension Stop: NeedsStop {
    /// Next bus arrival times at this Stop
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `BusPredictions`
    func nextBuses(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        (self as NeedsStop).nextBuses(for: self, withApiKey: apiKey, andSession: session, completion: completion)
        
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    /// - Parameter date: `WMATADate`. Omit for today.
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `StopSchedule`
    func schedule(at date: WMATADate? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        (self as NeedsStop).schedule(for: self, at: date, withApiKey: apiKey, andSession: session, completion: completion)
        
    }
    
}

extension Stop: CustomStringConvertible {
    public var description: String {
        self.id
        
    }
    
}
