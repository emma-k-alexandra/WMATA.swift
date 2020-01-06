//
//  RailResponses.swift
//  
//
//  Created by Emma K Alexandra on 6/16/19.
//

import Foundation

public struct RailPredictions: Codable {
    public let trains: [RailPrediction]
    
    enum CodingKeys: String, CodingKey {
        case trains = "Trains"
    }
    
}

public struct RailPrediction: Codable {
    public let car: String?
    public let destination: String
    public let destinationCode: Station?
    public let destinationName: String
    public let group: String
    public let line: Line
    public let location: Station
    public let locationName: String
    public let minutes: String
    
    enum CodingKeys: String, CodingKey {
        case car = "Car"
        case destination = "Destination"
        case destinationCode = "DestinationCode"
        case destinationName = "DestinationName"
        case group = "Group"
        case line = "Line"
        case location = "LocationCode"
        case locationName = "LocationName"
        case minutes = "Min"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.car = try container.decode(String?.self, forKey: .car)
        self.destination = try container.decode(String.self, forKey: .destination)
        
        let destinationCode = try container.decode(String?.self, forKey: .destinationCode)
        
        if let destinationCode = destinationCode, destinationCode != "" {
            guard let destination = Station(rawValue: destinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
                
            }
            
            self.destinationCode = destination
            
        } else {
            self.destinationCode = nil
            
        }
    
        self.destinationName = try container.decode(String.self, forKey: .destinationName)
        self.group = try container.decode(String.self, forKey: .group)
        
        guard let line = Line(rawValue: try container.decode(String.self, forKey: .line)) else {
             throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            
        }
        
        self.line = line
        
        guard let location = Station(rawValue: try container.decode(String.self, forKey: .location)) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.location = location
        self.locationName = try container.decode(String.self, forKey: .locationName)
        self.minutes = try container.decode(String.self, forKey: .minutes)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.car, forKey: .car)
        try container.encode(self.destination, forKey: .destination)
        try container.encode(self.destinationCode?.description, forKey: .destinationCode)
        try container.encode(self.destinationName, forKey: .destinationName)
        try container.encode(self.group, forKey: .group)
        try container.encode(self.line.description, forKey: .line)
        try container.encode(self.location.description, forKey: .location)
        try container.encode(self.locationName, forKey: .locationName)
        try container.encode(self.minutes, forKey: .minutes)
        
    }
    
}

public struct TrainPositions: Codable {
    public let trainPositions: [TrainPosition]
    
    enum CodingKeys: String, CodingKey {
        case trainPositions = "TrainPositions"
    }
    
}

public struct TrainPosition: Codable {
    public let trainId: String
    public let trainNumber: String
    public let carCount: Int
    public let directionNumber: Int
    public let circuitId: Int
    public let destination: Station?
    public let line: Line?
    public let secondsAtLocation: Int
    public let serviceType: String
    
    enum CodingKeys: String, CodingKey {
        case trainId = "TrainId"
        case trainNumber = "TrainNumber"
        case carCount = "CarCount"
        case directionNumber = "DirectionNum"
        case circuitId = "CircuitId"
        case destination = "DestinationStationCode"
        case line = "LineCode"
        case secondsAtLocation = "SecondsAtLocation"
        case serviceType = "ServiceType"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.trainId = try container.decode(String.self, forKey: .trainId)
        self.trainNumber = try container.decode(String.self, forKey: .trainNumber)
        self.carCount = try container.decode(Int.self, forKey: .carCount)
        self.directionNumber = try container.decode(Int.self, forKey: .directionNumber)
        self.circuitId = try container.decode(Int.self, forKey: .circuitId)
        
        let destinationCode = try container.decode(String?.self, forKey: .destination)
        
        if let destinationCode = destinationCode, destinationCode != "" {
            guard let destination = Station(rawValue: destinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
                
            }
            
            self.destination = destination
            
        } else {
            self.destination = nil
            
        }
        
        let lineCode = try container.decode(String?.self, forKey: .line)
        
        if let lineCode = lineCode, lineCode != "" {
            guard let line = Line(rawValue: lineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
                
            }
            
            self.line = line
            
        } else {
            self.line = nil
            
        }
        
        self.secondsAtLocation = try container.decode(Int.self, forKey: .secondsAtLocation)
        self.serviceType = try container.decode(String.self, forKey: .serviceType)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.trainId, forKey: .trainId)
        try container.encode(self.trainNumber, forKey: .trainNumber)
        try container.encode(self.carCount, forKey: .carCount)
        try container.encode(self.directionNumber, forKey: .directionNumber)
        try container.encode(self.circuitId, forKey: .circuitId)
        try container.encode(self.destination?.description, forKey: .destination)
        try container.encode(self.line?.description, forKey: .line)
        try container.encode(self.secondsAtLocation, forKey: .secondsAtLocation)
        try container.encode(self.serviceType, forKey: .serviceType)
        
    }
    
}

public struct StandardRoutes: Codable {
    public let standardRoutes: [StandardRoute]
    
    enum CodingKeys: String, CodingKey {
        case standardRoutes = "StandardRoutes"
    }
    
}

public struct StandardRoute: Codable {
    public let line: Line
    public let trackNumber: Int
    public let trackCircuits: [TrackCircuitWithStation]
    
    enum CodingKeys: String, CodingKey {
        case line = "LineCode"
        case trackNumber = "TrackNum"
        case trackCircuits = "TrackCircuits"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let lineCode = try container.decode(String.self, forKey: .line)
        
        guard let line = Line(rawValue: lineCode) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            
        }
        
        self.line = line
        
        self.trackNumber = try container.decode(Int.self, forKey: .trackNumber)
        self.trackCircuits = try container.decode([TrackCircuitWithStation].self, forKey: .trackCircuits)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.line.description, forKey: .line)
        try container.encode(self.trackNumber, forKey: .trackNumber)
        try container.encode(self.trackCircuits, forKey: .trackCircuits)
        
    }
    
}

public struct TrackCircuitWithStation: Codable {
    public let sequenceNumber: Int
    public let circuitId: Int
    public let station: Station?
    
    enum CodingKeys: String, CodingKey {
        case sequenceNumber = "SeqNum"
        case circuitId = "CircuitId"
        case station = "StationCode"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sequenceNumber = try container.decode(Int.self, forKey: .sequenceNumber)
        self.circuitId = try container.decode(Int.self, forKey: .circuitId)
        
        let stationCode = try container.decode(String?.self, forKey: .station)
        
        if let stationCode = stationCode, stationCode != "" {
            guard let station = Station(rawValue: stationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
                
            }
            
            self.station = station
            
        } else {
            self.station = nil
            
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.sequenceNumber, forKey: .sequenceNumber)
        try container.encode(self.circuitId, forKey: .circuitId)
        try container.encode(self.station?.description, forKey: .station)
        
    }
    
}

public struct TrackCircuits: Codable {
    public let trackCircuits: [TrackCircuit]
    
    enum CodingKeys: String, CodingKey {
        case trackCircuits = "TrackCircuits"
    }
    
}

public struct TrackCircuit: Codable {
    public let track: Int
    public let circuitId: Int
    public let neighbors: [TrackNeighbor]
    
    enum CodingKeys: String, CodingKey {
        case track = "Track"
        case circuitId = "CircuitId"
        case neighbors = "Neighbors"
    }
    
}

public struct TrackNeighbor: Codable {
    public let neighborType: String
    public let circuitIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case neighborType = "NeighborType"
        case circuitIds = "CircuitIds"
    }
    
}

public struct LinesResponse: Codable {
    public let lines: [LineResponse]
    
    enum CodingKeys: String, CodingKey {
        case lines = "Lines"
    }
    
}

public struct LineResponse: Codable {
    public let line: Line
    public let displayName: String
    public let startStation: Station
    public let endStation: Station
    public let firstInternalDestination: Station?
    public let secondInternalDestination: Station?
    
    enum CodingKeys: String, CodingKey {
        case line = "LineCode"
        case displayName = "DisplayName"
        case startStation = "StartStationCode"
        case endStation = "EndStationCode"
        case firstInternalDestination = "InternalDestination1"
        case secondInternalDestination = "InternalDestination2"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let line = Line(rawValue: try container.decode(String.self, forKey: .line)) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            
        }
        
        self.line = line
        self.displayName = try container.decode(String.self, forKey: .displayName)
        
        guard let startStation = Station(rawValue: try container.decode(String.self, forKey: .startStation)) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.startStation = startStation
        
        guard let endStation = Station(rawValue: try container.decode(String.self, forKey: .endStation)) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.endStation = endStation
        
        let internalDestinationCode = try container.decode(String?.self, forKey: .firstInternalDestination)
        
        if let internalDestinationCode = internalDestinationCode, internalDestinationCode != "" {
            guard let destination = Station(rawValue: internalDestinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
                
            }
            
            self.firstInternalDestination = destination
            
        } else {
            self.firstInternalDestination = nil
            
        }
        
        let secondInternalDestinationCode = try container.decode(String?.self, forKey: .secondInternalDestination)
        
        if let secondInternalDestinationCode = secondInternalDestinationCode, secondInternalDestinationCode != "" {
            guard let destination = Station(rawValue: secondInternalDestinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
                
            }
            
            self.secondInternalDestination = destination
            
        } else {
            self.secondInternalDestination = nil
            
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.line.description, forKey: .line)
        try container.encode(self.displayName, forKey: .displayName)
        try container.encode(self.startStation.description, forKey: .startStation)
        try container.encode(self.endStation.description, forKey: .endStation)
        try container.encode(self.firstInternalDestination?.description, forKey: .firstInternalDestination)
        try container.encode(self.secondInternalDestination?.description, forKey: .secondInternalDestination)
        
    }
    
}

public struct StationsParking: Codable {
    public let stationsParking: [StationParking]
    
    enum CodingKeys: String, CodingKey {
        case stationsParking = "StationsParking"
    }
    
}

public struct StationParking: Codable {
    public let station: Station
    public let notes: String
    public let allDayParking: AllDayParking
    public let shortTermParking: ShortTermParking
    
    enum CodingKeys: String, CodingKey {
        case station = "Code"
        case notes = "Notes"
        case allDayParking = "AllDayParking"
        case shortTermParking = "ShortTermParking"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let stationCode = try container.decode(String.self, forKey: .station)
        
        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.station = station
        self.notes = try container.decode(String.self, forKey: .notes)
        self.allDayParking = try container.decode(AllDayParking.self, forKey: .allDayParking)
        self.shortTermParking = try container.decode(ShortTermParking.self, forKey: .shortTermParking)
    
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.station.description, forKey: .station)
        try container.encode(self.notes, forKey: .notes)
        try container.encode(self.allDayParking, forKey: .allDayParking)
        try container.encode(self.shortTermParking, forKey: .shortTermParking)
        
    }
    
}

public struct AllDayParking: Codable {
    public let totalCount: Int
    public let riderCost: Double
    public let nonRiderCost: Double
    public let saturdayRiderCost: Double
    public let saturdayNonRiderCost: Double
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case riderCost = "RiderCost"
        case nonRiderCost = "NonRiderCost"
        case saturdayRiderCost = "SaturdayRiderCost"
        case saturdayNonRiderCost = "SaturdayNonRiderCost"
    }
}

public struct ShortTermParking: Codable {
    public let totalCount: Int
    public let notes: String
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case notes = "Notes"
    }
}

public struct PathBetweenStations: Codable {
    public let path: [Path]
    
    enum CodingKeys: String, CodingKey {
        case path = "Path"
    }
    
}

public struct Path: Codable {
    public let distanceToPreviousStation: Int
    public let line: Line
    public let sequenceNumber: Int
    public let station: Station
    public let stationName: String
    
    enum CodingKeys: String, CodingKey {
        case distanceToPreviousStation = "DistanceToPrev"
        case line = "LineCode"
        case sequenceNumber = "SeqNum"
        case station = "StationCode"
        case stationName = "StationName"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.distanceToPreviousStation = try container.decode(Int.self, forKey: .distanceToPreviousStation)
        
        let lineCode = try container.decode(String.self, forKey: .line)
        
        guard let line = Line(rawValue: lineCode) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            
        }
        
        self.line = line
        
        self.sequenceNumber = try container.decode(Int.self, forKey: .sequenceNumber)
        
        let stationCode = try container.decode(String.self, forKey: .station)
        
        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.station = station
        self.stationName = try container.decode(String.self, forKey: .stationName)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.distanceToPreviousStation, forKey: .distanceToPreviousStation)
        try container.encode(self.line.description, forKey: .line)
        try container.encode(self.sequenceNumber, forKey: .sequenceNumber)
        try container.encode(self.station.description, forKey: .station)
        try container.encode(self.stationName, forKey: .stationName)
        
    }
    
}

public struct StationEntrances: Codable {
    public let entrances: [StationEntrance]
    
    enum CodingKeys: String, CodingKey {
        case entrances = "Entrances"
    }
    
}

public struct StationEntrance: Codable {
    public let description: String
    public let id: String
    public let latitude: Double
    public let longitude: Double
    public let name: String
    public let firstStation: Station
    public let secondStation: Station?
    
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case id = "ID"
        case latitude = "Lat"
        case longitude = "Lon"
        case name = "Name"
        case firstStation = "StationCode1"
        case secondStation = "StationCode2"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.description = try container.decode(String.self, forKey: .description)
        self.id = try container.decode(String.self, forKey: .id)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.name = try container.decode(String.self, forKey: .name)
        
        let firstStationCode = try container.decode(String.self, forKey: .firstStation)
        
        guard let firstStation = Station(rawValue: firstStationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.firstStation = firstStation
        
        let secondStationCode = try container.decode(String?.self, forKey: .secondStation)
        
        if let secondStationCode = secondStationCode, secondStationCode != "" {
            guard let station = Station(rawValue: secondStationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
                
            }
            
            self.secondStation = station
            
        } else {
            self.secondStation = nil
            
        }
        
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.description, forKey: .description)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.firstStation.description, forKey: .firstStation)
        try container.encode(self.secondStation?.description, forKey: .secondStation)
        
    }
    
}

public struct StationInformation: Codable {
    public let address: StationAddress
    public let station: Station
    public let latitude: Double
    public let longitude: Double
    public let firstLine: Line
    public let secondLine: Line?
    public let thirdLine: Line?
    public let fourthLine: Line?
    public let name: String
    public let firstStationTogether: Station?
    public let secondStationTogether: Station?
    
    enum CodingKeys: String, CodingKey {
        case address = "Address"
        case station = "Code"
        case latitude = "Lat"
        case longitude = "Lon"
        case firstLine = "LineCode1"
        case secondLine = "LineCode2"
        case thirdLine = "LineCode3"
        case fourthLine = "LineCode4"
        case name = "Name"
        case firstStationTogether = "StationTogether1"
        case secondStationTogether = "StationTogether2"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.address = try container.decode(StationAddress.self, forKey: .address)
        
        let stationCode = try container.decode(String.self, forKey: .station)
        
        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station \(stationCode) provided by API was not valid")
            
        }
        
        self.station = station
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        
        let firstLineCode = try container.decode(String.self, forKey: .firstLine)
        
        guard let firstLine = Line(rawValue: firstLineCode) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            
        }
        
        self.firstLine = firstLine
        
        let secondLineCode = try container.decode(String?.self, forKey: .secondLine)
        
        if let secondLineCode = secondLineCode, secondLineCode != "" {
            guard let secondLine = Line(rawValue: secondLineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
                
            }
            
            self.secondLine = secondLine
            
        } else {
            self.secondLine = nil
            
        }
        
        let thirdLineCode = try container.decode(String?.self, forKey: .thirdLine)
        
        if let thirdLineCode = thirdLineCode, thirdLineCode != "" {
            guard let thirdLine = Line(rawValue: thirdLineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
                
            }
            
            self.thirdLine = thirdLine
            
        } else {
            self.thirdLine = nil
            
        }
        
        let fourthLineCode = try container.decode(String?.self, forKey: .fourthLine)
        
        if let fourthLineCode = fourthLineCode, fourthLineCode != "" {
            guard let fourthLine = Line(rawValue: fourthLineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
                
            }
            
            self.fourthLine = fourthLine
            
        } else {
            self.fourthLine = nil
            
        }
        
        self.name = try container.decode(String.self, forKey: .name)
        
        let firstStationTogetherCode = try container.decode(String?.self, forKey: .firstStationTogether)
        
        if let firstStationTogetherCode = firstStationTogetherCode, firstStationTogetherCode != "" {
            guard let firstStationTogether = Station(rawValue: firstStationTogetherCode) else {
                throw WMATAError(statusCode: 0, message: "Station \(firstStationTogetherCode) provided by API was not valid")
                
            }
            
            self.firstStationTogether = firstStationTogether
            
        } else {
            self.firstStationTogether = nil
            
        }
        
        let secondStationTogetherCode = try container.decode(String?.self, forKey: .secondStationTogether)
        
        if let secondStationTogetherCode = secondStationTogetherCode, secondStationTogetherCode != "" {
            guard let secondStationTogether = Station(rawValue: secondStationTogetherCode) else {
                throw WMATAError(statusCode: 0, message: "Station \(secondStationTogetherCode) provided by API was not valid")
                
            }
            
            self.secondStationTogether = secondStationTogether
            
        } else {
            self.secondStationTogether = nil
            
        }
        
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(self.address, forKey: .address)
        try container.encode(self.station, forKey: .station)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.firstLine.description, forKey: .firstLine)
        try container.encode(self.secondLine?.description, forKey: .secondLine)
        try container.encode(self.thirdLine?.description, forKey: .thirdLine)
        try container.encode(self.fourthLine?.description, forKey: .fourthLine)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.firstStationTogether?.description, forKey: .firstStationTogether)
        try container.encode(self.secondStationTogether?.description, forKey: .secondStationTogether)
    
    }
    
}

public struct StationAddress: Codable {
    public let city: String
    public let state: String
    public let street: String
    public let zip: String
    
    enum CodingKeys: String, CodingKey {
        case city = "City"
        case state = "State"
        case street = "Street"
        case zip = "Zip"
    }
}

public struct Stations: Codable {
    public let stations: [StationInformation]
    
    enum CodingKeys: String, CodingKey {
        case stations = "Stations"
    }
}

public struct StationTimings: Codable {
    public let stationTimes: [StationTime]
    
    enum CodingKeys: String, CodingKey {
        case stationTimes = "StationTimes"
    }
}

public struct StationTime: Codable {
    public let station: Station
    public let stationName: String
    public let monday: StationFirstLastTrains
    public let tuesday: StationFirstLastTrains
    public let wednesday: StationFirstLastTrains
    public let thursday: StationFirstLastTrains
    public let friday: StationFirstLastTrains
    public let saturday: StationFirstLastTrains
    public let sunday: StationFirstLastTrains
    
    enum CodingKeys: String, CodingKey {
        case station = "Code"
        case stationName = "StationName"
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let stationCode = try container.decode(String.self, forKey: .station)
        
        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station \(stationCode) provided by API was not valid")
            
        }
        
        self.station = station
        self.stationName = try container.decode(String.self, forKey: .stationName)
        self.monday = try container.decode(StationFirstLastTrains.self, forKey: .monday)
        self.tuesday = try container.decode(StationFirstLastTrains.self, forKey: .tuesday)
        self.wednesday = try container.decode(StationFirstLastTrains.self, forKey: .wednesday)
        self.thursday = try container.decode(StationFirstLastTrains.self, forKey: .thursday)
        self.friday = try container.decode(StationFirstLastTrains.self, forKey: .friday)
        self.saturday = try container.decode(StationFirstLastTrains.self, forKey: .saturday)
        self.sunday = try container.decode(StationFirstLastTrains.self, forKey: .sunday)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.station.description, forKey: .station)
        try container.encode(self.stationName, forKey: .stationName)
        try container.encode(self.monday, forKey: .monday)
        try container.encode(self.tuesday, forKey: .tuesday)
        try container.encode(self.wednesday, forKey: .wednesday)
        try container.encode(self.thursday, forKey: .thursday)
        try container.encode(self.friday, forKey: .friday)
        try container.encode(self.saturday, forKey: .saturday)
        try container.encode(self.sunday, forKey: .sunday)
        
    }
    
}

public struct StationFirstLastTrains: Codable {
    public let openingTime: String
    public let firstTrains: [TrainTime]
    public let lastTrains: [TrainTime]
    
    enum CodingKeys: String, CodingKey {
        case openingTime = "OpeningTime"
        case firstTrains = "FirstTrains"
        case lastTrains = "LastTrains"
    }
}

public struct TrainTime: Codable {
    public let time: String
    public let destination: Station
    
    enum CodingKeys: String, CodingKey {
        case time = "Time"
        case destination = "DestinationStation"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.time = try container.decode(String.self, forKey: .time)
        
        let destinationCode = try container.decode(String.self, forKey: .destination)
        
        guard let destination = Station(rawValue: destinationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.destination = destination
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
     
        try container.encode(self.time, forKey: .time)
        try container.encode(self.destination, forKey: .destination)
        
    }
    
}

public struct StationToStationInfos: Codable {
    public let stationToStationInfos: [StationToStationInfo]
    
    enum CodingKeys: String, CodingKey {
        case stationToStationInfos = "StationToStationInfos"
    }
    
}

public struct StationToStationInfo: Codable {
    public let compositeMiles: Double
    public let destination: Station
    public let railFare: RailFare
    public let railTime: Int
    public let source: Station
    
    enum CodingKeys: String, CodingKey {
        case compositeMiles = "CompositeMiles"
        case destination = "DestinationStation"
        case railFare = "RailFare"
        case railTime = "RailTime"
        case source = "SourceStation"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.compositeMiles = try container.decode(Double.self, forKey: .compositeMiles)
        
        let destinationCode = try container.decode(String.self, forKey: .destination)
        
        guard let destination = Station(rawValue: destinationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.destination = destination
        self.railFare = try container.decode(RailFare.self, forKey: .railFare)
        self.railTime = try container.decode(Int.self, forKey: .railTime)
        
        let sourceCode = try container.decode(String.self, forKey: .source)
        
        guard let source = Station(rawValue: sourceCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.source = source
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.compositeMiles, forKey: .compositeMiles)
        try container.encode(self.destination.description, forKey: .destination)
        try container.encode(self.railFare, forKey: .railFare)
        try container.encode(self.railTime, forKey: .railTime)
        try container.encode(self.source.description, forKey: .source)
        
    }
    
}

public struct RailFare: Codable {
    public let offPeakTime: Double
    public let peakTime: Double
    public let seniorDisabled: Double
    
    enum CodingKeys: String, CodingKey {
        case offPeakTime = "OffPeakTime"
        case peakTime = "PeakTime"
        case seniorDisabled = "SeniorDisabled"
    }
}

public struct ElevatorAndEscalatorIncidents: Codable {
    public let incidents: [ElevatorAndEscalatorIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "ElevatorIncidents"
    }
    
}

public struct ElevatorAndEscalatorIncident: Codable {
    public let unitName: String
    public let unitType: String
    public let unitStatus: String?
    public let station: Station
    public let stationName: String
    public let locationDescription: String
    public let symptomCode: String?
    public let timeOutOfService: String
    public let symptomDescription: String
    public let displayOrder: Double
    public let dateOutOfService: Date
    public let dateUpdated: String
    public let estimatedReturnToService: String
    
    enum CodingKeys: String, CodingKey {
        case unitName = "UnitName"
        case unitType = "UnitType"
        case unitStatus = "UnitStatus"
        case station = "StationCode"
        case stationName = "StationName"
        case locationDescription = "LocationDescription"
        case symptomCode = "SymptomCode"
        case timeOutOfService = "TimeOutOfService"
        case symptomDescription = "SymptomDescription"
        case displayOrder = "DisplayOrder"
        case dateOutOfService = "DateOutOfServ"
        case dateUpdated = "DateUpdated"
        case estimatedReturnToService = "EstimatedReturnToService"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.unitName = try container.decode(String.self, forKey: .unitName)
        self.unitType = try container.decode(String.self, forKey: .unitType)
        self.unitStatus = try container.decode(String?.self, forKey: .unitStatus)
        
        let stationCode = try container.decode(String.self, forKey: .station)
        
        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            
        }
        
        self.station = station
        self.stationName = try container.decode(String.self, forKey: .stationName)
        self.locationDescription = try container.decode(String.self, forKey: .locationDescription)
        self.symptomCode = try container.decode(String?.self, forKey: .symptomCode)
        self.timeOutOfService = try container.decode(String.self, forKey: .timeOutOfService)
        self.symptomDescription = try container.decode(String.self, forKey: .symptomDescription)
        self.displayOrder = try container.decode(Double.self, forKey: .displayOrder)
        self.dateOutOfService = try (try container.decode(String.self, forKey: .dateOutOfService)).toWMATADate()
        self.dateUpdated = try container.decode(String.self, forKey: .dateUpdated)
        self.estimatedReturnToService = try container.decode(String.self, forKey: .estimatedReturnToService)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
     
        try container.encode(self.unitName, forKey: .unitName)
        try container.encode(self.unitType, forKey: .unitType)
        try container.encode(self.unitStatus, forKey: .unitStatus)
        try container.encode(self.station.description, forKey: .station)
        try container.encode(self.stationName, forKey: .stationName)
        try container.encode(self.locationDescription, forKey: .locationDescription)
        try container.encode(self.symptomCode, forKey: .symptomCode)
        try container.encode(self.timeOutOfService, forKey: .timeOutOfService)
        try container.encode(self.symptomDescription, forKey: .symptomDescription)
        try container.encode(self.displayOrder, forKey: .displayOrder)
        try container.encode(self.dateOutOfService.toWMATAString(), forKey: .dateOutOfService)
        try container.encode(self.dateUpdated, forKey: .dateUpdated)
        try container.encode(self.estimatedReturnToService, forKey: .estimatedReturnToService)
        
    }
    
}

public struct RailIncidents: Codable {
    public let incidents: [RailIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "Incidents"
    }
}

public struct RailIncident: Codable {
    public let incidentID: String
    public let description: String
    public let startLocationFullName: String?
    public let endLocationFullName: String?
    public let passengerDelay: Double
    public let delaySeverity: String?
    public let incidentType: String
    public let emergencyText: String?
    public let linesAffected: String
    public let dateUpdated: Date
    
    enum CodingKeys: String, CodingKey {
        case incidentID = "IncidentID"
        case description = "Description"
        case startLocationFullName = "StartLocationFullName"
        case endLocationFullName = "EndLocationFullName"
        case passengerDelay = "PassengerDelay"
        case delaySeverity = "DelaySeverity"
        case incidentType = "IncidentType"
        case emergencyText = "EmergencyText"
        case linesAffected = "LinesAffected"
        case dateUpdated = "DateUpdated"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.incidentID = try container.decode(String.self, forKey: .incidentID)
        self.description = try container.decode(String.self, forKey: .description)
        self.startLocationFullName = try container.decode(String?.self, forKey: .startLocationFullName)
        self.endLocationFullName = try container.decode(String?.self, forKey: .endLocationFullName)
        self.passengerDelay = try container.decode(Double.self, forKey: .passengerDelay)
        self.delaySeverity = try container.decode(String?.self, forKey: .delaySeverity)
        self.incidentType = try container.decode(String.self, forKey: .incidentType)
        self.emergencyText = try container.decode(String?.self, forKey: .emergencyText)
        self.linesAffected = try container.decode(String.self, forKey: .linesAffected)
        self.dateUpdated = try (try container.decode(String.self, forKey: .dateUpdated)).toWMATADate()
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
     
        try container.encode(self.incidentID, forKey: .incidentID)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.startLocationFullName, forKey: .startLocationFullName)
        try container.encode(self.endLocationFullName, forKey: .endLocationFullName)
        try container.encode(self.passengerDelay, forKey: .passengerDelay)
        try container.encode(self.delaySeverity, forKey: .delaySeverity)
        try container.encode(self.incidentType, forKey: .incidentType)
        try container.encode(self.emergencyText, forKey: .emergencyText)
        try container.encode(self.linesAffected, forKey: .linesAffected)
        try container.encode(self.dateUpdated.toWMATAString(), forKey: .dateUpdated)
        
    }
    
}
