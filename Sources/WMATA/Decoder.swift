//
//  Deserialize.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

public class WMATAJSONDecoder: JSONDecoder {
    override public init() {
        super.init()
        keyDecodingStrategy = .convertFromWMATA
        dateDecodingStrategy = .formatted(.wmataFormat)
    }
}

public extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromWMATA: Self {
        .custom { codingPath in
            let relevantKey = codingPath.last!
            
            guard relevantKey.intValue == nil else {
                return relevantKey
            }
            
            if let wmataKey = WMATACodingKey(stringValue: relevantKey.stringValue) {
                return wmataKey
            } else {
                let pascalCaseKey = PascalCaseKey(stringValue: relevantKey.stringValue)
                return pascalCaseKey
            }
        }
    }
}

extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: Self {
        .custom { codingPath in
            PascalCaseKey(stringValue: codingPath.last!.stringValue)
        }
    }
}

struct PascalCaseKey: CodingKey {
    var stringValue: String
    
    init(stringValue: String) {
        self.stringValue = stringValue.lowercasedFirstLetter()
    }
    
    var intValue: Int?
    
    init(intValue: Int) {
        self.intValue = intValue
        
        stringValue = "Index \(intValue)"
    }
}

/// Keys that map to objects relevant within WMATA.swift
/// Examples: Route, Line, Station
///
/// or expansions of keys that WMATA has shortened in their API
/// in order to follow Swift's [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
/// Example: DirectionNum, DirectionOne
struct WMATACodingKey: CodingKey {
    private static let WMATA_CODING_KEYS = [
        "RouteID": "route",
        "StopID": "stop",
        "DirectionNum": "directionNumber",
        "Lat": "latitude",
        "Lon": "longitude",
        "Direction0": "directionZero",
        "Direction1": "directionOne",
        "SeqNum": "sequenceNumber",
        "StopSeq": "stopSequence",
        "LocationCode": "location",
        "Min": "minutes",
        "TrainId": "trainID",
        "CircuitId": "circuitID",
        "TrackNum": "trackNumber",
        "LineCode": "line",
        "StationCode": "station",
        "Code": "station",
        "CircuitIds": "circuitIDs",
        "StartStationCode": "startStation",
        "EndStationCode": "endStation",
        "InternalDestination1": "firstInternalDestination",
        "InternalDestination2": "secondInternalDestination",
        "DistanceToPrev": "distanceToPreviousStation",
        "StationCode1": "firstStation",
        "StationCode2": "secondStation",
        "ID": "id",
        "LineCode1": "firstLine",
        "LineCode2": "secondLine",
        "LineCode3": "thirdLine",
        "LineCode4": "fourthLine",
        "StationTogether1": "firstStationTogether",
        "StationTogether2": "secondStationTogether",
        "DestinationStation": "destination",
        "SourceStation": "source",
        "ElevatorIncidents": "incidents",
        "DateOutOfServ": "dateOutOfService",
        "Destination": "destinationShortName"
    ]
    
    var stringValue: String
    
    init?(stringValue: String) {
        guard let wmataKey = Self.WMATA_CODING_KEYS[stringValue] else {
            return nil
        }
        
        self.stringValue = wmataKey
    }
    
    var intValue: Int?
    
    init(intValue: Int) {
        self.intValue = intValue
        
        stringValue = "Index \(intValue)"
    }
}

internal extension String {
    func lowercasedFirstLetter() -> String {
        var stringCopy = self
        
        let firstCharacter = stringCopy.removeFirst()
        
        return firstCharacter.lowercased() + stringCopy
    }
}

internal extension DateFormatter {
    static var wmataFormat: Self {
        let formatter = Self()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!
        
        return formatter
    }
}


@propertyWrapper
public struct MapToNil<Wrapped, MappedValue>: Codable
    where
        Wrapped: Codable & RawRepresentable,
        Wrapped.RawValue == String,
        MappedValue: WMATAMappedValue
    {
    public var wrappedValue: Wrapped?
    
    public init(wrappedValue: Wrapped?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String?.self)
        
        guard let stringValue = stringValue, stringValue != MappedValue.value else {
            wrappedValue = nil
            return
        }
        
        wrappedValue = Wrapped(rawValue: stringValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(wrappedValue)
    }
}

public protocol WMATAMappedValue {
    static var value: String { get }
}

public struct EmptyString: WMATAMappedValue {
    public static let value = ""
}

public struct Dashes: WMATAMappedValue {
    public static let value = "--"
}

public struct SingleDash: WMATAMappedValue {
    public static let value = "-"
}
