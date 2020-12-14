//
//  BusProtocols.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation

protocol NeedsRoute: Fetcher {}

extension NeedsRoute {
    func positions(on routeId: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, with apiKey: String, and session: URLSession) {
        var queryItems = [(String, String)]()

        if let routeId = routeId {
            queryItems.append(("RouteID", routeId.rawValue))
        }

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }

        request(
            with: URLRequest(url: BusURL.positions.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func positions(on routeId: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<BusPositions, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let routeId = routeId {
            queryItems.append(("RouteID", routeId.rawValue))
        }

        if let radiusAtCoordinates = radiusAtCoordinates {
            queryItems.append(contentsOf: radiusAtCoordinates.toQueryItems())
        }

        fetch(
            with: URLRequest(url: BusURL.positions.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func incidents(on route: Route?, with apiKey: String, and session: URLSession) {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("Route", route.rawValue))
        }

        request(
            with: URLRequest(url: BusURL.incidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func incidents(on route: Route?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<BusIncidents, WMATAError>) -> Void) {
        var queryItems = [(String, String)]()

        if let route = route {
            queryItems.append(("Route", route.rawValue))
        }

        fetch(
            with: URLRequest(url: BusURL.incidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func pathDetails(for route: Route, on date: WMATADate? = nil, with apiKey: String, and session: URLSession) {
        var queryItems = [("RouteID", route.rawValue)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        request(
            with: URLRequest(url: BusURL.pathDetails.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func pathDetails(for route: Route, on date: WMATADate? = nil, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<PathDetails, WMATAError>) -> Void) {
        var queryItems = [("RouteID", route.rawValue)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        fetch(
            with: URLRequest(url: BusURL.pathDetails.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, withApiKey apiKey: String, andSession session: URLSession) {
        var queryItems = [("RouteID", route.rawValue)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
        }

        request(
            with: URLRequest(url: BusURL.routeSchedule.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RouteSchedule, WMATAError>) -> Void) {
        var queryItems = [("RouteID", route.rawValue)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        if let includingVariations = includingVariations {
            queryItems.append(("IncludingVariations", String(includingVariations)))
        }

        fetch(
            with: URLRequest(url: BusURL.routeSchedule.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }
}

protocol NeedsStop: Fetcher {}

extension NeedsStop {
    func nextBuses(for stop: Stop, with apiKey: String, and session: URLSession) {
        request(
            with: URLRequest(url: BusURL.nextBuses.rawValue, queryItems: [("StopID", stop.id)], apiKey: apiKey),
            and: session
        )
    }

    func nextBuses(for stop: Stop, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<BusPredictions, WMATAError>) -> Void) {
        fetch(
            with: URLRequest(url: BusURL.nextBuses.rawValue, queryItems: [("StopID", stop.id)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }

    func schedule(for stop: Stop, at date: WMATADate? = nil, with apiKey: String, and session: URLSession) {
        var queryItems = [("StopID", stop.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        request(
            with: URLRequest(url: BusURL.stopSchedule.rawValue, queryItems: queryItems, apiKey: apiKey),
            and: session
        )
    }

    func schedule(for stop: Stop, at date: WMATADate? = nil, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StopSchedule, WMATAError>) -> Void) {
        var queryItems = [("StopID", stop.id)]

        if let date = date {
            queryItems.append(("Date", date.description))
        }

        fetch(
            with: URLRequest(url: BusURL.stopSchedule.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
    }
}
