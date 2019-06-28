//
//  RailResponses.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//

public struct RailPredictions: Codable {
    let trains: [RailPrediction]
    
    enum CodingKeys: String, CodingKey {
        case trains = "Trains"
    }
}

public struct RailPrediction: Codable {
    let car: String?
    let destination: String
    let destinationCode: String?
    let destinationName: String
    let group: String
    let line: String
    let locationCode: String
    let locationName: String
    let minutes: String
    
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
    let trainPositions: [TrainPosition]
    
    enum CodingKeys: String, CodingKey {
        case trainPositions = "TrainPositions"
    }
}

public struct TrainPosition: Codable {
    let trainId: String
    let trainNumber: String
    let carCount: Int
    let directionNumber: Int
    let circuitId: Int
    let destinationStationCode: String?
    let lineCode: String?
    let secondsAtLocation: Int
    let serviceType: String
    
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
    let standardRoutes: [StandardRoute]
    
    enum CodingKeys: String, CodingKey {
        case standardRoutes = "StandardRoutes"
    }
}

public struct StandardRoute: Codable {
    let lineCode: String
    let trackNumber: Int
    let trackCircuits: [TrackCircuitWithStation]
    
    enum CodingKeys: String, CodingKey {
        case lineCode = "LineCode"
        case trackNumber = "TrackNum"
        case trackCircuits = "TrackCircuits"
    }
}

public struct TrackCircuitWithStation: Codable {
    let sequenceNumber: Int
    let circuitId: Int
    let stationCode: String?
    
    enum CodingKeys: String, CodingKey {
        case sequenceNumber = "SeqNum"
        case circuitId = "CircuitId"
        case stationCode = "StationCode"
    }
}

public struct TrackCircuits: Codable {
    let trackCircuits: [TrackCircuit]
    
    enum CodingKeys: String, CodingKey {
        case trackCircuits = "TrackCircuits"
    }
}

public struct TrackCircuit: Codable {
    let track: Int
    let circuitId: Int
    let neighbors: [TrackNeighbor]
    
    enum CodingKeys: String, CodingKey {
        case track = "Track"
        case circuitId = "CircuitId"
        case neighbors = "Neighbors"
    }
}

public struct TrackNeighbor: Codable {
    let neighborType: String
    let circuitIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case neighborType = "NeighborType"
        case circuitIds = "CircuitIds"
    }
}

public struct LinesResponse: Codable {
    let lines: [LineResponse]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.lines = try values.decode([LineResponse].self, forKey: .lines)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case lines = "Lines"
    }
}

public struct LineResponse: Codable {
    let lineCode: String
    let displayName: String
    let startStationCode: String
    let endStationCode: String
    let firstInternalDestination: String
    let secondInternalDestination: String
    
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
    let stationsParking: [StationParking]
    
    enum CodingKeys: String, CodingKey {
        case stationsParking = "StationsParking"
    }
}

public struct StationParking: Codable {
    let code: String
    let notes: String
    let allDayParking: AllDayParking
    let shortTermParking: ShortTermParking
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case notes = "Notes"
        case allDayParking = "AllDayParking"
        case shortTermParking = "ShortTermParking"
    }
}

public struct AllDayParking: Codable {
    let totalCount: Int
    let riderCost: Double
    let nonRiderCost: Double
    let saturdayRiderCost: Double
    let saturdayNonRiderCost: Double
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case riderCost = "RiderCost"
        case nonRiderCost = "NonRiderCost"
        case saturdayRiderCost = "SaturdayRiderCost"
        case saturdayNonRiderCost = "SaturdayNonRiderCost"
    }
}

public struct ShortTermParking: Codable {
    let totalCount: Int
    let notes: String
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case notes = "Notes"
    }
}

public struct PathBetweenStations: Codable {
    let path: [Path]
    
    enum CodingKeys: String, CodingKey {
        case path = "Path"
    }
}

public struct Path: Codable {
    let distanceToPreviousStation: Int
    let lineCode: String
    let sequenceNumber: Int
    let stationCode: String
    let stationName: String
    
    enum CodingKeys: String, CodingKey {
        case distanceToPreviousStation = "DistanceToPrev"
        case lineCode = "LineCode"
        case sequenceNumber = "SeqNum"
        case stationCode = "StationCode"
        case stationName = "StationName"
    }
}

public struct StationEntrances: Codable {
    let entrances: [StationEntrance]
    
    enum CodingKeys: String, CodingKey {
        case entrances = "Entrances"
    }
}

public struct StationEntrance: Codable {
    let description: String
    let id: String
    let latitude: Double
    let longitude: Double
    let name: String
    let firstStationCode: String
    let secondStationCode: String
    
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
    let address: StationAddress
    let code: String
    let latitude: Double
    let longitude: Double
    let firstLineCode: String
    let secondLineCode: String?
    let thirdLineCode: String?
    let fourthLineCode: String?
    let name: String
    let firstStationTogether: String
    let secondStationTogether: String
    
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
    let city: String
    let state: String
    let street: String
    let zip: String
    
    enum CodingKeys: String, CodingKey {
        case city = "City"
        case state = "State"
        case street = "Street"
        case zip = "Zip"
    }
}

public struct Stations: Codable {
    let stations: [StationInformation]
    
    enum CodingKeys: String, CodingKey {
        case stations = "Stations"
    }
}

public struct StationTimings: Codable {
    let stationTimes: [StationTime]
    
    enum CodingKeys: String, CodingKey {
        case stationTimes = "StationTimes"
    }
}

public struct StationTime: Codable {
    let code: String
    let stationName: String
    let monday: StationFirstLastTrains
    let tuesday: StationFirstLastTrains
    let wednesday: StationFirstLastTrains
    let thursday: StationFirstLastTrains
    let friday: StationFirstLastTrains
    let saturday: StationFirstLastTrains
    let sunday: StationFirstLastTrains
    
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
    let openingTime: String
    let firstTrains: [TrainTime]
    let lastTrains: [TrainTime]
    
    enum CodingKeys: String, CodingKey {
        case openingTime = "OpeningTime"
        case firstTrains = "FirstTrains"
        case lastTrains = "LastTrains"
    }
}

public struct TrainTime: Codable {
    let time: String
    let destinationStation: String
    
    enum CodingKeys: String, CodingKey {
        case time = "Time"
        case destinationStation = "DestinationStation"
    }
}

public struct StationToStationInfos: Codable {
    let stationToStationInfos: [StationToStationInfo]
    
    enum CodingKeys: String, CodingKey {
        case stationToStationInfos = "StationToStationInfos"
    }
}

public struct StationToStationInfo: Codable {
    let compositeMiles: Double
    let destinationStation: String
    let railFare: RailFare
    let railTime: Int
    let sourceStation: String
    
    enum CodingKeys: String, CodingKey {
        case compositeMiles = "CompositeMiles"
        case destinationStation = "DestinationStation"
        case railFare = "RailFare"
        case railTime = "RailTime"
        case sourceStation = "SourceStation"
    }
}

public struct RailFare: Codable {
    let offPeakTime: Double
    let peakTime: Double
    let seniorDisabled: Double
    
    enum CodingKeys: String, CodingKey {
        case offPeakTime = "OffPeakTime"
        case peakTime = "PeakTime"
        case seniorDisabled = "SeniorDisabled"
    }
}

public struct ElevatorAndEscalatorIncidents: Codable {
    let incidents: [ElevatorAndEscalatorIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "ElevatorIncidents"
    }
}

public struct ElevatorAndEscalatorIncident: Codable {
    let unitName: String
    let unitType: String
    let unitStatus: String?
    let stationCode: String
    let stationName: String
    let locationDescription: String
    let symptomCode: String?
    let timeOutOfService: String
    let symptomDescription: String
    let displayOrder: Double
    let dateOutOfService: String
    let dateUpdated: String
    let estimatedReturnToService: String
    
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
    let incidents: [RailIncident]
    
    enum CodingKeys: String, CodingKey {
        case incidents = "Incidents"
    }
}

public struct RailIncident: Codable {
    let incidentID: String
    let description: String
    let startLocationFullName: String?
    let endLocationFullName: String?
    let passengerDelay: Double
    let delaySeverity: String?
    let incidentType: String
    let emergencyText: String?
    let linesAffected: String
    let dateUpdated: String
    
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
