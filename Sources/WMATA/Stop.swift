//
//  Stop.swift
//
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Combine
import Foundation

/// A Metrobus stop
///
/// Values are stop IDs rather than stop names. Metrobus stops are numerous and defining them all explicitly is not feasible. Check the ``Bus/StopsSearch`` endpoint from WMATA to get all avalable stops.
///
/// Stop IDs are the same as you would see on signs at a Metrobus stop.
///
/// ![A sign at a Metrobus stop displaying stop ID 1001037](metrobus-stop)
public typealias Stop = String
