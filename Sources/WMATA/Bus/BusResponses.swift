//
//  BusResponses.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//

struct BusPredictions: Codable {
    let predictions: BusPrediction
    
    enum CodingKeys: String, CodingKey {
        case predictions = "Predictions"
    }
}

struct BusPrediction: Codable {
    let directionNumber: String
    let directionText: String
    let minutes: Int
    let routeId: String
    let tripId: String
    let vehicleId: String
    
    enum CodingKeys: String, CodingKey {
        case directionNumber = "DirectionNum"
        case directionText = "DirectionText"
        case minutes = "Minutes"
        case routeId = "RouteID"
        case tripId = "TripID"
        case vehicleId = "VehicleID"
    }
}

struct BusPositions: Codable {
    let busPositions: BusPosition
    
    enum CodingKeys: String, CodingKey {
        case busPositions = "BusPositions"
    }
}

struct BusPosition: Codable {
    let dateTime: String
    let deviation: Int
    let directionNumber: String
    let directionText: String
    let latitude: Double
    let longitude: Double
    let routeId: String
    let tripEndTime: String
    let tripHeadsign: String
    let tripId: String
    let tripStartTime: String
    let vehicleId: String
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case deviation = "Deivation"
        case directionNumber = "DirectionNum"
        case directionText = "DirectionText"
        case latitude = "Lat"
        case longitude = "Lon"
        case routeId = "RouteID"
        case tripEndTime = "TripEndTime"
        case tripHeadsign = "TripHeadsign"
        case tripId = "TripID"
        case tripStartTime = "TripStartTime"
        case vehicleId = "VehicleID"
    }
}

struct PathDetails: Codable {
    let routeId: String
    let name: String
    let directionZero: PathDirection
    let directionOne: PathDirection
    
    enum CodingKeys: String, CodingKey {
        case routeId = "RouteID"
        case name = "Name"
        case directionZero = "Direction0"
        case directionOne = "Direction1"
    }
}

struct PathDirection: Codable {
    let tripHeadsign: String
    let directionText: String
    let directionNumber: String
    let shape: [PathStop]
    let stops: [StopResponse]
    
    enum CodingKeys: String, CodingKey {
        case tripHeadsign = "TripHeadsign"
        case directionText = "DirectionText"
        case directionNumber = "DirectionNum"
        case shape = "Shape"
        case stops = "Stops"
    }
}

struct PathStop: Codable {
    let latitude: Double
    let longitude: Double
    let sequenceNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Lat"
        case longitude = "Lon"
        case sequenceNumber = "SeqNum"
    }
}

struct StopResponse: Codable {
    let stopId: String
    let name: String
    let latitude: Double
    let longitude: Double
    let routes: [String]
    
    enum CodingKeys: String, CodingKey {
        case stopId = "StopID"
        case name = "Name"
        case latitude = "Lon"
        case longitude = "Lat"
        case routes = "Routes"
    }
}

struct RoutesResponse: Codable {
    let routes: [RouteResponse]
    
    enum CodingKeys: String, CodingKey {
        case routes = "Routes"
    }
}

struct RouteResponse: Codable {
    let routeId: String
    let name: String
    let lineDescription: String
    
    enum CodingKeys: String, CodingKey {
        case routeId = "RouteID"
        case name = "Name"
        case lineDescription = "LineDescription"
    }
}

struct StopSchedule: Codable {
    let arrivals: [BusArrival]
    let stop: StopScheduleResponse
    
    enum CodingKeys: String, CodingKey {
        case arrivals = "ScheduleArrivals"
        case stop = "Stop"
    }
}

struct BusArrival: Codable {
    let scheduleTime: String
    let directionNumber: Int
    let startTime: String
    let endTime: String
    let routeId: String
    let tripDirectionText: String
    let tripHeadsign: String
    let tripId: String
    
    enum CodingKeys: String, CodingKey {
        case scheduleTime = "ScheduleTime"
        case directionNumber = "DirectionNum"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case routeId = "RouteID"
        case tripDirectionText = "TripDirectionText"
        case tripHeadsign = "TripHeadsign"
        case tripId = "TripID"
    }
}

struct StopScheduleResponse: Codable {
    let stopId: String?
    let name: String
    let latitude: Double
    let longitude: Double
    let routes: [String]
    
    enum CodingKeys: String, CodingKey {
        case stopId = "StopID"
        case name = "Name"
        case latitude = "Lat"
        case longitude = "Lon"
        case routes = "Routes"
    }
}

struct StopsSearchResponse: Codable {
    let stops: [StopScheduleResponse]
    
    enum CodingKeys: String, CodingKey {
        case stops = "Stops"
    }
}

struct BusIncidents: Codable {
    let incidents: [BusIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "BusIncidents"
    }
}

struct BusIncident: Codable {
    let dateUpdated: String
    let description: String
    let incidentId: String
    let incidentType: String
    let routesAffected: [String]
    
    enum CodingKeys: String, CodingKey {
        case dateUpdated = "DateUpdated"
        case description = "Description"
        case incidentId = "IncidentID"
        case incidentType = "IncidentType"
        case routesAffected = "RoutesAffected"
    }
}
