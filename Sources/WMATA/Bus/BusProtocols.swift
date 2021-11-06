//
//  BusProtocols.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Combine
import Foundation

protocol NeedsRoute: Fetcher {}

extension NeedsRoute {
    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Bus.Positions(
                key: key,
                route: route,
                radiusAtCoordinates: radiusAtCoordinates
            ),
            session: session
        )
    }

    func positions(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, key: APIKey, session: URLSession, completion: @escaping (Result<BusPositions, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Bus.Positions(
                key: key,
                route: route,
                radiusAtCoordinates: radiusAtCoordinates
            ),
            session: session,
            completion: completion
        )
    }

    func incidents(on route: Route?, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Bus.Incidents(key: key, route: route),
            session: session
        )
    }

    func incidents(on route: Route?, key: APIKey, session: URLSession, completion: @escaping (Result<BusIncidents, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Bus.Incidents(key: key, route: route),
            session: session,
            completion: completion
        )
    }

    func pathDetails(for route: Route, on date: WMATADate? = nil, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Bus.PathDetails(
                key: key,
                route: route,
                date: date
            ),
            session: session
        )
    }

    func pathDetails(for route: Route, on date: WMATADate? = nil, key: APIKey, session: URLSession, completion: @escaping (Result<PathDetails, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Bus.PathDetails(
                key: key,
                route: route,
                date: date
            ),
            session: session,
            completion: completion
        )
    }

    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Bus.RouteSchedule(
                key: key,
                route: route,
                date: date,
                includingVariations: includingVariations
            ),
            session: session
        )
    }

    func schedule(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, key: APIKey, session: URLSession, completion: @escaping (Result<RouteSchedule, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Bus.RouteSchedule(
                key: key,
                route: route,
                date: date,
                includingVariations: includingVariations
            ),
            session: session,
            completion: completion
        )
    }
}

extension NeedsRoute {
    func positionsPublisher(on route: Route?, at radiusAtCoordinates: RadiusAtCoordinates?, key: APIKey, session: URLSession) -> AnyPublisher<BusPositions, WMATAError> {
        publisher(
            endpoint: API.Bus.Positions(key: key, route: route, radiusAtCoordinates: radiusAtCoordinates),
            session: session
        )
    }

    func incidentsPublisher(on route: Route?, key: APIKey, session: URLSession) -> AnyPublisher<BusIncidents, WMATAError> {
        publisher(
            endpoint: API.Bus.Incidents(key: key, route: route),
            session: session
        )
    }

    func pathDetailsPublisher(for route: Route, on date: WMATADate? = nil, key: APIKey, session: URLSession) -> AnyPublisher<PathDetails, WMATAError> {
        publisher(
            endpoint: API.Bus.PathDetails(
                key: key,
                route: route,
                date: date
            ),
            session: session
        )
    }

    func schedulePublisher(for route: Route, on date: WMATADate? = nil, includingVariations: Bool? = false, key: APIKey, session: URLSession) -> AnyPublisher<RouteSchedule, WMATAError> {
        publisher(
            endpoint: API.Bus.RouteSchedule(
                key: key,
                route: route,
                date: date,
                includingVariations: includingVariations
            ),
            session: session
        )
    }
}

protocol NeedsStop: Fetcher {}

extension NeedsStop {
    func nextBuses(for stop: Stop, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Bus.NextBuses(key: key, stop: stop),
            session: session
        )
    }

    func nextBuses(for stop: Stop, key: APIKey, session: URLSession, completion: @escaping (Result<BusPredictions, WMATAError>) -> Void) {
        fetch(
            endpoint: API.Bus.NextBuses(key: key, stop: stop),
            session: session,
            completion: completion
        )
    }

    func schedule(for stop: Stop, at date: WMATADate? = nil, key: APIKey, session: URLSession) {
        request(
            endpoint: API.Bus.StopSchedule(
                key: key,
                stop: stop,
                date: date
            ),
            session: session
        )
    }

    func schedule(for stop: Stop, at date: WMATADate? = nil, key: APIKey, session: URLSession, completion: @escaping (Result<StopSchedule, WMATAError>) -> Void) {
       fetch(
            endpoint: API.Bus.StopSchedule(
                key: key,
                stop: stop,
                date: date
            ),
            session: session,
            completion: completion
        )
    }
}

extension NeedsStop {
    func nextBusesPublisher(for stop: Stop, key: APIKey, session: URLSession) -> AnyPublisher<BusPredictions, WMATAError> {
        publisher(
            endpoint: API.Bus.NextBuses(key: key, stop: stop),
            session: session
        )
    }

    func schedulePublisher(for stop: Stop, at date: WMATADate? = nil, key: APIKey, session: URLSession) -> AnyPublisher<StopSchedule, WMATAError> {
        publisher(
            endpoint: API.Bus.StopSchedule(
                key: key,
                stop: stop,
                date: date
            ),
            session: session
        )
    }
}
