//
//  Stops.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Combine
import Foundation

/// A WMATA Stop ID
public struct Stop: Codable {
    /// A WMATA Stop ID
    public let id: String

    /// Create a Stop ID
    ///
    /// - Parameters:
    ///     - id: A Stop ID
    public init(id: String) {
        self.id = id
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(id)
    }
}

extension Stop: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        id = value
    }
}

extension Stop: NeedsStop {}

public extension Stop {
    /// Next bus arrival times at this Stop
    ///
    /// - Note:
    ///     [WMATA Next Buses Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
    ///
    /// - Parameters:
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: A completion handler
    ///     - result: [BusPredictions](x-source-tag://BusPredictions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func nextBuses(key: String, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<BusPredictions, WMATAError>) -> Void) {
        (self as NeedsStop).nextBuses(for: self, key: key, session: session, completion: completion)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - Note:
    ///     [WMATA Stop Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
    ///
    /// - Parameters:
    ///     - date: Day to get arrivals. Omit for today.
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: A completion handler
    ///     - result: [StopSchedule](x-source-tag://StopSchedule) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func schedule(at date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<StopSchedule, WMATAError>) -> Void) {
        (self as NeedsStop).schedule(for: self, at: date, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Stop {
    /// Next bus arrival times at this Stop
    ///
    /// - Note:
    ///     [WMATA Next Buses Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
    ///
    /// - Parameters:
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [BusPredictions](x-source-tag://BusPredictions)
    func nextBusesPublisher(key: String, session: URLSession = URLSession.shared) -> AnyPublisher<BusPredictions, WMATAError> {
        (self as NeedsStop).nextBusesPublisher(for: self, key: key, session: session)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - Note:
    ///     [WMATA Stop Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
    ///
    /// - Parameters:
    ///     - date: Day to get scheduled arrivals. Omit for today.
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [StopSchedule](x-source-tag://StopSchedule)
    func schedulePublisher(at date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<StopSchedule, WMATAError> {
        (self as NeedsStop).schedulePublisher(for: self, at: date, key: key, session: session)
    }
}

extension Stop: CustomStringConvertible {
    public var description: String {
        id
    }
}
