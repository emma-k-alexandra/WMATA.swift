//
//  BusProtocols.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation
import Combine

protocol NeedsRoute: Fetcher {}

extension NeedsRoute {
    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession) {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("RouteID", route.id))
        }

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        request(
            request: URLRequest(url: BusURL.positions.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession, completion: @escaping (Result<BusPositions, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("RouteID", route.id))
        }

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        fetch(
            request: URLRequest(url: BusURL.positions.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }

    func incidents(on route: Route?, key: String, session: URLSession) {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("Route", route.id))
        }

        request(
            request: URLRequest(url: BusURL.incidents.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func incidents(on route: Route?, key: String, session: URLSession, completion: @escaping (Result<BusIncidents, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("Route", route.id))
        }

        fetch(
            request: URLRequest(url: BusURL.incidents.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }

    func pathDetails(for route: Route, on date: WMATADate? = nil, key: String, session: URLSession) {
        var queryItems = [("RouteID", route.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        request(
            request: URLRequest(url: BusURL.pathDetails.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func pathDetails(for route: Route, on date: WMATADate? = nil, key: String, session: URLSession, completion: @escaping (Result<PathDetails, WMATAError>) -> Void) {
        var queryItems = [("RouteID", route.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        fetch(
            request: URLRequest(url: BusURL.pathDetails.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }

    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession) {
        var queryItems = [("RouteID", route.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
        }

        request(
            request: URLRequest(url: BusURL.routeSchedule.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession, completion: @escaping (Result<RouteSchedule, WMATAError>) -> Void) {
        var queryItems = [("RouteID", route.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
        }

        fetch(
            request: URLRequest(url: BusURL.routeSchedule.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension NeedsRoute {
    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, key: String, session: URLSession) -> AnyPublisher<BusPositions, WMATAError> {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("RouteID", route.id))
        }

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.queryItems)
        }

        return publisher(
            request: URLRequest(url: BusURL.positions.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
    
    func incidents(on route: Route?, key: String, session: URLSession) -> AnyPublisher<BusIncidents, WMATAError> {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("Route", route.id))
        }

        return publisher(
            request: URLRequest(url: BusURL.incidents.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
    
    func pathDetails(for route: Route, on date: WMATADate? = nil, key: String, session: URLSession) -> AnyPublisher<PathDetails, WMATAError> {
        var queryItems = [("RouteID", route.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        return publisher(
            request: URLRequest(url: BusURL.pathDetails.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
    
    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, key: String, session: URLSession) -> AnyPublisher<RouteSchedule, WMATAError> {
        var queryItems = [("RouteID", route.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
        }

        return publisher(
            request: URLRequest(url: BusURL.routeSchedule.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
}

protocol NeedsStop: Fetcher {}

extension NeedsStop {
    func nextBuses(for stop: Stop, key: String, session: URLSession) {
        request(
            request: URLRequest(url: BusURL.nextBuses.rawValue, key: key, queryItems: [("StopID", stop.id)]),
            session: session
        )
    }

    func nextBuses(for stop: Stop, key: String, session: URLSession, completion: @escaping (Result<BusPredictions, WMATAError>) -> Void) {
        fetch(
            request: URLRequest(url: BusURL.nextBuses.rawValue, key: key, queryItems: [("StopID", stop.id)]),
            session: session,
            completion: completion
        )
    }

    func schedule(for stop: Stop, at date: WMATADate? = nil, key: String, session: URLSession) {
        var queryItems = [("StopID", stop.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        request(
            request: URLRequest(url: BusURL.stopSchedule.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }

    func schedule(for stop: Stop, at date: WMATADate? = nil, key: String, session: URLSession, completion: @escaping (Result<StopSchedule, WMATAError>) -> Void) {
        var queryItems = [("StopID", stop.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        fetch(
            request: URLRequest(url: BusURL.stopSchedule.rawValue, key: key, queryItems: queryItems),
            session: session,
            completion: completion
        )
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension NeedsStop {
    func nextBuses(for stop: Stop, key: String, session: URLSession) -> AnyPublisher<BusPredictions, WMATAError> {
        publisher(
            request: URLRequest(url: BusURL.nextBuses.rawValue, key: key, queryItems: [("StopID", stop.id)]),
            session: session
        )
    }
    
    func schedule(for stop: Stop, at date: WMATADate? = nil, key: String, session: URLSession) -> AnyPublisher<StopSchedule, WMATAError> {
        var queryItems = [("StopID", stop.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        return publisher(
            request: URLRequest(url: BusURL.stopSchedule.rawValue, key: key, queryItems: queryItems),
            session: session
        )
    }
}
