//
//  BusResponses.swift
//  
//
//  Created by Emma K Alexandra on 6/16/19.
//

public struct BusPredictions: Decodable {
    public let predictions: [BusPrediction]
    
    enum CodingKeys: String, CodingKey {
        case predictions = "Predictions"
    }
}

public struct BusPrediction: Decodable {
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
    
}

public struct BusPositions: Decodable {
    public let busPositions: [BusPosition]
    
    enum CodingKeys: String, CodingKey {
        case busPositions = "BusPositions"
    }
}

public struct BusPosition: Decodable {
    public let dateTime: String
    public let deviation: Double
    public let directionNumber: Int
    public let directionText: String
    public let latitude: Double
    public let longitude: Double
    public let route: Route
    public let tripEndTime: String
    public let tripHeadsign: String
    public let tripId: String
    public let tripStartTime: String
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
        print(1)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(2)
        
        self.dateTime = try container.decode(String.self, forKey: .dateTime)
        self.deviation = try container.decode(Double.self, forKey: .deviation)
        self.directionNumber = try container.decode(Int.self, forKey: .directionNumber)
        self.directionText = try container.decode(String.self, forKey: .directionText)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        
        guard let route = Route(rawValue: try container.decode(String.self, forKey: .route)) else {
            throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")

        }
        
        self.route = route
        
        self.tripEndTime = try container.decode(String.self, forKey: .tripEndTime)
        self.tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        self.tripStartTime = try container.decode(String.self, forKey: .tripStartTime)
        self.vehicleId = try container.decode(String.self, forKey: .vehicleId)
        self.blockNumber = try container.decode(String.self, forKey: .blockNumber)
        
    }
    
}

public struct PathDetails: Decodable {
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

public struct PathDirection: Decodable {
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

public struct PathStop: Decodable {
    public let latitude: Double
    public let longitude: Double
    public let sequenceNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Lat"
        case longitude = "Lon"
        case sequenceNumber = "SeqNum"
    }
}

public struct StopResponse: Decodable {
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
    
}

public struct RoutesResponse: Decodable {
    public let routes: [RouteResponse]
    
    enum CodingKeys: String, CodingKey {
        case routes = "Routes"
    }
}

public struct RouteResponse: Decodable {
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

public struct StopSchedule: Decodable {
    public let arrivals: [BusArrival]
    public let stop: StopScheduleResponse
    
    enum CodingKeys: String, CodingKey {
        case arrivals = "ScheduleArrivals"
        case stop = "Stop"
    }
}

public struct BusArrival: Decodable {
    public let scheduleTime: String
    public let directionNumber: String
    public let startTime: String
    public let endTime: String
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
        
        self.scheduleTime = try container.decode(String.self, forKey: .scheduleTime)
        self.directionNumber = try container.decode(String.self, forKey: .directionNumber)
        self.startTime = try container.decode(String.self, forKey: .startTime)
        self.endTime = try container.decode(String.self, forKey: .endTime)
        
        guard let route = Route(rawValue: try container.decode(String.self, forKey: .route)) else {
            throw WMATAError(statusCode: 0, message: "Route provided by API was not valid")
            
        }
        
        self.route = route
        self.tripDirectionText = try container.decode(String.self, forKey: .tripDirectionText)
        self.tripHeadsign = try container.decode(String.self, forKey: .tripHeadsign)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        
    }
    
}

public struct StopScheduleResponse: Decodable {
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
    
}

public struct StopsSearchResponse: Decodable {
    public let stops: [StopScheduleResponse]
    
    enum CodingKeys: String, CodingKey {
        case stops = "Stops"
    }
}

public struct BusIncidents: Decodable {
    public let incidents: [BusIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "BusIncidents"
    }
}

public struct BusIncident: Decodable {
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

public struct RouteSchedule: Decodable {
    public let name: String
    public let directionZero: [RouteInfo]
    public let directionOne: [RouteInfo]
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case directionZero = "Direction0"
        case directionOne = "Direction1"
    }
}

public struct RouteInfo: Decodable {
    public let route: Route
    public let directionNumber: String
    public let tripDirectionText: String
    public let tripHeadsign: String
    public let startTime: String
    public let endTime: String
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
        self.startTime = try container.decode(String.self, forKey: .startTime)
        self.endTime = try container.decode(String.self, forKey: .endTime)
        self.stopTimes = try container.decode([StopInfo].self, forKey: .stopTimes)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        
    }
    
}

public struct StopInfo: Decodable {
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
    
}
