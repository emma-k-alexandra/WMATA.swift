//
//  File.swift
//  
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// URLs of WMATA endpoints relating to MetroBus
enum BusURL: String {
    case routes = "https://api.wmata.com/Bus.svc/json/jRoutes"
    case stops = "https://api.wmata.com/Bus.svc/json/jStops"
    case incidents = "https://api.wmata.com/Incidents.svc/json/BusIncidents"
    case positions = "https://api.wmata.com/Bus.svc/json/jBusPositions"
    case pathDetails = "https://api.wmata.com/Bus.svc/json/jRouteDetails"
    case routeSchedule = "https://api.wmata.com/Bus.svc/json/jRouteSchedule"
    case nextBuses = "https://api.wmata.com/NextBusService.svc/json/jPredictions"
    case stopSchedule = "https://api.wmata.com/Bus.svc/json/jStopSchedule"
}
