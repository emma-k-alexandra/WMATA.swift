//
//  MetroBus.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation
import GTFS

/// For accessing MetroBus related APIs
public struct MetroBus: Fetcher {
    /// WMATA API key
    public let key: String
    
    /// Delegate for use with delegate calls
    public var delegate: WMATADelegate? {
        didSet {
            if let delegate = self.delegate {
                session = generateURLSession(with: delegate, sharedContainerIdentifier: sharedContainerIdentifier)
            }
        }
    }

    /// The shared container identifier for use with app extensions. See [URLSessionConfiguration](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/1409450-sharedcontaineridentifier)
    public private(set) var sharedContainerIdentifier: String?

    /// URL session to use for all calls
    private var session: URLSession

    /// Create a new MetroBus instance
    ///
    /// - Parameters:
    ///     - key: Your WMATA API key
    ///     - delegate: The delegate to use for all delegate calls. Optional.
    ///     - sharedContainerIdentifier: Identifier for use with app extensions. Optional.
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
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateRoutesResponse)
    ///
    /// - Note:
    ///     [WMATA Routes Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a)
    func routes() {
        request(
            request: URLRequest(url: BusURL.routes.rawValue, key: key),
            session: session
        )
    }

    /// All bus routes and variants
    ///
    /// - Note:
    ///     [WMATA Routes Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a)
    ///
    /// - Parameters:
    ///     - completion: Completion handler which returns `RoutesResponse`
    ///     - result: [RoutesResponse](x-source-tag://RoutesResponse) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func routes(completion: @escaping (_ result: Result<RoutesResponse, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: BusURL.routes.rawValue, key: key),
            session: session,
            completion: completion
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStopsSearchResponse)
    ///
    /// - Note:
    ///     [WMATA Search Stop Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    func searchStops(at radiusAtCoordinates: RadiusAtCoordinates? = nil) {
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
    /// - Note:
    ///     [WMATA Search Stop Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    ///     - completion: A completion handler
    ///     - result: [StopsSearchResponse](x-source-tag://StopsSearchResponse) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func searchStops(at radiusAtCoordinates: RadiusAtCoordinates? = nil, completion: @escaping (_ result: Result<StopsSearchResponse, WMATAError>) -> Void) {
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
    /// - Note:
    ///     [WMATA Routes Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a)
    ///
    /// - Returns: A Combine Publisher for [RoutesResponse](x-source-tag://RoutesResponse)
    func routesPublisher() -> AnyPublisher<RoutesResponse, WMATAError> {
        publisher(
            request: URLRequest(url: BusURL.routes.rawValue, key: key),
            session: session
        )
    }

    /// Stops nearby the given latitude, longitude and radius. Omit latitude, longitude and radius to receive all stops.
    ///
    /// - Note:
    ///     [WMATA Search Stops Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
    ///
    /// - Parameters:
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    ///
    /// - Returns: A Combine Publisher for [StopsSearchResponse](x-source-tag://StopsSearchResponse)
    func searchStopsPublisher(at radiusAtCoordinates: RadiusAtCoordinates? = nil) -> AnyPublisher<StopsSearchResponse, WMATAError> {
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
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateBusPositions)
    ///
    /// - Note:
    ///     [WMATA Positions Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
    ///
    /// - Parameters:
    ///     - route: Get bus positions along this route. Optional.
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    func positions(on route: Route? = nil, at radiusAtCoordinates: RadiusAtCoordinates? = nil) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, key: key, session: session)
    }

    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - Note:
    ///     [WMATA Positions Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
    ///
    /// - Parameters:
    ///     - route: Get bus positions along this route. Optional.
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    ///     - completion: Completion handler which returns `BusPositions`
    ///     - result: [BusPositions](x-source-tag://BusPositions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func positions(on route: Route? = nil, at radiusAtCoordinates: RadiusAtCoordinates? = nil, completion: @escaping (_ result: Result<BusPositions, WMATAError>) -> Void) {
        (self as NeedsRoute).positions(on: route, at: radiusAtCoordinates, key: key, session: session, completion: completion)
    }

    /// Bus incidents along a given route.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateBusIncidents)
    ///
    /// - Note:
    ///     [WMATA Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75)
    ///
    /// - Parameters:
    ///     - route: Route to search for incidents along. Omit route to receive all incidents.
    func incidents(on route: Route? = nil) {
        (self as NeedsRoute).incidents(on: route, key: key, session: session)
    }

    /// Bus incidents along a given route.
    ///
    /// - Note:
    ///     [WMATA Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75)
    ///
    /// - Parameters:
    ///     - route: Route to search for incidents along. Omit route to receive all incidents.
    ///     - completion: A completion handler
    ///     - result: [BusIncidents](x-source-tag://BusIncidents) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func incidents(on route: Route? = nil, completion: @escaping (_ result: Result<BusIncidents, WMATAError>) -> Void) {
        (self as NeedsRoute).incidents(on: route, key: key, session: session, completion: completion)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegatePathDetails)
    ///
    /// - Note:
    ///     [WMATA Path Details Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
    ///
    /// - Parameters:
    ///     - route: Route to get path details for
    ///     - date: Day  for which to receive path information. Omit for today.
    func pathDetails(for route: Route, on date: WMATADate? = nil) {
        (self as NeedsRoute).pathDetails(for: route, on: date, key: key, session: session)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - Note:
    ///     [WMATA Path Details Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
    ///
    /// - Parameters:
    ///     - route: Route to get path details for
    ///     - date: Day  for which to receive path information. Omit for today.
    ///     - completion: A completion handler
    ///     - result: [PathDetails](x-source-tag://PathDetails) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func pathDetails(for route: Route, on date: WMATADate? = nil, completion: @escaping (_ result: Result<PathDetails, WMATAError>) -> Void) {
        (self as NeedsRoute).pathDetails(for: route, on: date, key: key, session: session, completion: completion)
    }

    /// Scheduled stops for this Route
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateRouteSchedule)
    ///
    /// - Note:
    ///     [WMATA Route Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
    ///
    /// - Parameters:
    ///     - route: Route to get stops for
    ///     - date: Day for which to receive scheduled stops. Omit for today.
    ///     - includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    func routeSchedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, key: key, session: session)
    }

    /// Scheduled stops for this Route
    ///
    /// - Note:
    ///     [WMATA Route Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
    ///
    /// - Parameters:
    ///     - route: Route to get stops for
    ///     - date: Day for which to receive scheduled stops. Omit for today.
    ///     - includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    ///     - completion: A completion handler
    ///     - result: [RouteSchedule](x-source-tag://RouteSchedule) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func routeSchedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, completion: @escaping (_ result: Result<RouteSchedule, WMATAError>) -> Void) {
        (self as NeedsRoute).schedule(for: route, on: date, includingVariations: includingVariations, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroBus {
    /// Bus positions including latlong and direction. Omit routeId, latitude, longitude and radius to receive all bus positions.
    ///
    /// - Note:
    ///     [WMATA Positions Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
    ///
    /// - Parameters:
    ///     - route: Get bus positions along this route. Optional.
    ///     - radiusAtCoordinates: Radius at latitude and longitude to search at. Optional.
    ///
    /// - Returns: A Combine Publisher for [BusPositions](x-source-tag://BusPositions)
    func positionsPublisher(on route: Route? = nil, at radiusAtCoordinates: RadiusAtCoordinates? = nil) -> AnyPublisher<BusPositions, WMATAError> {
        (self as NeedsRoute).positionsPublisher(on: route, at: radiusAtCoordinates, key: key, session: session)
    }

    /// Bus incidents along a given route.
    ///
    /// - Note:
    ///     [WMATA Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75)
    ///
    /// - Parameters:
    ///     - route: Route to search for incidents along. Omit route to receive all incidents.
    ///
    /// - Returns: A Combine Publisher for [BusIncidents](x-source-tag://BusIncidents)
    func incidentsPublisher(on route: Route? = nil) -> AnyPublisher<BusIncidents, WMATAError> {
        (self as NeedsRoute).incidentsPublisher(on: route, key: key, session: session)
    }

    /// Ordered latlong points along this Route for a given date. Omit date to get path information for today.
    ///
    /// - Note:
    ///     [WMATA Path Details Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
    ///
    /// - Parameters:
    ///     - route: Route to get path details for
    ///     - date: Day  for which to receive path information. Omit for today.
    ///
    /// - Returns: A Combine Publisher for [PathDetails](x-source-tag://PathDetails)
    func pathDetailsPublisher(for route: Route, on date: WMATADate? = nil) -> AnyPublisher<PathDetails, WMATAError> {
        (self as NeedsRoute).pathDetailsPublisher(for: route, on: date, key: key, session: session)
    }

    /// Scheduled stops for this Route
    ///
    /// - Note:
    ///     [WMATA Route Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
    ///
    /// - Parameters:
    ///     - route: Route to get stops for
    ///     - date: Day for which to receive scheduled stops. Omit for today.
    ///     - includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    ///
    /// - Returns: A Combine Publisher for [RouteSchedule](x-source-tag://RouteSchedule)
    func routeSchedulePublisher(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false) -> AnyPublisher<RouteSchedule, WMATAError> {
        (self as NeedsRoute).schedulePublisher(for: route, on: date, includingVariations: includingVariations, key: key, session: session)
    }
}

extension MetroBus: NeedsStop {}

public extension MetroBus {
    /// Next bus arrival times at this Stop
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateBusPredictions)
    ///
    /// - Note:
    ///     [WMATA Next Buses Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
    ///
    /// - Parameters:
    ///     - stop: Stop to get next arrival times for
    func nextBuses(for stop: Stop) {
        (self as NeedsStop).nextBuses(for: stop, key: key, session: session)
    }

    /// Next bus arrival times at this Stop
    ///
    /// - Note:
    ///     [WMATA Next Buses Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
    ///
    /// - Parameters:
    ///     - stop: Stop to get next arrival times for
    ///     - completion: A completion handler
    ///     - result: [BusPredictions](x-source-tag://BusPredictions) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func nextBuses(for stop: Stop, completion: @escaping (_ result: Result<BusPredictions, WMATAError>) -> Void) {
        (self as NeedsStop).nextBuses(for: stop, key: key, session: session, completion: completion)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateStopSchedule)
    ///
    /// - Note:
    ///     [WMATA Stop Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
    ///
    /// - Parameters:
    ///     - stop: Stop to get schedule for
    ///     - date: Day for which to receive schedule for. Omit for today.
    func stopSchedule(for stop: Stop, at date: WMATADate? = nil) {
        (self as NeedsStop).schedule(for: stop, at: date, key: key, session: session)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - Note:
    ///     [WMATA Stop Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
    ///
    /// - Parameters:
    ///     - stop: Stop to get schedule for
    ///     - date: Day for which to receive schedule for. Omit for today.
    ///     - completion: A completion handler.
    ///     - result: [StopSchedule](x-source-tag://StopSchedule) if successful, otherwise [WMATAError](x-source-tag://WMATAError)
    func stopSchedule(for stop: Stop, at date: WMATADate? = nil, completion: @escaping (_ result: Result<StopSchedule, WMATAError>) -> Void) {
        (self as NeedsStop).schedule(for: stop, at: date, key: key, session: session, completion: completion)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension MetroBus {
    /// Next bus arrival times at this Stop
    ///
    /// - Note:
    ///     [WMATA Next Buses Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
    ///
    /// - Parameters:
    ///     - stop: Stop to get next arrival times for
    ///
    /// - Returns: A Combine Publisher for [BusPredictions](x-source-tag://BusPrediction)
    func nextBusesPublisher(for stop: Stop) -> AnyPublisher<BusPredictions, WMATAError> {
        (self as NeedsStop).nextBusesPublisher(for: stop, key: key, session: session)
    }

    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - Note:
    ///     [WMATA Stop Schedule Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
    ///
    /// - Parameters:
    ///     - stop: Stop to get schedule for
    ///     - date: Day for which to receive schedule for. Omit for today.
    ///
    /// - Returns: A Combine Publisher for [StopSchedule](x-source-tag://StopSchedule)
    func stopSchedulePublisher(for stop: Stop, at date: WMATADate? = nil) -> AnyPublisher<StopSchedule, WMATAError> {
        (self as NeedsStop).schedulePublisher(for: stop, at: date, key: key, session: session)
    }
}

extension MetroBus: GTFSRTFetcher {}

/// GTFS-RT
public extension MetroBus {
    /// GTFS RT 2.0 service alerts feed for WMATA bus.
    ///
    /// - Note:
    ///     [Google Alerts Documentation](https://developers.google.com/transit/gtfs-realtime/guides/service-alerts)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: `TransitRealtime_FeedMessage` if successful, otherwise `WMATAError`
    func alerts(completion: @escaping (_ result: Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTBusURL.alerts.rawValue, key: key),
            session: session,
            completion: completion
        )
    }

    /// GTFS RT 2.0 service alerts feed for WMATA bus.
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateAlerts)
    ///
    /// - Note:
    ///     [Google Alerts Documentation](https://developers.google.com/transit/gtfs-realtime/guides/service-alerts)
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
    ///
    /// - Note:
    ///     [Google Trip Updates Documentation](https://developers.google.com/transit/gtfs-realtime/guides/trip-updates)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: `TransitRealtime_FeedMessage` if successful, otherwise `WMATAError`
    func tripUpdates(completion: @escaping (_ result: Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
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
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateTripUpdates)
    ///
    /// - Note:
    ///     [Google Trip Updates Documentation](https://developers.google.com/transit/gtfs-realtime/guides/trip-updates)
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
    ///
    /// - Note:
    ///     [Google Vehicle Positions Documentation](https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions)
    ///
    /// - Parameters:
    ///     - completion: A completion handler
    ///     - result: `TransitRealtime_FeedMessage` if successful, otherwise `WMATAError`
    func vehiclePositions(completion: @escaping (_ result: Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: GTFSRTBusURL.vehiclePositions.rawValue, key: key),
            session: session,
            completion: completion
        )
    }

    /// GTFS RT 2.0 vehicle positions feed for WMATA
    ///
    /// For use with a [WMATADelegate](x-source-tag://WMATADelegate)
    ///
    /// [Corresponding WMATADelegate Handler](x-source-tag://DelegateVehiclePositions)
    ///
    /// - Note:
    ///     [Google Vehicle Positions Documentation](https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions)
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
    ///
    /// - Note:
    ///     [Google Alerts Documentation](https://developers.google.com/transit/gtfs-realtime/guides/service-alerts)
    ///
    /// - Returns: A Combine Publisher for `TransitRealtime_FeedMessage`
    func alertsPublisher() -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        publisher(
            request: URLRequest(
                url: GTFSRTBusURL.alerts.rawValue,
                key: key
            ),
            session: session
        )
    }

    /// GTFS RT 2.0 trip updates feed for WMATA
    ///
    /// - Note:
    ///     [Google Trip Updates Documentation](https://developers.google.com/transit/gtfs-realtime/guides/trip-updates)
    ///
    /// - Returns: A Combine Publisher for `TransitRealtime_FeedMessage`
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
    ///
    /// - Note:
    ///     [Google Vehicle Positions Documentation](https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions)
    ///
    /// - Returns: A Combine Publisher for`TransitRealtime_FeedMessage`
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
