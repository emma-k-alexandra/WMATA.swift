//
//  BusResponses.swift
//
//
//  Created by Emma K Alexandra on 6/16/19.
//

import Foundation

public struct BusPredictions: Codable {
    public let predictions: [BusPrediction]

    enum CodingKeys: String, CodingKey {
        case predictions = "Predictions"
    }

    public init(predictions: [BusPrediction]) {
        self.predictions = predictions
    }
}

public struct BusPrediction: Codable {
    public let directionNumber: String
    public let directionText: String
    public let minutes: Int
    public let route: Route
    public let tripId: String
    public let vehicleId: String

    enum CodingKeys: String, CodingKey {
        case directionNumber = "DirectionNum"
        case directionText = "DirectionText"
        case minutes = "Minutes"
        case route = "RouteID"
        case tripId = "TripID"
        case vehicleId = "VehicleID"
    }

    public init(
        directionNumber: String,
        directionText: String,
        minutes: Int,
        route: Route,
        tripId: String,
        vehicleId: String
    ) {
        self.directionNumber = directionNumber
        self.directionText = directionText
        self.minutes = minutes
        self.route = route
        self.tripId = tripId
        self.vehicleId = vehicleId
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        directionNumber = try container.decode(String.self, forKey: .directionNumber)
        directionText = try container.decode(String.self, forKey: .directionText)
        minutes = try container.decode(Int.self, forKey: .minutes)
        route = Route(id: try container.decode(String.self, forKey: .route))

        tripId = try container.decode(String.self, forKey: .tripId)
        vehicleId = try container.decode(String.self, forKey: .vehicleId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(directionNumber, forKey: .directionNumber)
        try container.encode(directionText, forKey: .directionText)
        try container.encode(minutes, forKey: .minutes)
        try container.encode(route.description, forKey: .route)
        try container.encode(tripId, forKey: .tripId)
        try container.encode(vehicleId, forKey: .vehicleId)
    }
}

public struct BusPositions: Codable {
    public let busPositions: [BusPosition]

    enum CodingKeys: String, CodingKey {
        case busPositions = "BusPositions"
    }

    public init(busPositions: [BusPosition]) {
        self.busPositions = busPositions
    }
}

public struct BusPosition: Codable {
    public let dateTime: Date
    public let deviation: Double
    public let directionNumber: Int
    public let directionText: String
    public let latitude: Double
    public let longitude: Double
    public let route: Route
    public let tripEndTime: Date
    public let tripHeadsign: String
    public let tripId: String
    public let tripStartTime: Date
    public let vehicleId: String
    public let blockNumber: String

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case deviation = "Deviation"
        case directionNumber = "DirectionNum"
        case directionText = "DirectionText"
        case latitude = "Lat"
        case longitude = "Lon"
        case route = "RouteID"
        case tripEndTime = "TripEndTime"
        case tripHeadsign = "TripHeadsign"
        case tripId = "TripID"
        case tripStartTime = "TripStartTime"
        case vehicleId = "VehicleID"
        case blockNumber = "BlockNumber"
    }

    public init(
        dateTime: Date,
        deviation: Double,
        directionNumber: Int,
        directionText: String,
        latitude: Double,
        longitude: Double,
        route: Route,
        tripEndTime: Date,
        tripHeadsign: String,
        tripId: String,
        tripStartTime: Date,
        vehicleId: String,
        blockNumber: String
    ) {
        self.dateTime = dateTime
        self.deviation = deviation
        self.directionNumber = directionNumber
        self.directionText = directionText
        self.latitude = latitude
        self.longitude = longitude
        self.route = route
        self.tripEndTime = tripEndTime
        self.tripHeadsign = tripHeadsign
        self.tripId = tripId
        self.tripStartTime = tripStartTime
        self.vehicleId = vehicleId
        self.blockNumber = blockNumber
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        dateTime = try (try container.decode(String.self, forKey: .dateTime)).toWMATADate()
        deviation = try container.decode(Double.self, forKey: .deviation)
        directionNumber = try container.decode(Int.self, forKey: .directionNumber)
        directionText = try container.decode(String.self, forKey: .directionText)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        route = Route(id: try container.decode(String.self, forKey: .route))

        tripEndTime = try (try container.decode(String.self, forKey: .tripEndTime)).toWMATADate()
        tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        tripId = try container.decode(String.self, forKey: .tripId)
        tripStartTime = try (try container.decode(String.self, forKey: .tripStartTime)).toWMATADate()
        vehicleId = try container.decode(String.self, forKey: .vehicleId)
        blockNumber = try container.decode(String.self, forKey: .blockNumber)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(dateTime.toWMATAString(), forKey: .dateTime)
        try container.encode(deviation, forKey: .deviation)
        try container.encode(directionNumber, forKey: .directionNumber)
        try container.encode(directionText, forKey: .directionText)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(route.description, forKey: .route)
        try container.encode(tripEndTime.toWMATAString(), forKey: .tripEndTime)
        try container.encode(tripId, forKey: .tripId)
        try container.encode(tripStartTime.toWMATAString(), forKey: .tripStartTime)
        try container.encode(vehicleId, forKey: .vehicleId)
        try container.encode(blockNumber, forKey: .blockNumber)
    }
}

public struct PathDetails: Codable {
    public let routeId: String
    public let name: String
    public let directionZero: PathDirection
    public let directionOne: PathDirection

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteID"
        case name = "Name"
        case directionZero = "Direction0"
        case directionOne = "Direction1"
    }

    public init(
        routeId: String,
        name: String,
        directionZero: PathDirection,
        directionOne: PathDirection
    ) {
        self.routeId = routeId
        self.name = name
        self.directionZero = directionZero
        self.directionOne = directionOne
    }
}

public struct PathDirection: Codable {
    public let tripHeadsign: String
    public let directionText: String
    public let directionNumber: String
    public let shape: [PathStop]
    public let stops: [StopResponse]

    enum CodingKeys: String, CodingKey {
        case tripHeadsign = "TripHeadsign"
        case directionText = "DirectionText"
        case directionNumber = "DirectionNum"
        case shape = "Shape"
        case stops = "Stops"
    }

    public init(
        tripHeadsign: String,
        directionText: String,
        directionNumber: String,
        shape: [PathStop],
        stops: [StopResponse]
    ) {
        self.tripHeadsign = tripHeadsign
        self.directionText = directionText
        self.directionNumber = directionNumber
        self.shape = shape
        self.stops = stops
    }
}

public struct PathStop: Codable {
    public let latitude: Double
    public let longitude: Double
    public let sequenceNumber: Int

    enum CodingKeys: String, CodingKey {
        case latitude = "Lat"
        case longitude = "Lon"
        case sequenceNumber = "SeqNum"
    }

    public init(
        latitude: Double,
        longitude: Double,
        sequenceNumber: Int
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.sequenceNumber = sequenceNumber
    }
}

public struct StopResponse: Codable {
    public let stop: Stop
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let routes: [Route]

    enum CodingKeys: String, CodingKey {
        case stop = "StopID"
        case name = "Name"
        case latitude = "Lon"
        case longitude = "Lat"
        case routes = "Routes"
    }

    public init(
        stop: Stop,
        name: String,
        latitude: Double,
        longitude: Double,
        routes: [Route]
    ) {
        self.stop = stop
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.routes = routes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        stop = Stop(id: try container.decode(String.self, forKey: .stop))
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)

        let routes = try container.decode([String].self, forKey: .routes)

        self.routes = routes.map(Route.init(id:))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(stop.description, forKey: .stop)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(routes, forKey: .routes)
    }
}

public struct RoutesResponse: Codable {
    public let routes: [RouteResponse]

    enum CodingKeys: String, CodingKey {
        case routes = "Routes"
    }

    public init(routes: [RouteResponse]) {
        self.routes = routes
    }
}

public struct RouteResponse: Codable {
    public let route: Route
    public let name: String
    public let lineDescription: String

    enum CodingKeys: String, CodingKey {
        case route = "RouteID"
        case name = "Name"
        case lineDescription = "LineDescription"
    }

    public init(
        route: Route,
        name: String,
        lineDescription: String
    ) {
        self.route = route
        self.name = name
        self.lineDescription = lineDescription
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        route = Route(id: try container.decode(String.self, forKey: .route))
        name = try container.decode(String.self, forKey: .name)
        lineDescription = try container.decode(String.self, forKey: .lineDescription)
    }
}

public struct StopSchedule: Codable {
    public let arrivals: [BusArrival]
    public let stop: StopScheduleResponse

    enum CodingKeys: String, CodingKey {
        case arrivals = "ScheduleArrivals"
        case stop = "Stop"
    }

    public init(
        arrivals: [BusArrival],
        stop: StopScheduleResponse
    ) {
        self.arrivals = arrivals
        self.stop = stop
    }
}

public struct BusArrival: Codable {
    public let scheduleTime: Date
    public let directionNumber: String
    public let startTime: Date
    public let endTime: Date
    public let route: Route
    public let tripDirectionText: String
    public let tripHeadsign: String
    public let tripId: String

    enum CodingKeys: String, CodingKey {
        case scheduleTime = "ScheduleTime"
        case directionNumber = "DirectionNum"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case route = "RouteID"
        case tripDirectionText = "TripDirectionText"
        case tripHeadsign = "TripHeadsign"
        case tripId = "TripID"
    }

    public init(
        scheduleTime: Date,
        directionNumber: String,
        startTime: Date,
        endTime: Date,
        route: Route,
        tripDirectionText: String,
        tripHeadsign: String,
        tripId: String
    ) {
        self.scheduleTime = scheduleTime
        self.directionNumber = directionNumber
        self.startTime = startTime
        self.endTime = endTime
        self.route = route
        self.tripDirectionText = tripDirectionText
        self.tripHeadsign = tripHeadsign
        self.tripId = tripId
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        scheduleTime = try (try container.decode(String.self, forKey: .scheduleTime)).toWMATADate()
        directionNumber = try container.decode(String.self, forKey: .directionNumber)
        startTime = try (try container.decode(String.self, forKey: .startTime)).toWMATADate()
        endTime = try (try container.decode(String.self, forKey: .endTime)).toWMATADate()

        route = Route(id: try container.decode(String.self, forKey: .route))
        tripDirectionText = try container.decode(String.self, forKey: .tripDirectionText)
        tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        tripId = try container.decode(String.self, forKey: .tripId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(scheduleTime.toWMATAString(), forKey: .scheduleTime)
        try container.encode(directionNumber, forKey: .directionNumber)
        try container.encode(startTime.toWMATAString(), forKey: .startTime)
        try container.encode(endTime.toWMATAString(), forKey: .endTime)
        try container.encode(route, forKey: .route)
        try container.encode(tripDirectionText, forKey: .tripDirectionText)
        try container.encode(tripHeadsign, forKey: .tripHeadsign)
        try container.encode(tripId, forKey: .tripId)
    }
}

public struct StopScheduleResponse: Codable {
    public let stop: Stop?
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let routes: [Route]

    enum CodingKeys: String, CodingKey {
        case stop = "StopID"
        case name = "Name"
        case latitude = "Lat"
        case longitude = "Lon"
        case routes = "Routes"
    }

    public init(
        stop: Stop?,
        name: String,
        latitude: Double,
        longitude: Double,
        routes: [Route]
    ) {
        self.stop = stop
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.routes = routes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let stop = try container.decode(String?.self, forKey: .stop)

        if let stop = stop {
            self.stop = Stop(id: stop)

        } else {
            self.stop = nil
        }

        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)

        let routes = try container.decode([String].self, forKey: .routes)

        self.routes = routes.map(Route.init(id:))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(stop?.description, forKey: .stop)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(routes, forKey: .routes)
    }
}

public struct StopsSearchResponse: Codable {
    public let stops: [StopScheduleResponse]

    enum CodingKeys: String, CodingKey {
        case stops = "Stops"
    }

    public init(stops: [StopScheduleResponse]) {
        self.stops = stops
    }
}

public struct BusIncidents: Codable {
    public let incidents: [BusIncident]

    enum CodingKeys: String, CodingKey {
        case incidents = "BusIncidents"
    }

    public init(incidents: [BusIncident]) {
        self.incidents = incidents
    }
}

public struct BusIncident: Codable {
    public let dateUpdated: String
    public let description: String
    public let incidentId: String
    public let incidentType: String
    public let routesAffected: [Route]

    enum CodingKeys: String, CodingKey {
        case dateUpdated = "DateUpdated"
        case description = "Description"
        case incidentId = "IncidentID"
        case incidentType = "IncidentType"
        case routesAffected = "RoutesAffected"
    }

    public init(
        dateUpdated: String,
        description: String,
        incidentId: String,
        incidentType: String,
        routesAffected: [Route]
    ) {
        self.dateUpdated = dateUpdated
        self.description = description
        self.incidentId = incidentId
        self.incidentType = incidentType
        self.routesAffected = routesAffected
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        dateUpdated = try container.decode(String.self, forKey: .dateUpdated)
        description = try container.decode(String.self, forKey: .description)
        incidentId = try container.decode(String.self, forKey: .incidentId)
        incidentType = try container.decode(String.self, forKey: .incidentType)

        let routes = try container.decode([String].self, forKey: .routesAffected)

        routesAffected = routes.map(Route.init(id:))
    }
}

public struct RouteSchedule: Codable {
    public let name: String
    public let directionZero: [RouteInfo]
    public let directionOne: [RouteInfo]

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case directionZero = "Direction0"
        case directionOne = "Direction1"
    }

    public init(
        name: String,
        directionZero: [RouteInfo],
        directionOne: [RouteInfo]
    ) {
        self.name = name
        self.directionZero = directionZero
        self.directionOne = directionOne
    }
}

public struct RouteInfo: Codable {
    public let route: Route
    public let directionNumber: String
    public let tripDirectionText: String
    public let tripHeadsign: String
    public let startTime: Date
    public let endTime: Date
    public let stopTimes: [StopInfo]
    public let tripId: String

    enum CodingKeys: String, CodingKey {
        case route = "RouteID"
        case directionNumber = "DirectionNum"
        case tripDirectionText = "TripDirectionText"
        case tripHeadsign = "TripHeadsign"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case stopTimes = "StopTimes"
        case tripId = "TripID"
    }

    public init(
        route: Route,
        directionNumber: String,
        tripDirectionText: String,
        tripHeadsign: String,
        startTime: Date,
        endTime: Date,
        stopTimes: [StopInfo],
        tripId: String
    ) {
        self.route = route
        self.directionNumber = directionNumber
        self.tripDirectionText = tripDirectionText
        self.tripHeadsign = tripHeadsign
        self.startTime = startTime
        self.endTime = endTime
        self.stopTimes = stopTimes
        self.tripId = tripId
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        route = Route(id: try container.decode(String.self, forKey: .route))
        directionNumber = try container.decode(String.self, forKey: .directionNumber)
        tripDirectionText = try container.decode(String.self, forKey: .tripDirectionText)
        tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        startTime = try (try container.decode(String.self, forKey: .startTime)).toWMATADate()
        endTime = try (try container.decode(String.self, forKey: .endTime)).toWMATADate()
        stopTimes = try container.decode([StopInfo].self, forKey: .stopTimes)
        tripId = try container.decode(String.self, forKey: .tripId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(route, forKey: .route)
        try container.encode(directionNumber, forKey: .directionNumber)
        try container.encode(tripDirectionText, forKey: .tripDirectionText)
        try container.encode(tripHeadsign, forKey: .tripHeadsign)
        try container.encode(startTime.toWMATAString(), forKey: .startTime)
        try container.encode(endTime.toWMATAString(), forKey: .endTime)
        try container.encode(stopTimes, forKey: .stopTimes)
        try container.encode(tripId, forKey: .tripId)
    }
}

public struct StopInfo: Codable {
    public let stop: Stop
    public let stopName: String
    public let stopSequence: Int
    public let time: String

    enum CodingKeys: String, CodingKey {
        case stop = "StopID"
        case stopName = "StopName"
        case stopSequence = "StopSeq"
        case time = "Time"
    }

    public init(
        stop: Stop,
        stopName: String,
        stopSequence: Int,
        time: String
    ) {
        self.stop = stop
        self.stopName = stopName
        self.stopSequence = stopSequence
        self.time = time
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        stop = Stop(id: try container.decode(String.self, forKey: .stop))
        stopName = try container.decode(String.self, forKey: .stopName)
        stopSequence = try container.decode(Int.self, forKey: .stopSequence)
        time = try container.decode(String.self, forKey: .time)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(stop.description, forKey: .stop)
        try container.encode(stopName, forKey: .stopName)
        try container.encode(stopSequence, forKey: .stopSequence)
        try container.encode(time, forKey: .time)
    }
}
