//
//  BusResponses.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//

public struct BusPredictions: Codable {
    public let predictions: BusPrediction
    
    enum CodingKeys: String, CodingKey {
        case predictions = "Predictions"
    }
}

public struct BusPrediction: Codable {
    public let directionNumber: String
    public let directionText: String
    public let minutes: Int
    public let routeId: String
    public let tripId: String
    public let vehicleId: String
    
    enum CodingKeys: String, CodingKey {
        case directionNumber = "DirectionNum"
        case directionText = "DirectionText"
        case minutes = "Minutes"
        case routeId = "RouteID"
        case tripId = "TripID"
        case vehicleId = "VehicleID"
    }
}

public struct BusPositions: Codable {
    public let busPositions: BusPosition
    
    enum CodingKeys: String, CodingKey {
        case busPositions = "BusPositions"
    }
}

public struct BusPosition: Codable {
    public let dateTime: String
    public let deviation: Int
    public let directionNumber: String
    public let directionText: String
    public let latitude: Double
    public let longitude: Double
    public let routeId: String
    public let tripEndTime: String
    public let tripHeadsign: String
    public let tripId: String
    public let tripStartTime: String
    public let vehicleId: String
    
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
    public let stopId: String
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let routes: [String]
    
    enum CodingKeys: String, CodingKey {
        case stopId = "StopID"
        case name = "Name"
        case latitude = "Lon"
        case longitude = "Lat"
        case routes = "Routes"
    }
}

public struct RoutesResponse: Codable {
    public let routes: [RouteResponse]
    
    enum CodingKeys: String, CodingKey {
        case routes = "Routes"
    }
}

public struct RouteResponse: Codable {
    public let routeId: String
    public let name: String
    public let lineDescription: String
    
    enum CodingKeys: String, CodingKey {
        case routeId = "RouteID"
        case name = "Name"
        case lineDescription = "LineDescription"
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
    public let scheduleTime: String
    public let directionNumber: Int
    public let startTime: String
    public let endTime: String
    public let routeId: String
    public let tripDirectionText: String
    public let tripHeadsign: String
    public let tripId: String
    
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

public struct StopScheduleResponse: Codable {
    public let stopId: String?
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let routes: [String]
    
    enum CodingKeys: String, CodingKey {
        case stopId = "StopID"
        case name = "Name"
        case latitude = "Lat"
        case longitude = "Lon"
        case routes = "Routes"
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
    public let routesAffected: [String]
    
    enum CodingKeys: String, CodingKey {
        case dateUpdated = "DateUpdated"
        case description = "Description"
        case incidentId = "IncidentID"
        case incidentType = "IncidentType"
        case routesAffected = "RoutesAffected"
    }
}
