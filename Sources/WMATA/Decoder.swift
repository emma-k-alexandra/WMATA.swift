//
//  Deserialize.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

/// A custom JSON decoder for Standard API responses.
///
/// This decoder uses a custom key and date decoding strategy for handling responses from the WMATA API.
///
/// For usage in your own decoding see <doc:AdvancedDecoding>.
open class WMATAJSONDecoder: JSONDecoder {
    override public init() {
        super.init()
        keyDecodingStrategy = .convertFromWMATA
        dateDecodingStrategy = .formatted(.wmataFormat)
    }
}

public extension JSONDecoder.KeyDecodingStrategy {
    /// Decodes keys in responses from the WMATA Standard API.
    ///
    /// This strategy decodes certain keys into completely separate keys defined in endpoint responses. This includes renaming and mapping certain values to `nil`. In all cases, this stategy will decode pascal case keys into camel case keys appropriate for Swift APIs.
    static var convertFromWMATA: JSONDecoder.KeyDecodingStrategy {
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
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        .custom { codingPath in
            PascalCaseKey(stringValue: codingPath.last!.stringValue)
        }
    }
}

struct PascalCaseKey: CodingKey, Equatable, Hashable {
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
struct WMATACodingKey: CodingKey, Equatable, Hashable {
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

extension String {
    func lowercasedFirstLetter() -> String {
        var stringCopy = self
        
        let firstCharacter = stringCopy.removeFirst()
        
        return firstCharacter.lowercased() + stringCopy
    }
}

public extension DateFormatter {
    /// Formats dates returned in a response from the WMATA Standard API.
    ///
    /// Dates from WMATA's API are _nearly_ ISO-8601, but not quite. They're missing a timezone incidator, which is non-standard. This formatter assumes EST, which is what WMATA states all of their dates are formatted in.
    ///
    /// > Note: If you're having issues with dates coming from the API, check to confirm the timezone is correct. This formatter assumes EST, but I've been burned by the API enough times to not trust WMATA's claim that these dates are always EST.
    static var wmataFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!
        
        return formatter
    }
}


/// A propery wrapper for mapping certain values in Standard API responses to `nil`.
///
/// > Note: You will only need to use this structure when performing advanced custom decoding.
///
/// This wrapper is used internally to convert non-`nil` junk values in responses to `nil`. If you are defining your own custom decoding, this may come in handy. You'll need to define a ``WMATAMappedValues`` to map values to `nil`. This wrapper is `Codable` and will simply encode and decode to your `Wrapped` value when passed to an encoder or decoder.
///
/// You can see this proper wrapper used in ``Rail/StationInformation/Response/firstStationTogether`` where an empty string in WMATA's response is converted to `nil`.
///
/// ```swift
/// @MapToNil<Station, EmptyString> public var firstStationTogether: Station?
/// ```
///
@propertyWrapper
public struct MapToNil<Wrapped, MappedValues>: Codable, Equatable, Hashable
where
    Wrapped: Codable & Equatable & Hashable,
    MappedValues: WMATAMappedValues
{
    /// The value you wish to
    public var wrappedValue: Wrapped?
    
    /// Create this propery wrapper.
    ///
    /// Example usage:
    ///```swift
    /// @MapToNil<Station, EmptyString> public var firstStationTogether: Station?
    /// ```
    public init(wrappedValue: Wrapped?) {
        self.wrappedValue = wrappedValue
    }
    
    /// Decode the `Wrapped` value to itself or `nil`.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            wrappedValue = nil
            return
        }
        
        let stringValue = try container.decode(String.self)
        
        if MappedValues.allValues.contains(stringValue) {
            wrappedValue = nil
        } else {
            wrappedValue = try container.decode(Wrapped.self)
        }
    }
    
    /// Encode the `Wrapped` value.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(wrappedValue)
    }
}

/// Values to map to `nil` when using ``MapToNil``.
///
/// When decoding a values, values in ``allValues`` will be mapped to `nil`.
///
/// These values must be defined at a static level like this to allow for initialization via `Decodable`.
public protocol WMATAMappedValues: Hashable {
    
    /// Values to map to `nil`.
    static var allValues: [String] { get }
}

/// Map an empty string to `nil`.
public struct EmptyString: WMATAMappedValues, Equatable, Hashable {
    public static let allValues = [""]
}

/// Map the values `"--"` and `"No"` to `nil`.
public struct DashesAndNo: WMATAMappedValues, Equatable, Hashable {
    public static let allValues = ["--", "No"]
}

/// Map the value `"-"` to `nil`.
public struct SingleDash: WMATAMappedValues, Equatable, Hashable {
    public static let allValues = ["-"]
}

/// Map the value `"0"` to `nil`.
public struct SingleZero: WMATAMappedValues, Equatable, Hashable {
    public static let allValues = ["0"]
}
