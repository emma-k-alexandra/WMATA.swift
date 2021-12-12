//
//  Route.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// A MetroBus route
///
/// MetroBus routes are the numbers visible at the top left of the front of any MetroBus. Values are route IDs rather than route names. You can fetch all MetroBus routes with ``Bus/Routes``.
///
/// ![A MetroBus displaying the route E4](metrobus-e4-route)
public typealias Route = String
