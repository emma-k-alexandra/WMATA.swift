//
//  Routes.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// A WMATA Route ID
public struct Route: Codable {
    /// A WMATA Route ID
    public let id: String

    /// Create a Route ID
    ///
    /// - Parameters:
    ///     - id: A Route ID
    public init(id: String) {
        self.id = id
    }
}

extension Route: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        id = value
    }
}

extension Route: NeedsRoute {}

public extension Route {
    /// Bus positions on this Route including latlong and direction.
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latlong to search at
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: A completion handler
    ///     - result: [BusPositions](x-source-tag://BusPositions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func positions(at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<BusPositions, WMATAError>) -> Void) {
        (self as NeedsRoute).positions(on: self, at: radiusAtCoordinates, key: key, session: session, completion: completion)
    }

    /// Bus incidents along this Route.
    ///
    /// - Parameters:
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: completion handler which return `BusIncidents`
    ///     - result: [BusIncidents](x-source-tag://BusIncidents) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func incidents(key: String, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<BusIncidents, WMATAError>) -> Void) {
        (self as NeedsRoute).incidents(on: self, key: key, session: session, completion: completion)
    }

    /// Ordered latlong points along this Route for a given date.
    ///
    /// - Parameters:
    ///     - date: Day to get details for. Omit for today
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: A completion handler
    ///     - result: [PathDetails](x-source-tag://PathDetails) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func pathDetails(on date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<PathDetails, WMATAError>) -> Void) {
        (self as NeedsRoute).pathDetails(for: self, on: date, key: key, session: session, completion: completion)
    }

    /// Scheduled stops for this Route
    ///
    /// - Parameters:
    ///     - date: Day to get stops for. Omit for today.
    ///     - includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///     - completion: A completion handler
    ///     - result: [RouteSchedule](x-source-tag://RouteSchedule) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func schedule(on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession = URLSession.shared, completion: @escaping (_ result: Result<RouteSchedule, WMATAError>) -> Void) {
        (self as NeedsRoute).schedule(for: self, on: date, includingVariations: includingVariations, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Route {
    /// Bus positions on this Route including latlong and direction.
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latlong to search at
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [BusPositions](x-source-tag://BusPositions)
    func positionsPublisher(at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<BusPositions, WMATAError> {
        (self as NeedsRoute).positionsPublisher(on: self, at: radiusAtCoordinates, key: key, session: session)
    }

    /// Bus incidents along this Route.
    ///
    /// - Parameters:
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [BusIncidents](x-source-tag://BusIncidents)
    func incidentsPublisher(key: String, session: URLSession = URLSession.shared) -> AnyPublisher<BusIncidents, WMATAError> {
        (self as NeedsRoute).incidentsPublisher(on: self, key: key, session: session)
    }

    /// Ordered latlong points along this Route for a given date.
    ///
    /// - Parameters:
    ///     - date: Day to get route. Omit for today.
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [PathDetails](x-source-tag://PathDetails)
    func pathDetailsPublisher(on date: WMATADate? = nil, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<PathDetails, WMATAError> {
        (self as NeedsRoute).pathDetailsPublisher(for: self, on: date, key: key, session: session)
    }

    /// Scheduled stops for this Route
    ///
    /// - Parameters:
    ///     - date: Day to get stops for`. Omit for today.
    ///     - includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    ///     - key: WMATA API Key to use with this request
    ///     - session: Optional. URL Session to make this request with
    ///
    /// - Returns: A Combine Publisher for [RouteSchedule](x-source-tag://RouteSchedule)
    func schedulePublisher(on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession = URLSession.shared) -> AnyPublisher<RouteSchedule, WMATAError> {
        (self as NeedsRoute).schedulePublisher(for: self, on: date, includingVariations: includingVariations, key: key, session: session)
    }
}

extension Route: CustomStringConvertible {
    public var description: String {
        id
    }
}
