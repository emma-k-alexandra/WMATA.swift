//
//  MetroBus.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation
import GTFS

/// MetroBus related methods
public struct MetroBus: Fetcher {
    public let key: String
    public private(set) var delegate: WMATADelegate? {
        didSet {
            if let delegate = self.delegate {
                session = generateURLSession(with: delegate, sharedContainerIdentifier: sharedContainerIdentifier)
            }
        }
    }

    public private(set) var sharedContainerIdentifier: String?

    private var session: URLSession

    public init(key: String, delegate: WMATADelegate? = nil, sharedContainerIdentifier: String? = nil) {
        self.key = key

        self.sharedContainerIdentifier = sharedContainerIdentifier

        if let delegate = delegate {
            self.delegate = delegate
            session = generateURLSession(with: delegate, sharedContainerIdentifier: sharedContainerIdentifier)

        } else {
            self.delegate = nil
            session = URLSession.shared
        }
    }
}

// These don't require any Route or Stop IDs
public extension MetroBus {
    /// All bus routes and variants
    /// For use with a `WMATADelegate`
    func routes() {
        request(
            request: URLRequest(url: BusURL.routes.rawValue, key: key),
            session: session
        )
    }

    /// All bus routes and variants
    ///
    /// - Parameter completion: Completion handler which returns `RoutesResponse`
    func routes(completion: @escaping (Result<RoutesResponse, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: BusURL.routes.rawValue, key: key),
            session: session,
            completion: completion
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    /// For use with a `WMATADelegate`
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    func searchStops(at radiusAtCoordinates: RadiusAtCoordinates?) {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        request(
            request: URLRequest(url: BusURL.stops.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    func searchStops(at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<StopsSearchResponse, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        fetch(
            request: URLRequest(url: BusURL.stops.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroBus {
    /// All bus routes and variants
    ///
    /// - returns: A Combine Publisher for `RoutesResponse`
    func routesPublisher() -> AnyPublisher<RoutesResponse, WMATAError> {
        publisher(
            request: URLRequest(url: BusURL.routes.rawValue, key: key),
            session: session
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `StopsSearchResponse`
    func searchStopsPublisher(at radiusAtCoordinates: RadiusAtCoordinates?) -> AnyPublisher<StopsSearchResponse, WMATAError> {
        var queryItems = [(String, String)]()

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        return publisher(
            request: URLRequest(url: BusURL.stops.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
}

extension MetroBus: NeedsRoute {}

public extension MetroBus {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    /// For use with a `WMATADelegate`
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, key: key, session: session)
    }

    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - parameter completion: Completion handler which returns `BusPositions`
    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, completion: @escaping (Result<BusPositions, WMATAError>) -> Void) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, key: key, session: session, completion: completion)
    }

    /// Bus incidents along a given route.
    /// For use with a `WMATADelegate`
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    func incidents(on route: Route?) {
        (self as NeedsRoute).incidents(on: route, key: key, session: session)
    }

    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - parameter completion: Completion handler which returns `BusIncidents`
    func incidents(on route: Route?, completion: @escaping (Result<BusIncidents, WMATAError>) -> Void) {
        (self as NeedsRoute).incidents(on: route, key: key, session: session, completion: completion)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    /// For use with a `WMATADelegate`
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    func pathDetails(for route: Route, on date: WMATADate? = nil) {
        (self as NeedsRoute).pathDetails(for: route, on: date, key: key, session: session)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    /// - parameter completion: Completion handler which returns `PathDetails`
    func pathDetails(for route: Route, on date: WMATADate? = nil, completion: @escaping (Result<PathDetails, WMATAError>) -> Void) {
        (self as NeedsRoute).pathDetails(for: route, on: date, key: key, session: session, completion: completion)
    }

    /// Scheduled stops for this Route
    /// For use with a `WMATADelegate`
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    func routeSchedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, key: key, session: session)
    }

    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - parameter completion: Completion handler which returns `RoutesResponse`
    func routeSchedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, completion: @escaping (Result<RouteSchedule, WMATAError>) -> Void) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroBus {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - parameter route: Get bus positions along this route
    /// - parameter radiusAtCoordinates: Radius at latitude and longitude to search at
    /// - returns: A Combine Publisher for`BusPositions`
    func positionsPublisher(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?) -> AnyPublisher<BusPositions, WMATAError> {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, key: key, session: session)
    }

    /// Bus incidents along a given route.
    ///
    /// - parameter route: Route to search for incidents along. Omit route to receive all incidents.
    /// - returns: A Combine Publisher for`BusIncidents`
    func incidentsPublisher(on route: Route?) -> AnyPublisher<BusIncidents, WMATAError> {
        (self as NeedsRoute).incidents(on: route, key: key, session: session)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - parameter route: `Route` to get path details for
    /// - parameter date: `WMATADate`  for which to receive path information. Omit for today.
    /// - returns: A Combine Publisher for`PathDetails`
    func pathDetailsPublisher(for route: Route, on date: WMATADate? = nil) -> AnyPublisher<PathDetails, WMATAError> {
        (self as NeedsRoute).pathDetails(for: route, on: date, key: key, session: session)
    }

    /// Scheduled stops for this Route
    ///
    /// - parameter route: `Route` to get stops for
    /// - parameter date: `WMATADate` for which to receive scheduled stops. nil for today.
    /// - parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - returns: A Combine Publisher for`RouteSchedule`
    func routeSchedulePublisher(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false) -> AnyPublisher<RouteSchedule, WMATAError> {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, key: key, session: session)
    }
}

extension MetroBus: NeedsStop {}

public extension MetroBus {
    /// Next bus arrival times at this Stop
    /// For use with a `WMATADelegate`
    ///
    /// - parameter stop: Stop to get next arrival times for
    func nextBuses(for stop: Stop) {
        (self as NeedsStop).nextBuses(for: stop, key: key, session: session)
    }

    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    /// - parameter completion: Completion handler which returns `BusPredictions`
    func nextBuses(for stop: Stop, completion: @escaping (Result<BusPredictions, WMATAError>) -> Void) {
        (self as NeedsStop).nextBuses(for: stop, key: key, session: session, completion: completion)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    /// For use with a `WMATADelegate`
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    func stopSchedule(for stop: Stop, at date: WMATADate? = nil) {
        (self as NeedsStop).schedule(for: stop, at: date, key: key, session: session)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    func stopSchedule(for stop: Stop, at date: WMATADate? = nil, completion: @escaping (Result<StopSchedule, WMATAError>) -> Void) {
        (self as NeedsStop).schedule(for: stop, at: date, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroBus {
    /// Next bus arrival times at this Stop
    ///
    /// - parameter stop: Stop to get next arrival times for
    /// - returns: A Combine Publisher for `BusPredictions`
    func nextBusesPublisher(for stop: Stop) -> AnyPublisher<BusPredictions, WMATAError> {
        (self as NeedsStop).nextBuses(for: stop, key: key, session: session)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter stop: Stop to get schedule for
    /// - parameter date: `WMATADate` for which to receive schedule for. Omit for today.
    /// - returns: A Combine Publisher for `StopSchedule`
    func stopSchedulePublisher(for stop: Stop, at date: WMATADate? = nil) -> AnyPublisher<StopSchedule, WMATAError> {
        (self as NeedsStop).schedule(for: stop, at: date, key: key, session: session)
    }
}

extension MetroBus: GTFSRTFetcher {}

/// GTFS-RT
public extension MetroBus {
    /// GTFS RT 2.0 service alerts feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
    ///
    /// - parameter completion: Completion handler which returns `TransitRealtime_FeedMessage`
    func alerts(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTBusURL.alerts.rawValue, key: key),
            session: session,
            completion: completion
        )
    }

    /// GTFS RT 2.0 service alerts feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
    /// For use with a `WMATADelegate`
    func alerts() {
        request(
            request: URLRequest(
                url: GTFSRTBusURL.alerts.rawValue,
                key: key
            ),
            session: session
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
    ///
    /// - parameter completion: Completion handler which returns `TransitRealtime_FeedMessage`
    func tripUpdates(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(
                url: GTFSRTBusURL.tripUpdates.rawValue,
                key: key
            ),
            session: session,
            completion: completion
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
    /// For use with a `WMATADelegate`
    func tripUpdates() {
        request(
            request: URLRequest(
                url: GTFSRTBusURL.tripUpdates.rawValue,
                key: key
            ),
            session: session
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
    ///
    /// - parameter completion: Completion handler which returns `TransitRealtime_FeedMessage`
    func vehiclePositions(completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTBusURL.vehiclePositions.rawValue, key: key),
            session: session,
            completion: completion
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
    /// For use with a `WMATADelegate`
    func vehiclePositions() {
        request(
            request: URLRequest(
                url: GTFSRTBusURL.vehiclePositions.rawValue,
                key: key
            ),
            session: session
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroBus {
    /// GTFS RT 2.0 service alerts feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
    ///
    /// - returns: A Combine Publisher for `TransitRealtime_FeedMessage`
    func alertsPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(
                url: GTFSRTBusURL.alerts.rawValue,
                key: key
            ),
            session: session
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
    ///
    /// - returns: A Combine Publisher for `TransitRealtime_FeedMessage`
    func tripUpdatesPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(
                url: GTFSRTBusURL.tripUpdates.rawValue,
                key: key
            ),
            session: session
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA bus.
    /// See https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
    ///
    /// - returns: A Combine Publisher for`TransitRealtime_FeedMessage`
    func vehiclePositionsPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(
                url: GTFSRTBusURL.vehiclePositions.rawValue,
                key: key
            ),
            session: session
        )
    }
}
