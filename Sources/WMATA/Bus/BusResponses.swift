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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.directionNumber = try container.decode(String.self, forKey: .directionNumber)
        self.directionText = try container.decode(String.self, forKey: .directionText)
        self.minutes = try container.decode(Int.self, forKey: .minutes)
        
        guard let route = Route(rawValue: try container.decode(String.self, forKey: .route)) else {
            throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")
            
        }
        
        self.route = route
        
        self.tripId = try container.decode(String.self, forKey: .tripId)
        self.vehicleId = try container.decode(String.self, forKey: .vehicleId)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
     
        try container.encode(self.directionNumber, forKey: .directionNumber)
        try container.encode(self.directionText, forKey: .directionText)
        try container.encode(self.minutes, forKey: .minutes)
        try container.encode(self.route.description, forKey: .route)
        try container.encode(self.tripId, forKey: .tripId)
        try container.encode(self.vehicleId, forKey: .vehicleId)
        
    }
    
}

public struct BusPositions: Codable {
    public let busPositions: [BusPosition]
    
    enum CodingKeys: String, CodingKey {
        case busPositions = "BusPositions"
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dateTime = try (try container.decode(String.self, forKey: .dateTime)).toWMATADate()
        self.deviation = try container.decode(Double.self, forKey: .deviation)
        self.directionNumber = try container.decode(Int.self, forKey: .directionNumber)
        self.directionText = try container.decode(String.self, forKey: .directionText)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        
        guard let route = Route(rawValue: try container.decode(String.self, forKey: .route)) else {
            throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")

        }
        
        self.route = route
        
        self.tripEndTime = try (try container.decode(String.self, forKey: .tripEndTime)).toWMATADate()
        self.tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        self.tripStartTime = try (try container.decode(String.self, forKey: .tripStartTime)).toWMATADate()
        self.vehicleId = try container.decode(String.self, forKey: .vehicleId)
        self.blockNumber = try container.decode(String.self, forKey: .blockNumber)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.dateTime.toWMATAString(), forKey: .dateTime)
        try container.encode(self.deviation, forKey: .deviation)
        try container.encode(self.directionNumber, forKey: .directionNumber)
        try container.encode(self.directionText, forKey: .directionText)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.route.description, forKey: .route)
        try container.encode(self.tripEndTime.toWMATAString(), forKey: .tripEndTime)
        try container.encode(self.tripId, forKey: .tripId)
        try container.encode(self.tripStartTime.toWMATAString(), forKey: .tripStartTime)
        try container.encode(self.vehicleId, forKey: .vehicleId)
        try container.encode(self.blockNumber, forKey: .blockNumber)
        
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
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.stop = Stop(id: try container.decode(String.self, forKey: .stop))
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        
        let routes = try container.decode([String].self, forKey: .routes)
        
        self.routes = try routes.map({ (routeString) -> Route in
            guard let route = Route(rawValue: routeString) else {
                throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")
                
            }
            
            return route
            
        })
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.stop.description, forKey: .stop)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.routes, forKey: .routes)
        
    }
    
}

public struct RoutesResponse: Codable {
    public let routes: [RouteResponse]
    
    enum CodingKeys: String, CodingKey {
        case routes = "Routes"
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let routeCode = try container.decode(String.self, forKey: .route)
        
        guard let route = Route(rawValue: routeCode) else {
            throw WMATAError(statusCode: 0, message: "Route \(routeCode) provided by API was not valid")
            
        }
        
        self.route = route
        self.name = try container.decode(String.self, forKey: .name)
        self.lineDescription = try container.decode(String.self, forKey: .lineDescription)
        
    }
    
}

public struct StopSchedule: Codable {
    public let arrivals: [BusArrival]
    public let stop: StopScheduleResponse
    
    enum CodingKeys: String, CodingKey {
        case arrivals = "ScheduleArrivals"
        case stop = "Stop"
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.scheduleTime = try (try container.decode(String.self, forKey: .scheduleTime)).toWMATADate()
        self.directionNumber = try container.decode(String.self, forKey: .directionNumber)
        self.startTime = try (try container.decode(String.self, forKey: .startTime)).toWMATADate()
        self.endTime = try (try container.decode(String.self, forKey: .endTime)).toWMATADate()
        
        guard let route = Route(rawValue: try container.decode(String.self, forKey: .route)) else {
            throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")
            
        }
        
        self.route = route
        self.tripDirectionText = try container.decode(String.self, forKey: .tripDirectionText)
        self.tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.scheduleTime.toWMATAString(), forKey: .scheduleTime)
        try container.encode(self.directionNumber, forKey: .directionNumber)
        try container.encode(self.startTime.toWMATAString(), forKey: .startTime)
        try container.encode(self.endTime.toWMATAString(), forKey: .endTime)
        try container.encode(self.route, forKey: .route)
        try container.encode(self.tripDirectionText, forKey: .tripDirectionText)
        try container.encode(self.tripHeadsign, forKey: .tripHeadsign)
        try container.encode(self.tripId, forKey: .tripId)
        
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let stop = try container.decode(String?.self, forKey: .stop)
        
        if let stop = stop {
            self.stop = Stop(id: stop)
            
        } else {
            self.stop = nil
            
        }
        
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        
        let routes = try container.decode([String].self, forKey: .routes)
        
        self.routes = try routes.map({ (routeString) -> Route in
            guard let route = Route(rawValue: routeString) else {
                throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")
                
            }
            
            return route
            
        })
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.stop?.description, forKey: .stop)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.routes, forKey: .routes)
        
    }
    
}

public struct StopsSearchResponse: Codable {
    public let stops: [StopScheduleResponse]
    
    enum CodingKeys: String, CodingKey {
        case stops = "Stops"
    }
    
}

public struct BusIncidents: Codable {
    public let incidents: [BusIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "BusIncidents"
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dateUpdated = try container.decode(String.self, forKey: .dateUpdated)
        self.description = try container.decode(String.self, forKey: .description)
        self.incidentId = try container.decode(String.self, forKey: .incidentId)
        self.incidentType = try container.decode(String.self, forKey: .incidentType)
        
        let routes = try container.decode([String].self, forKey: .routesAffected)
        
        self.routesAffected = try routes.map({ (routeString) -> Route in
            guard let route = Route(rawValue: routeString) else {
                throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")
                
            }
            
            return route
            
        })
        
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let routeCode = try container.decode(String.self, forKey: .route)
        
        guard let route = Route(rawValue: routeCode) else {
            throw WMATAError(statusCode: 0, message: "Route \(routeCode) provided by API was not valid")
            
        }
        
        self.route = route
        self.directionNumber = try container.decode(String.self, forKey: .directionNumber)
        self.tripDirectionText = try container.decode(String.self, forKey: .tripDirectionText)
        self.tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        self.startTime = try (try container.decode(String.self, forKey: .startTime)).toWMATADate()
        self.endTime = try (try container.decode(String.self, forKey: .endTime)).toWMATADate()
        self.stopTimes = try container.decode([StopInfo].self, forKey: .stopTimes)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.route, forKey: .route)
        try container.encode(self.directionNumber, forKey: .directionNumber)
        try container.encode(self.tripDirectionText, forKey: .tripDirectionText)
        try container.encode(self.tripHeadsign, forKey: .tripHeadsign)
        try container.encode(self.startTime.toWMATAString(), forKey: .startTime)
        try container.encode(self.endTime.toWMATAString(), forKey: .endTime)
        try container.encode(self.stopTimes, forKey: .stopTimes)
        try container.encode(self.tripId, forKey: .tripId)
        
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.stop = Stop(id: try container.decode(String.self, forKey: .stop))
        self.stopName = try container.decode(String.self, forKey: .stopName)
        self.stopSequence = try container.decode(Int.self, forKey: .stopSequence)
        self.time = try container.decode(String.self, forKey: .time)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.stop.description, forKey: .stop)
        try container.encode(self.stopName, forKey: .stopName)
        try container.encode(self.stopSequence, forKey: .stopSequence)
        try container.encode(self.time, forKey: .time)
        
    }
    
}
