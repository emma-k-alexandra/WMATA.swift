//
//  Routes.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation
import Combine

public struct Route: Codable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}

extension Route: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.id = value
    }
}

extension Route: NeedsRoute {}

public extension Route {
    /// Bus positions on this Route including latlong and direction.
    ///
    /// - Parameter radiusAtCoordinates: Radius at latlong to search at
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `BusPositions`
    func positions(at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<BusPositions, WMATAError>) -> Void) {
        (self as NeedsRoute).positions(on: self, at: radiusAtCoordinates, key: key, session: session, completion: completion)
    }

    /// Bus incidents along this Route.
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which return `BusIncidents`
    func incidents(key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<BusIncidents, WMATAError>) -> Void) {
        (self as NeedsRoute).incidents(on: self, key: key, session: session, completion: completion)
    }

    /// Ordered latlong points along this Route for a given date.
    /// - Parameter date: `WMATADate`. nil for today.
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `PathDetails`
    func pathDetails(on date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<PathDetails, WMATAError>) -> Void) {
        (self as NeedsRoute).pathDetails(for: self, on: date, key: key, session: session, completion: completion)
    }

    /// Scheduled stops for this Route
    /// - Parameter date: `WMATADate`. Omit for today.
    /// - Parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `RoutesResponse`
    func schedule(on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession = URLSession.shared, completion: @escaping (Result<RouteSchedule, WMATAError>) -> Void) {
        (self as NeedsRoute).schedule(for: self, on: date, includingVariations: includingVariations, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Route {
    /// Bus positions on this Route including latlong and direction.
    ///
    /// - Parameter radiusAtCoordinates: Radius at latlong to search at
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `BusPositions`
    func positionsPublisher(at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<BusPositions, WMATAError> {
        (self as NeedsRoute).positions(on: self, at: radiusAtCoordinates, key: key, session: session)
    }
    
    /// Bus incidents along this Route.
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `BusIncidents`
    func incidentsPublisher(key: String, session: URLSession = URLSession.shared) -> AnyPublisher<BusIncidents, WMATAError> {
        (self as NeedsRoute).incidents(on: self, key: key, session: session)
    }
    
    /// Ordered latlong points along this Route for a given date.
    /// - Parameter date: `WMATADate`. nil for today.
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `PathDetails`
    func pathDetailsPublisher(on date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<PathDetails, WMATAError> {
        (self as NeedsRoute).pathDetails(for: self, on: date, key: key, session: session)
    }
    
    /// Scheduled stops for this Route
    /// - Parameter date: `WMATADate`. Omit for today.
    /// - Parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - Parameter key: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - returns: A Combine Publisher for `RoutesResponse`
    func schedulePublisher(on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<RouteSchedule, WMATAError> {
        (self as NeedsRoute).schedule(for: self, on: date, includingVariations: includingVariations, key: key, session: session)
    }
}

extension Route: CustomStringConvertible {
    public var description: String {
        id
    }
}
