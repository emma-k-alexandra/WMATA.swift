//
//  Stops.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation
import Combine

public struct Stop: Codable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}

extension Stop: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.id = value
    }
}

extension Stop: NeedsStop {}

public extension Stop {
    /// Next bus arrival times at this Stop
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `BusPredictions`
    func nextBuses(key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<BusPredictions, WMATAError>) -> Void) {
        (self as NeedsStop).nextBuses(for: self, key: key, session: session, completion: completion)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    /// - Parameter date: `WMATADate`. Omit for today.
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `StopSchedule`
    func schedule(at date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<StopSchedule, WMATAError>) -> Void) {
        (self as NeedsStop).schedule(for: self, at: date, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Stop {
    /// Next bus arrival times at this Stop
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `BusPredictions`
    func nextBusesPublisher(key: String, session: URLSession = URLSession.shared) -> AnyPublisher<BusPredictions, WMATAError> {
        (self as NeedsStop).nextBuses(for: self, key: key, session: session)
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    /// - Parameter date: `WMATADate`. Omit for today.
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `StopSchedule`
    func schedulePublisher(at date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<StopSchedule, WMATAError> {
        (self as NeedsStop).schedule(for: self, at: date, key: key, session: session)
    }
}

extension Stop: CustomStringConvertible {
    public var description: String {
        id
    }
}
