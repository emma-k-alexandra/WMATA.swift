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

    public init(trains: [RailPrediction]) {
        self.trains = trains
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

    public init(
        car: String?,
        destination: String,
        destinationCode: Station?,
        destinationName: String,
        group: String,
        line: Line,
        location: Station,
        locationName: String,
        minutes: String
    ) {
        self.car = car
        self.destination = destination
        self.destinationCode = destinationCode
        self.destinationName = destinationName
        self.group = group
        self.line = line
        self.location = location
        self.locationName = locationName
        self.minutes = minutes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        car = try container.decode(String?.self, forKey: .car)
        destination = try container.decode(String.self, forKey: .destination)

        let destinationCode = try container.decode(String?.self, forKey: .destinationCode)

        if let destinationCode = destinationCode, destinationCode != "" {
            guard let destination = Station(rawValue: destinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            }

            self.destinationCode = destination

        } else {
            self.destinationCode = nil
        }

        destinationName = try container.decode(String.self, forKey: .destinationName)
        group = try container.decode(String.self, forKey: .group)

        guard let line = Line(rawValue: try container.decode(String.self, forKey: .line)) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
        }

        self.line = line

        guard let location = Station(rawValue: try container.decode(String.self, forKey: .location)) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.location = location
        locationName = try container.decode(String.self, forKey: .locationName)
        minutes = try container.decode(String.self, forKey: .minutes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(car, forKey: .car)
        try container.encode(destination, forKey: .destination)
        try container.encode(destinationCode?.description, forKey: .destinationCode)
        try container.encode(destinationName, forKey: .destinationName)
        try container.encode(group, forKey: .group)
        try container.encode(line.description, forKey: .line)
        try container.encode(location.description, forKey: .location)
        try container.encode(locationName, forKey: .locationName)
        try container.encode(minutes, forKey: .minutes)
    }
}

public struct TrainPositions: Codable {
    public let trainPositions: [TrainPosition]

    enum CodingKeys: String, CodingKey {
        case trainPositions = "TrainPositions"
    }

    public init(trainPositions: [TrainPosition]) {
        self.trainPositions = trainPositions
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

    public init(
        trainId: String,
        trainNumber: String,
        carCount: Int,
        directionNumber: Int,
        circuitId: Int,
        destination: Station?,
        line: Line?,
        secondsAtLocation: Int,
        serviceType: String
    ) {
        self.trainId = trainId
        self.trainNumber = trainNumber
        self.carCount = carCount
        self.directionNumber = directionNumber
        self.circuitId = circuitId
        self.destination = destination
        self.line = line
        self.secondsAtLocation = secondsAtLocation
        self.serviceType = serviceType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        trainId = try container.decode(String.self, forKey: .trainId)
        trainNumber = try container.decode(String.self, forKey: .trainNumber)
        carCount = try container.decode(Int.self, forKey: .carCount)
        directionNumber = try container.decode(Int.self, forKey: .directionNumber)
        circuitId = try container.decode(Int.self, forKey: .circuitId)

        let destinationCode = try container.decode(String?.self, forKey: .destination)

        if let destinationCode = destinationCode, destinationCode != "" {
            guard let destination = Station(rawValue: destinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            }

            self.destination = destination

        } else {
            destination = nil
        }

        let lineCode = try container.decode(String?.self, forKey: .line)

        if let lineCode = lineCode, lineCode != "" {
            guard let line = Line(rawValue: lineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            }

            self.line = line

        } else {
            line = nil
        }

        secondsAtLocation = try container.decode(Int.self, forKey: .secondsAtLocation)
        serviceType = try container.decode(String.self, forKey: .serviceType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(trainId, forKey: .trainId)
        try container.encode(trainNumber, forKey: .trainNumber)
        try container.encode(carCount, forKey: .carCount)
        try container.encode(directionNumber, forKey: .directionNumber)
        try container.encode(circuitId, forKey: .circuitId)
        try container.encode(destination?.description, forKey: .destination)
        try container.encode(line?.description, forKey: .line)
        try container.encode(secondsAtLocation, forKey: .secondsAtLocation)
        try container.encode(serviceType, forKey: .serviceType)
    }
}

public struct StandardRoutes: Codable {
    public let standardRoutes: [StandardRoute]

    enum CodingKeys: String, CodingKey {
        case standardRoutes = "StandardRoutes"
    }

    public init(standardRoutes: [StandardRoute]) {
        self.standardRoutes = standardRoutes
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

    public init(
        line: Line,
        trackNumber: Int,
        trackCircuits: [TrackCircuitWithStation]
    ) {
        self.line = line
        self.trackNumber = trackNumber
        self.trackCircuits = trackCircuits
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let lineCode = try container.decode(String.self, forKey: .line)

        guard let line = Line(rawValue: lineCode) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
        }

        self.line = line

        trackNumber = try container.decode(Int.self, forKey: .trackNumber)
        trackCircuits = try container.decode([TrackCircuitWithStation].self, forKey: .trackCircuits)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(line.description, forKey: .line)
        try container.encode(trackNumber, forKey: .trackNumber)
        try container.encode(trackCircuits, forKey: .trackCircuits)
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

    public init(
        sequenceNumber: Int,
        circuitId: Int,
        station: Station?
    ) {
        self.sequenceNumber = sequenceNumber
        self.circuitId = circuitId
        self.station = station
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sequenceNumber = try container.decode(Int.self, forKey: .sequenceNumber)
        circuitId = try container.decode(Int.self, forKey: .circuitId)

        let stationCode = try container.decode(String?.self, forKey: .station)

        if let stationCode = stationCode, stationCode != "" {
            guard let station = Station(rawValue: stationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            }

            self.station = station

        } else {
            station = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(sequenceNumber, forKey: .sequenceNumber)
        try container.encode(circuitId, forKey: .circuitId)
        try container.encode(station?.description, forKey: .station)
    }
}

public struct TrackCircuits: Codable {
    public let trackCircuits: [TrackCircuit]

    enum CodingKeys: String, CodingKey {
        case trackCircuits = "TrackCircuits"
    }

    public init(trackCircuits: [TrackCircuit]) {
        self.trackCircuits = trackCircuits
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

    public init(
        track: Int,
        circuitId: Int,
        neighbors: [TrackNeighbor]
    ) {
        self.track = track
        self.circuitId = circuitId
        self.neighbors = neighbors
    }
}

public struct TrackNeighbor: Codable {
    public let neighborType: String
    public let circuitIds: [Int]

    enum CodingKeys: String, CodingKey {
        case neighborType = "NeighborType"
        case circuitIds = "CircuitIds"
    }

    public init(
        neighborType: String,
        circuitIds: [Int]
    ) {
        self.neighborType = neighborType
        self.circuitIds = circuitIds
    }
}

public struct LinesResponse: Codable {
    public let lines: [LineResponse]

    enum CodingKeys: String, CodingKey {
        case lines = "Lines"
    }

    public init(lines: [LineResponse]) {
        self.lines = lines
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

    public init(
        line: Line,
        displayName: String,
        startStation: Station,
        endStation: Station,
        firstInternalDestination: Station?,
        secondInternalDestination: Station?
    ) {
        self.line = line
        self.displayName = displayName
        self.startStation = startStation
        self.endStation = endStation
        self.firstInternalDestination = firstInternalDestination
        self.secondInternalDestination = secondInternalDestination
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let line = Line(rawValue: try container.decode(String.self, forKey: .line)) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
        }

        self.line = line
        displayName = try container.decode(String.self, forKey: .displayName)

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

            firstInternalDestination = destination

        } else {
            firstInternalDestination = nil
        }

        let secondInternalDestinationCode = try container.decode(String?.self, forKey: .secondInternalDestination)

        if let secondInternalDestinationCode = secondInternalDestinationCode, secondInternalDestinationCode != "" {
            guard let destination = Station(rawValue: secondInternalDestinationCode) else {
                throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
            }

            secondInternalDestination = destination

        } else {
            secondInternalDestination = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(line.description, forKey: .line)
        try container.encode(displayName, forKey: .displayName)
        try container.encode(startStation.description, forKey: .startStation)
        try container.encode(endStation.description, forKey: .endStation)
        try container.encode(firstInternalDestination?.description, forKey: .firstInternalDestination)
        try container.encode(secondInternalDestination?.description, forKey: .secondInternalDestination)
    }
}

public struct StationsParking: Codable {
    public let stationsParking: [StationParking]

    enum CodingKeys: String, CodingKey {
        case stationsParking = "StationsParking"
    }

    public init(stationsParking: [StationParking]) {
        self.stationsParking = stationsParking
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

    public init(
        station: Station,
        notes: String,
        allDayParking: AllDayParking,
        shortTermParking: ShortTermParking
    ) {
        self.station = station
        self.notes = notes
        self.allDayParking = allDayParking
        self.shortTermParking = shortTermParking
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let stationCode = try container.decode(String.self, forKey: .station)

        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.station = station
        notes = try container.decode(String.self, forKey: .notes)
        allDayParking = try container.decode(AllDayParking.self, forKey: .allDayParking)
        shortTermParking = try container.decode(ShortTermParking.self, forKey: .shortTermParking)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(station.description, forKey: .station)
        try container.encode(notes, forKey: .notes)
        try container.encode(allDayParking, forKey: .allDayParking)
        try container.encode(shortTermParking, forKey: .shortTermParking)
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

    public init(
        totalCount: Int,
        riderCost: Double,
        nonRiderCost: Double,
        saturdayRiderCost: Double,
        saturdayNonRiderCost: Double
    ) {
        self.totalCount = totalCount
        self.riderCost = riderCost
        self.nonRiderCost = nonRiderCost
        self.saturdayRiderCost = saturdayRiderCost
        self.saturdayNonRiderCost = saturdayNonRiderCost
    }
}

public struct ShortTermParking: Codable {
    public let totalCount: Int
    public let notes: String

    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case notes = "Notes"
    }

    public init(
        totalCount: Int,
        notes: String
    ) {
        self.totalCount = totalCount
        self.notes = notes
    }
}

public struct PathBetweenStations: Codable {
    public let path: [Path]

    enum CodingKeys: String, CodingKey {
        case path = "Path"
    }

    public init(path: [Path]) {
        self.path = path
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

    public init(
        distanceToPreviousStation: Int,
        line: Line,
        sequenceNumber: Int,
        station: Station,
        stationName: String
    ) {
        self.distanceToPreviousStation = distanceToPreviousStation
        self.line = line
        self.sequenceNumber = sequenceNumber
        self.station = station
        self.stationName = stationName
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        distanceToPreviousStation = try container.decode(Int.self, forKey: .distanceToPreviousStation)

        let lineCode = try container.decode(String.self, forKey: .line)

        guard let line = Line(rawValue: lineCode) else {
            throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
        }

        self.line = line

        sequenceNumber = try container.decode(Int.self, forKey: .sequenceNumber)

        let stationCode = try container.decode(String.self, forKey: .station)

        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.station = station
        stationName = try container.decode(String.self, forKey: .stationName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(distanceToPreviousStation, forKey: .distanceToPreviousStation)
        try container.encode(line.description, forKey: .line)
        try container.encode(sequenceNumber, forKey: .sequenceNumber)
        try container.encode(station.description, forKey: .station)
        try container.encode(stationName, forKey: .stationName)
    }
}

public struct StationEntrances: Codable {
    public let entrances: [StationEntrance]

    enum CodingKeys: String, CodingKey {
        case entrances = "Entrances"
    }

    public init(entrances: [StationEntrance]) {
        self.entrances = entrances
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

    public init(
        description: String,
        id: String,
        latitude: Double,
        longitude: Double,
        name: String,
        firstStation: Station,
        secondStation: Station?
    ) {
        self.description = description
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.firstStation = firstStation
        self.secondStation = secondStation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        description = try container.decode(String.self, forKey: .description)
        id = try container.decode(String.self, forKey: .id)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        name = try container.decode(String.self, forKey: .name)

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

            secondStation = station

        } else {
            secondStation = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(description, forKey: .description)
        try container.encode(id, forKey: .id)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(firstStation.description, forKey: .firstStation)
        try container.encode(secondStation?.description, forKey: .secondStation)
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

    public init(
        address: StationAddress,
        station: Station,
        latitude: Double,
        longitude: Double,
        firstLine: Line,
        secondLine: Line?,
        thirdLine: Line?,
        fourthLine: Line?,
        name: String,
        firstStationTogether: Station?,
        secondStationTogether: Station?
    ) {
        self.address = address
        self.station = station
        self.latitude = latitude
        self.longitude = longitude
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.thirdLine = thirdLine
        self.fourthLine = fourthLine
        self.name = name
        self.firstStationTogether = firstStationTogether
        self.secondStationTogether = secondStationTogether
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        address = try container.decode(StationAddress.self, forKey: .address)

        let stationCode = try container.decode(String.self, forKey: .station)

        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station \(stationCode) provided by API was not valid")
        }

        self.station = station
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)

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
            secondLine = nil
        }

        let thirdLineCode = try container.decode(String?.self, forKey: .thirdLine)

        if let thirdLineCode = thirdLineCode, thirdLineCode != "" {
            guard let thirdLine = Line(rawValue: thirdLineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            }

            self.thirdLine = thirdLine

        } else {
            thirdLine = nil
        }

        let fourthLineCode = try container.decode(String?.self, forKey: .fourthLine)

        if let fourthLineCode = fourthLineCode, fourthLineCode != "" {
            guard let fourthLine = Line(rawValue: fourthLineCode) else {
                throw WMATAError(statusCode: 0, message: "Line provided by API was not valid")
            }

            self.fourthLine = fourthLine

        } else {
            fourthLine = nil
        }

        name = try container.decode(String.self, forKey: .name)

        let firstStationTogetherCode = try container.decode(String?.self, forKey: .firstStationTogether)

        if let firstStationTogetherCode = firstStationTogetherCode, firstStationTogetherCode != "" {
            guard let firstStationTogether = Station(rawValue: firstStationTogetherCode) else {
                throw WMATAError(statusCode: 0, message: "Station \(firstStationTogetherCode) provided by API was not valid")
            }

            self.firstStationTogether = firstStationTogether

        } else {
            firstStationTogether = nil
        }

        let secondStationTogetherCode = try container.decode(String?.self, forKey: .secondStationTogether)

        if let secondStationTogetherCode = secondStationTogetherCode, secondStationTogetherCode != "" {
            guard let secondStationTogether = Station(rawValue: secondStationTogetherCode) else {
                throw WMATAError(statusCode: 0, message: "Station \(secondStationTogetherCode) provided by API was not valid")
            }

            self.secondStationTogether = secondStationTogether

        } else {
            secondStationTogether = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(address, forKey: .address)
        try container.encode(station, forKey: .station)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(firstLine.description, forKey: .firstLine)
        try container.encode(secondLine?.description, forKey: .secondLine)
        try container.encode(thirdLine?.description, forKey: .thirdLine)
        try container.encode(fourthLine?.description, forKey: .fourthLine)
        try container.encode(name, forKey: .name)
        try container.encode(firstStationTogether?.description, forKey: .firstStationTogether)
        try container.encode(secondStationTogether?.description, forKey: .secondStationTogether)
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

    public init(
        city: String,
        state: String,
        street: String,
        zip: String
    ) {
        self.city = city
        self.state = state
        self.street = street
        self.zip = zip
    }
}

public struct Stations: Codable {
    public let stations: [StationInformation]

    enum CodingKeys: String, CodingKey {
        case stations = "Stations"
    }

    public init(stations: [StationInformation]) {
        self.stations = stations
    }
}

public struct StationTimings: Codable {
    public let stationTimes: [StationTime]

    enum CodingKeys: String, CodingKey {
        case stationTimes = "StationTimes"
    }

    public init(stationTimes: [StationTime]) {
        self.stationTimes = stationTimes
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

    public init(
        station: Station,
        stationName: String,
        monday: StationFirstLastTrains,
        tuesday: StationFirstLastTrains,
        wednesday: StationFirstLastTrains,
        thursday: StationFirstLastTrains,
        friday: StationFirstLastTrains,
        saturday: StationFirstLastTrains,
        sunday: StationFirstLastTrains
    ) {
        self.station = station
        self.stationName = stationName
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let stationCode = try container.decode(String.self, forKey: .station)

        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station \(stationCode) provided by API was not valid")
        }

        self.station = station
        stationName = try container.decode(String.self, forKey: .stationName)
        monday = try container.decode(StationFirstLastTrains.self, forKey: .monday)
        tuesday = try container.decode(StationFirstLastTrains.self, forKey: .tuesday)
        wednesday = try container.decode(StationFirstLastTrains.self, forKey: .wednesday)
        thursday = try container.decode(StationFirstLastTrains.self, forKey: .thursday)
        friday = try container.decode(StationFirstLastTrains.self, forKey: .friday)
        saturday = try container.decode(StationFirstLastTrains.self, forKey: .saturday)
        sunday = try container.decode(StationFirstLastTrains.self, forKey: .sunday)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(station.description, forKey: .station)
        try container.encode(stationName, forKey: .stationName)
        try container.encode(monday, forKey: .monday)
        try container.encode(tuesday, forKey: .tuesday)
        try container.encode(wednesday, forKey: .wednesday)
        try container.encode(thursday, forKey: .thursday)
        try container.encode(friday, forKey: .friday)
        try container.encode(saturday, forKey: .saturday)
        try container.encode(sunday, forKey: .sunday)
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

    public init(
        openingTime: String,
        firstTrains: [TrainTime],
        lastTrains: [TrainTime]
    ) {
        self.openingTime = openingTime
        self.firstTrains = firstTrains
        self.lastTrains = lastTrains
    }
}

public struct TrainTime: Codable {
    public let time: String
    public let destination: Station

    enum CodingKeys: String, CodingKey {
        case time = "Time"
        case destination = "DestinationStation"
    }

    public init(time: String, destination: Station) {
        self.time = time
        self.destination = destination
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        time = try container.decode(String.self, forKey: .time)

        let destinationCode = try container.decode(String.self, forKey: .destination)

        guard let destination = Station(rawValue: destinationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.destination = destination
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(time, forKey: .time)
        try container.encode(destination, forKey: .destination)
    }
}

public struct StationToStationInfos: Codable {
    public let stationToStationInfos: [StationToStationInfo]

    enum CodingKeys: String, CodingKey {
        case stationToStationInfos = "StationToStationInfos"
    }

    public init(stationToStationInfos: [StationToStationInfo]) {
        self.stationToStationInfos = stationToStationInfos
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

    public init(
        compositeMiles: Double,
        destination: Station,
        railFare: RailFare,
        railTime: Int,
        source: Station
    ) {
        self.compositeMiles = compositeMiles
        self.destination = destination
        self.railFare = railFare
        self.railTime = railTime
        self.source = source
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        compositeMiles = try container.decode(Double.self, forKey: .compositeMiles)

        let destinationCode = try container.decode(String.self, forKey: .destination)

        guard let destination = Station(rawValue: destinationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.destination = destination
        railFare = try container.decode(RailFare.self, forKey: .railFare)
        railTime = try container.decode(Int.self, forKey: .railTime)

        let sourceCode = try container.decode(String.self, forKey: .source)

        guard let source = Station(rawValue: sourceCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.source = source
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(compositeMiles, forKey: .compositeMiles)
        try container.encode(destination.description, forKey: .destination)
        try container.encode(railFare, forKey: .railFare)
        try container.encode(railTime, forKey: .railTime)
        try container.encode(source.description, forKey: .source)
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

    public init(
        offPeakTime: Double,
        peakTime: Double,
        seniorDisabled: Double
    ) {
        self.offPeakTime = offPeakTime
        self.peakTime = peakTime
        self.seniorDisabled = seniorDisabled
    }
}

public struct ElevatorAndEscalatorIncidents: Codable {
    public let incidents: [ElevatorAndEscalatorIncident]

    enum CodingKeys: String, CodingKey {
        case incidents = "ElevatorIncidents"
    }

    public init(incidents: [ElevatorAndEscalatorIncident]) {
        self.incidents = incidents
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

    public init(
        unitName: String,
        unitType: String,
        unitStatus: String?,
        station: Station,
        stationName: String,
        locationDescription: String,
        symptomCode: String?,
        timeOutOfService: String,
        symptomDescription: String,
        displayOrder: Double,
        dateOutOfService: Date,
        dateUpdated: String,
        estimatedReturnToService: String
    ) {
        self.unitName = unitName
        self.unitType = unitType
        self.unitStatus = unitStatus
        self.station = station
        self.stationName = stationName
        self.locationDescription = locationDescription
        self.symptomCode = symptomCode
        self.timeOutOfService = timeOutOfService
        self.symptomDescription = symptomDescription
        self.displayOrder = displayOrder
        self.dateOutOfService = dateOutOfService
        self.dateUpdated = dateUpdated
        self.estimatedReturnToService = estimatedReturnToService
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        unitName = try container.decode(String.self, forKey: .unitName)
        unitType = try container.decode(String.self, forKey: .unitType)
        unitStatus = try container.decode(String?.self, forKey: .unitStatus)

        let stationCode = try container.decode(String.self, forKey: .station)

        guard let station = Station(rawValue: stationCode) else {
            throw WMATAError(statusCode: 0, message: "Station provided by API was not valid")
        }

        self.station = station
        stationName = try container.decode(String.self, forKey: .stationName)
        locationDescription = try container.decode(String.self, forKey: .locationDescription)
        symptomCode = try container.decode(String?.self, forKey: .symptomCode)
        timeOutOfService = try container.decode(String.self, forKey: .timeOutOfService)
        symptomDescription = try container.decode(String.self, forKey: .symptomDescription)
        displayOrder = try container.decode(Double.self, forKey: .displayOrder)
        dateOutOfService = try (try container.decode(String.self, forKey: .dateOutOfService)).toWMATADate()
        dateUpdated = try container.decode(String.self, forKey: .dateUpdated)
        estimatedReturnToService = try container.decode(String.self, forKey: .estimatedReturnToService)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(unitName, forKey: .unitName)
        try container.encode(unitType, forKey: .unitType)
        try container.encode(unitStatus, forKey: .unitStatus)
        try container.encode(station.description, forKey: .station)
        try container.encode(stationName, forKey: .stationName)
        try container.encode(locationDescription, forKey: .locationDescription)
        try container.encode(symptomCode, forKey: .symptomCode)
        try container.encode(timeOutOfService, forKey: .timeOutOfService)
        try container.encode(symptomDescription, forKey: .symptomDescription)
        try container.encode(displayOrder, forKey: .displayOrder)
        try container.encode(dateOutOfService.toWMATAString(), forKey: .dateOutOfService)
        try container.encode(dateUpdated, forKey: .dateUpdated)
        try container.encode(estimatedReturnToService, forKey: .estimatedReturnToService)
    }
}

public struct RailIncidents: Codable {
    public let incidents: [RailIncident]

    enum CodingKeys: String, CodingKey {
        case incidents = "Incidents"
    }

    public init(incidents: [RailIncident]) {
        self.incidents = incidents
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

    public init(
        incidentID: String,
        description: String,
        startLocationFullName: String?,
        endLocationFullName: String?,
        passengerDelay: Double,
        delaySeverity: String?,
        incidentType: String,
        emergencyText: String?,
        linesAffected: String,
        dateUpdated: Date
    ) {
        self.incidentID = incidentID
        self.description = description
        self.startLocationFullName = startLocationFullName
        self.endLocationFullName = endLocationFullName
        self.passengerDelay = passengerDelay
        self.delaySeverity = delaySeverity
        self.incidentType = incidentType
        self.emergencyText = emergencyText
        self.linesAffected = linesAffected
        self.dateUpdated = dateUpdated
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        incidentID = try container.decode(String.self, forKey: .incidentID)
        description = try container.decode(String.self, forKey: .description)
        startLocationFullName = try container.decode(String?.self, forKey: .startLocationFullName)
        endLocationFullName = try container.decode(String?.self, forKey: .endLocationFullName)
        passengerDelay = try container.decode(Double.self, forKey: .passengerDelay)
        delaySeverity = try container.decode(String?.self, forKey: .delaySeverity)
        incidentType = try container.decode(String.self, forKey: .incidentType)
        emergencyText = try container.decode(String?.self, forKey: .emergencyText)
        linesAffected = try container.decode(String.self, forKey: .linesAffected)
        dateUpdated = try (try container.decode(String.self, forKey: .dateUpdated)).toWMATADate()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(incidentID, forKey: .incidentID)
        try container.encode(description, forKey: .description)
        try container.encode(startLocationFullName, forKey: .startLocationFullName)
        try container.encode(endLocationFullName, forKey: .endLocationFullName)
        try container.encode(passengerDelay, forKey: .passengerDelay)
        try container.encode(delaySeverity, forKey: .delaySeverity)
        try container.encode(incidentType, forKey: .incidentType)
        try container.encode(emergencyText, forKey: .emergencyText)
        try container.encode(linesAffected, forKey: .linesAffected)
        try container.encode(dateUpdated.toWMATAString(), forKey: .dateUpdated)
    }
}
