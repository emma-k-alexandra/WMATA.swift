//
//  RailResponses.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//

public struct RailPredictions: Codable {
    public let trains: [RailPrediction]
    
    enum CodingKeys: String, CodingKey {
        case trains = "Trains"
    }
}

public struct RailPrediction: Codable {
    public let car: String?
    public let destination: String
    public let destinationCode: String?
    public let destinationName: String
    public let group: String
    public let line: String
    public let locationCode: String
    public let locationName: String
    public let minutes: String
    
    enum CodingKeys: String, CodingKey {
        case car = "Car"
        case destination = "Destination"
        case destinationCode = "DestinationCode"
        case destinationName = "DestinationName"
        case group = "Group"
        case line = "Line"
        case locationCode = "LocationCode"
        case locationName = "LocationName"
        case minutes = "Min"
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
    public let destinationStationCode: String?
    public let lineCode: String?
    public let secondsAtLocation: Int
    public let serviceType: String
    
    enum CodingKeys: String, CodingKey {
        case trainId = "TrainId"
        case trainNumber = "TrainNumber"
        case carCount = "CarCount"
        case directionNumber = "DirectionNum"
        case circuitId = "CircuitId"
        case destinationStationCode = "DestinationStationCode"
        case lineCode = "LineCode"
        case secondsAtLocation = "SecondsAtLocation"
        case serviceType = "ServiceType"
    }
}

public struct StandardRoutes: Codable {
    public let standardRoutes: [StandardRoute]
    
    enum CodingKeys: String, CodingKey {
        case standardRoutes = "StandardRoutes"
    }
}

public struct StandardRoute: Codable {
    public let lineCode: String
    public let trackNumber: Int
    public let trackCircuits: [TrackCircuitWithStation]
    
    enum CodingKeys: String, CodingKey {
        case lineCode = "LineCode"
        case trackNumber = "TrackNum"
        case trackCircuits = "TrackCircuits"
    }
}

public struct TrackCircuitWithStation: Codable {
    public let sequenceNumber: Int
    public let circuitId: Int
    public let stationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case sequenceNumber = "SeqNum"
        case circuitId = "CircuitId"
        case stationCode = "StationCode"
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
    public let lineCode: String
    public let displayName: String
    public let startStationCode: String
    public let endStationCode: String
    public let firstInternalDestination: String
    public let secondInternalDestination: String
    
    enum CodingKeys: String, CodingKey {
        case lineCode = "LineCode"
        case displayName = "DisplayName"
        case startStationCode = "StartStationCode"
        case endStationCode = "EndStationCode"
        case firstInternalDestination = "InternalDestination1"
        case secondInternalDestination = "InternalDestination2"
    }
}

public struct StationsParking: Codable {
    public let stationsParking: [StationParking]
    
    enum CodingKeys: String, CodingKey {
        case stationsParking = "StationsParking"
    }
}

public struct StationParking: Codable {
    public let code: String
    public let notes: String
    public let allDayParking: AllDayParking
    public let shortTermParking: ShortTermParking
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case notes = "Notes"
        case allDayParking = "AllDayParking"
        case shortTermParking = "ShortTermParking"
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
    public let lineCode: String
    public let sequenceNumber: Int
    public let stationCode: String
    public let stationName: String
    
    enum CodingKeys: String, CodingKey {
        case distanceToPreviousStation = "DistanceToPrev"
        case lineCode = "LineCode"
        case sequenceNumber = "SeqNum"
        case stationCode = "StationCode"
        case stationName = "StationName"
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
    public let firstStationCode: String
    public let secondStationCode: String
    
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case id = "ID"
        case latitude = "Lat"
        case longitude = "Lon"
        case name = "Name"
        case firstStationCode = "StationCode1"
        case secondStationCode = "StationCode2"
    }
}

public struct StationInformation: Codable {
    public let address: StationAddress
    public let code: String
    public let latitude: Double
    public let longitude: Double
    public let firstLineCode: String
    public let secondLineCode: String?
    public let thirdLineCode: String?
    public let fourthLineCode: String?
    public let name: String
    public let firstStationTogether: String
    public let secondStationTogether: String
    
    enum CodingKeys: String, CodingKey {
        case address = "Address"
        case code = "Code"
        case latitude = "Lat"
        case longitude = "Lon"
        case firstLineCode = "LineCode1"
        case secondLineCode = "LineCode2"
        case thirdLineCode = "LineCode3"
        case fourthLineCode = "LineCode4"
        case name = "Name"
        case firstStationTogether = "StationTogether1"
        case secondStationTogether = "StationTogether2"
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
    public let code: String
    public let stationName: String
    public let monday: StationFirstLastTrains
    public let tuesday: StationFirstLastTrains
    public let wednesday: StationFirstLastTrains
    public let thursday: StationFirstLastTrains
    public let friday: StationFirstLastTrains
    public let saturday: StationFirstLastTrains
    public let sunday: StationFirstLastTrains
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case stationName = "StationName"
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
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
    public let destinationStation: String
    
    enum CodingKeys: String, CodingKey {
        case time = "Time"
        case destinationStation = "DestinationStation"
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
    public let destinationStation: String
    public let railFare: RailFare
    public let railTime: Int
    public let sourceStation: String
    
    enum CodingKeys: String, CodingKey {
        case compositeMiles = "CompositeMiles"
        case destinationStation = "DestinationStation"
        case railFare = "RailFare"
        case railTime = "RailTime"
        case sourceStation = "SourceStation"
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
    public let stationCode: String
    public let stationName: String
    public let locationDescription: String
    public let symptomCode: String?
    public let timeOutOfService: String
    public let symptomDescription: String
    public let displayOrder: Double
    public let dateOutOfService: String
    public let dateUpdated: String
    public let estimatedReturnToService: String
    
    enum CodingKeys: String, CodingKey {
        case unitName = "UnitName"
        case unitType = "UnitType"
        case unitStatus = "UnitStatus"
        case stationCode = "StationCode"
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
    public let dateUpdated: String
    
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
}
