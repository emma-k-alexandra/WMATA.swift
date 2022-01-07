//
//  Route.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// A Metrobus route
/// ![A Metrobus displaying the route E4](metrobus-e4-route)
///
/// Metrobus routes are the numbers visible at the top left of the front of any Metrobus. Values are route IDs rather than route names. You can fetch all Metrobus routes with ``Bus/Routes``.
///
/// Example IDs: `10A` or `10Av1` or `79*1`.
///
/// Some routes have _variations_ that are slight modifications to a route. The last two examples above are for route variations. Some endpoints can accept routes with variations and others cannot. Individual endpoints indicate what kinds of routes they can accept in their documentation.
public typealias Route = String

// TODO: Implement base route or route without variation function for either internal or user use.
