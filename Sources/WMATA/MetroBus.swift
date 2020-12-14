//
//  MetroBus.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation
import GTFS

/// MetroBus related methods
public struct MetroBus: Fetcher {
    public let key: String
    public var delegate: WMATADelegate? {
        didSet {
            if let delegate = self.delegate {
                urlSession = generateURLSession(with: delegate)
            }
        }
    }

    private var urlSession: URLSession

    public init(key: String) {
        self.key = key
        urlSession = URLSession.shared
    }

    public init(key: String, delegate: WMATADelegate) {
        self.key = key
        self.delegate = delegate
        urlSession = generateURLSession(with: delegate)
    }
}

// These don't require any Route or Stop IDs
public extension MetroBus {
    /// All bus routes and variants
    func routes() {
        request(
            with: URLRequest(url: BusURL.routes.rawValue, queryItems: [], apiKey: key),
            and: urlSession
        )
    }

    /// All bus routes and variants
    ///
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    func routes(completion: @escaping (Result<RoutesResponse, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: BusURL.routes.rawValue, queryItems: [], apiKey: key),
            andSession: urlSession,
            completion: completion
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    func searchStops(at radiusAtCoordinates: RadiusAtCoordinates?) {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }

        request(
            with: URLRequest(url: BusURL.stops.rawValue, queryItems: queryItems, apiKey: key),
            and: urlSession
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    func searchStops(at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<StopsSearchResponse, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }

        fetch(
            with: URLRequest(url: BusURL.stops.rawValue, queryItems: queryItems, apiKey: key),
            andSession: urlSession,
            completion: completion
        )
    }
}

extension MetroBus: NeedsRoute {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    public func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, with: key, and: urlSession)
    }

    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `BusPositions`
    public func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<BusPositions, WMATAError>) -> Void) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, withApiKey: key, andSession: urlSession, completion: completion)
    }

    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    public func incidents(on route: Route?) {
        (self as NeedsRoute).incidents(on: route, with: key, and: urlSession)
    }

    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - parameter completion: Completion handler which returns `BusIncidents`
    public func incidents(on route: Route?, completion: @escaping (Result<BusIncidents, WMATAError>) -> Void) {
        (self as NeedsRoute).incidents(on: route, withApiKey: key, andSession: urlSession, completion: completion)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    public func pathDetails(for route: Route, on date: WMATADate? = nil) {
        (self as NeedsRoute).pathDetails(for: route, on: date, with: key, and: urlSession)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    /// - parameter completion: Completion handler which returns `PathDetails`
    public func pathDetails(for route: Route, on date: WMATADate? = nil, completion: @escaping (Result<PathDetails, WMATAError>) -> Void) {
        (self as NeedsRoute).pathDetails(for: route, on: date, withApiKey: key, andSession: urlSession, completion: completion)
    }

    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    public func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, withApiKey: key, andSession: urlSession)
    }

    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    public func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, completion: @escaping (Result<RouteSchedule, WMATAError>) -> Void) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, withApiKey: key, andSession: urlSession, completion: completion)
    }
}

extension MetroBus: NeedsStop {
    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    public func nextBuses(for stop: Stop) {
        (self as NeedsStop).nextBuses(for: stop, with: key, and: urlSession)
    }

    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    /// - parameter completion: Completion handler which returns `BusPredictions`
    public func nextBuses(for stop: Stop, completion: @escaping (Result<BusPredictions, WMATAError>) -> Void) {
        (self as NeedsStop).nextBuses(for: stop, withApiKey: key, andSession: urlSession, completion: completion)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    public func schedule(for stop: Stop, at date: WMATADate? = nil) {
        (self as NeedsStop).schedule(for: stop, at: date, with: key, and: urlSession)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    public func schedule(for stop: Stop, at date: WMATADate? = nil, completion: @escaping (Result<StopSchedule, WMATAError>) -> Void) {
        (self as NeedsStop).schedule(for: stop, at: date, withApiKey: key, andSession: urlSession, completion: completion)
    }
}

extension MetroBus: GTFSRTFetcher {}

/// GTFS-RT
public extension MetroBus {
    func alerts(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: GTFSRTBusURL.alerts.rawValue, queryItems: [], apiKey: key),
            andSession: urlSession,
            completion: completion
        )
    }

    func alerts() {
        request(
            with: URLRequest(
                url: GTFSRTBusURL.alerts.rawValue,
                queryItems: [],
                apiKey: key
            ),
            and: urlSession
        )
    }

    func tripUpdates(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(
                url: GTFSRTBusURL.tripUpdates.rawValue,
                queryItems: [],
                apiKey: key
            ),
            andSession: urlSession,
            completion: completion
        )
    }

    func tripUpdates() {
        request(
            with: URLRequest(
                url: GTFSRTBusURL.tripUpdates.rawValue,
                queryItems: [],
                apiKey: key
            ),
            and: urlSession
        )
    }

    func vehiclePositions(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: GTFSRTBusURL.vehiclePositions.rawValue, queryItems: [], apiKey: key),
            andSession: urlSession,
            completion: completion
        )
    }

    func vehiclePositions() {
        request(
            with: URLRequest(
                url: GTFSRTBusURL.vehiclePositions.rawValue,
                queryItems: [],
                apiKey: key
            ),
            and: urlSession
        )
    }
}
