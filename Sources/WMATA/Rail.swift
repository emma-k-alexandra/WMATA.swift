//
//  Rail.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import GTFS

/// MetroRail endpoints
///
/// The various endpoints defined here allow you to call MetroRail APIs. For an overview see <doc:Endpoints>
///
/// > Tip: You can use endpoints here like so: `Rail.Lines(...)`
public enum Rail {
    /// MetroRail GTFS endpoints
    public enum GTFS {}
}

public extension Rail {
    /// All MetroRail ``Line``s
    ///
    /// [WMATA Lines Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
    struct Lines: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jLines")
        
        public let key: APIKey
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            []
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// Information for all lines
            public let lines: [Line]

            /// Create lines response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - lines: List of lines
            public init(lines: [Line]) {
                self.lines = lines
            }
            
            /// Information about a single ``WMATA/Line``.
            public struct Line: Codable, Equatable, Hashable {
                /// The actual line
                public let line: WMATA.Line
                
                /// Full name of the Line.
                public let displayName: String
                
                /// Station for start of the Line.
                public let startStation: Station
                
                /// Station for end of the Line
                public let endStation: Station
                
                /// Intermediate terminal station.
                ///
                /// During normal service, some trains on some lines might end their trip prior to the ``startStation`` or ``endStation``. A good example is on the Red Line where some trains stop at ``Station/grosvenor`` or ``Station/silverSpring``.
                @MapToNil<Station, EmptyString> public var firstInternalDestination: Station?
                
                /// Intermediate terminal station.
                ///
                /// See ``firstInternalDestination``
                @MapToNil<Station, EmptyString> public var secondInternalDestination: Station?

                /// Create a line response
                ///
                /// - Parameters:
                ///     - line: Line code
                ///     - displayName: Name of line
                ///     - startStation: Station at start of Line
                ///     - endStation: Station at end of Line
                ///     - firstInternalDestination: Intermediate terminal station
                ///     - secondInternalDestination: Intermediate terminal station
                public init(
                    line: WMATA.Line,
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
            }
        }
    }
    
    /// All station entrances within a ``WMATALocation``
    ///
    /// Omit `location` to receive all station entrances.
    ///
    ///  [WMATA Station Entrances Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f)
    struct StationEntrances: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationEntrances")
        
        public let key: APIKey
        
        /// A location to search for entrances within. Omit to receive all station entrances
        public var location: WMATALocation? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            location?.queryItems() ?? []
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of station entrances
            public let entrances: [Entrance]

            /// Create a station entrances response, for debugging and testing.
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - entrances: List of station entrances
            public init(entrances: [Entrance]) {
                self.entrances = entrances
            }
            
            /// A station entrance
            public struct Entrance: Codable, Equatable, Hashable {
                /// Additional information for the entrance.
                public let description: String
                
                /// > Warning: Deprecated.
                public let id: String
                
                /// Latitude of station entrance.
                public let latitude: Double
                
                /// Longitude of station entrance.
                public let longitude: Double
                
                /// Name of entrance.
                public let name: String
                
                /// First station for this entrance
                public let firstStation: Station
                
                /// Second station for this entrance.
                ///
                /// Populated for multilevel stations like L'Enfant Plaza, Metro Center, otherwise `nil`
                @MapToNil<Station, EmptyString> public var secondStation: Station?

                /// Create a station entrance response
                ///
                /// - Parameters:
                ///     - description: Additional entrance information
                ///     - id: Deprecated.
                ///     - latitude: Latitude of entrance
                ///     - longitude: Longitude of entrance
                ///     - name: Name of entrance
                ///     - firstStation: First station of this entrance
                ///     - secondStation: Second station of this entrance. i.e. L'Enfant Plaza
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
            }
        }
    }

    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// Refreshes every 7-10 seconds
    ///
    /// Information provided by this endpoint can be used with data from ``Rail/StandardRoutes`` and ``Rail/TrackCircuits``
    ///
    /// [Additional Details](https://developer.wmata.com/TrainPositionsFAQ)
    ///
    /// [WMATA Live Train Positions Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
    struct TrainPositions: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrainPositions")
        
        public let key: APIKey
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [URLQueryItem(name: "contentType", value: "json")]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// All train positions
            public let trainPositions: [Positions]

            /// Create a train positions response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - trainPositions: List of train positions
            public init(trainPositions: [Positions]) {
                self.trainPositions = trainPositions
            }
            
            /// A train position
            public struct Positions: Codable, Equatable, Hashable {
                /// Uniquely identifiable internal train identifier
                public let trainID: String
                
                /// Non-unique train identifier
                ///
                /// Used by WMATA's Rail Scheduling and Operations Teams, as well as over open radio communication.
                public let trainNumber: String
                
                /// Number of cars. Can be `0`.
                public let carCount: Int
                
                /// The direction of movement regardless of which track the train is on.
                public let directionNumber: Int
                
                /// The circuit identifier the train is currently on.
                public let circuitID: Int
                
                /// Destination of train
                ///
                /// > Warning: Can sometimes differ from destinations from ``Rail/NextTrains``
                public let destination: Station?
                
                /// Line the train is on
                public let line: Line?
                
                /// Approximate "dwell time".
                ///
                /// This is not an exact value, but can be used to determine how long a train has been reported at the same track circuit.
                public let secondsAtLocation: Int
                
                /// Service type of a train
                ///
                /// Can be used to determine if a train will have a ``Line`` or destination ``Station``
                public enum ServiceType: String, Codable {
                    /// This is a non-revenue train with no passengers on board.
                    ///
                    /// > Note: Tthis designation of NoPassengers does not necessarily correlate with PIDS "No Passengers".
                    case noPassengers = "NoPassengers"
                    
                    /// This is a normal revenue service train.
                    case normal = "Normal"
                    
                    /// Special revenue service train with an unspecified line and destination.
                    ///
                    /// This is more prevalent during scheduled track work.
                    case special = "Special"
                    
                    /// Cases with unknown data or work vehicles.
                    case unknown = "Unknown"
                }
                
                /// Service Type of a train.
                public let serviceType: ServiceType

                /// Create a train position response
                ///
                /// - Parameters:
                ///     - trainID: Unique train identifier
                ///     - trainNumber: Non-unique train identifier
                ///     - carCount: Number of cars on train
                ///     - directionNumber: Direction of movement
                ///     - circuitID: Circuit identifier train is currently on
                ///     - destination: Destination of train
                ///     - line: Line the train is currently on
                ///     - secondsAtLocation: Dwell time
                ///     - serviceType: Type of service of train
                public init(
                    trainID: String,
                    trainNumber: String,
                    carCount: Int,
                    directionNumber: Int,
                    circuitID: Int,
                    destination: Station?,
                    line: Line?,
                    secondsAtLocation: Int,
                    serviceType: ServiceType
                ) {
                    self.trainID = trainID
                    self.trainNumber = trainNumber
                    self.carCount = carCount
                    self.directionNumber = directionNumber
                    self.circuitID = circuitID
                    self.destination = destination
                    self.line = line
                    self.secondsAtLocation = secondsAtLocation
                    self.serviceType = serviceType
                }
            }
        }
    }
    
    /// An ordered list of mostly revenue (and some lead) track circuits, arranged by line and track number.
    ///
    /// This data does not change frequently and should be cached for a reasonable amount of time.
    ///
    /// Information provided by this endpoint can be used with data from ``Rail/TrainPositions`` and ``Rail/TrackCircuits``
    ///
    /// > Note: This endpoint can return data for the ``Line/YLRP`` line, which is not currently used by WMATA.
    ///
    /// [Additional Details](https://developer.wmata.com/TrainPositionsFAQ)
    ///
    ///  [WMATA Standard Routes Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
    struct StandardRoutes: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/StandardRoutes")
        
        public let key: APIKey
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [URLQueryItem(name: "contentType", value: "json")]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// All standard routes
            public let standardRoutes: [StandardRoute]

            /// Create a standard routes response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - standardRoutes: List of standard routes
            public init(standardRoutes: [StandardRoute]) {
                self.standardRoutes = standardRoutes
            }
            
            /// A MetroRail route
            public struct StandardRoute: Codable, Equatable, Hashable {
                /// Line of this route
                public let line: Line
                
                /// The number of this track
                public enum TrackNumber: Int, Codable {
                    case one = 1
                    case two = 2
                }
                
                /// Track number
                public let trackNumber: TrackNumber
                
                /// Array containing ordered track circuit information
                public let trackCircuits: [TrackCircuit]

                /// Create a standard route response
                ///
                /// - Parameters:
                ///     - line: Line of route
                ///     - trackNumber: Track the route is on
                ///     - trackCiruits: Ordered track circuit information
                public init(
                    line: Line,
                    trackNumber: TrackNumber,
                    trackCircuits: [TrackCircuit]
                ) {
                    self.line = line
                    self.trackNumber = trackNumber
                    self.trackCircuits = trackCircuits
                }
                
                /// Circuit information
                public struct TrackCircuit: Codable, Equatable, Hashable {
                    /// Order in which the circuit appears for the given line and track.
                    ///
                    /// Sequences go from West to East and South to North.
                    public let sequenceNumber: Int
                    
                    /// An internal system-wide uniquely identifiable circuit number.
                    ///
                    /// You can correlate these circuit IDs with data from ``Rail/TrackCircuits`` and ``Rail/TrainPositions``
                    public let circuitID: Int
                    
                    /// Station this circuit is at, if it is at a station
                    public let station: Station?

                    /// Create a track circuit with station response
                    ///
                    /// - Parameters:
                    ///     - sequenceNumber: Order the ciruit appears in
                    ///     - circuitId: Unique circuit ID
                    ///     - station: Station the circuit is at, if it's at one
                    public init(
                        sequenceNumber: Int,
                        circuitID: Int,
                        station: Station?
                    ) {
                        self.sequenceNumber = sequenceNumber
                        self.circuitID = circuitID
                        self.station = station
                    }
                }
            }
        }
    }
    
    /// Uniquely identifiable trains in service and what track circuits they currently occupy
    ///
    /// Refreshes every 7-10 seconds
    ///
    /// Information provided by this endpoint can be used with data from ``Rail/TrainPositions`` and ``Rail/StandardRoutes``
    ///
    /// [Additional Details](https://developer.wmata.com/TrainPositionsFAQ)
    ///
    /// [WMATA Track Circuits Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
    struct TrackCircuits: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrackCircuits")
        
        public let key: APIKey
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [URLQueryItem(name: "contentType", value: "json")]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of track ciruits
            public let trackCircuits: [TrackCircuit]

            /// Create a track circuits response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - trackCircuits: List of track circuits
            public init(trackCircuits: [TrackCircuit]) {
                self.trackCircuits = trackCircuits
            }
            
            /// A MetroRail track circuit
            public struct TrackCircuit: Codable, Equatable, Hashable {
                /// The type of a track
                ///
                /// ![A neighboring track diagram](track-neighbors)
                ///
                /// For the JSON of this example, see the [WMATA Track Circuit Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
                public enum Track: Int, Codable {
                    /// A "main" track
                    case main1 = 1
                    
                    /// A "main"
                    case main2 = 2
                    
                    /// A connector between two tracks
                    case connector = 0
                    
                    /// A track off the main tracks that allows for parking or short-turning
                    case pocket = 3
                }
                
                /// The type of this track
                public let track: Track
                
                /// An internal system-wide uniquely identifiable circuit number.
                ///
                /// You can correlate these circuit IDs with data from ``Rail/TrackCircuits`` and ``Rail/TrainPositions``
                public let circuitID: Int
                
                /// Array containing track circuit neighbor information. Note that some track circuits have no neighbors in one direction. All track circuits have at least one neighbor.
                public let neighbors: [TrackNeighbor]

                /// Create a track circuit response
                ///
                /// - Parameters:
                ///     - track: Track number
                ///     - circuitId: Unique circuit id
                ///     - neighbors: Track circuit neighbors
                public init(
                    track: Track,
                    circuitID: Int,
                    neighbors: [TrackNeighbor]
                ) {
                    self.track = track
                    self.circuitID = circuitID
                    self.neighbors = neighbors
                }
                
                /// A MetroRail track neighbor
                ///
                /// ![A neighboring track diagram](track-neighbors)
                ///
                /// For the JSON of this example, see the [WMATA Track Circuit Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
                public struct TrackNeighbor: Codable, Equatable, Hashable {
                    /// The type of a neighboring track
                    ///
                    /// Generally speaking, left neighbors are to the west and south, while right neighbors are to the east/north.
                    public enum NeighborType: String, Codable {
                        /// Left neighbor, usually to the West or South
                        case left = "Left"
                        
                        /// Right neighbor, usually to the East or North
                        case right = "Right"
                    }
                    
                    /// The type of neighbor this is
                    public let neighborType: NeighborType
                    
                    /// Neighboring circuit ids.
                    ///
                    /// You can correlate these circuit IDs with data from ``Rail/TrackCircuits`` and ``Rail/TrainPositions``
                    public let circuitIDs: [Int]

                    /// Create a track neighbor response
                    ///
                    /// - Parameters:
                    ///     - neighborType: Left or Right neighbor group
                    ///     - circuitIds: Neighboring circuits
                    public init(
                        neighborType: NeighborType,
                        circuitIDs: [Int]
                    ) {
                        self.neighborType = neighborType
                        self.circuitIDs = circuitIDs
                    }
                }
            }
        }
    }
    
    /// Distance, fare information, and estimated travel time between any two stations, including those on different lines.
    ///
    /// Omit `station` and `destinationStation` to receive data for all trips
    ///
    ///[WMATA Station to Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
    struct StationToStation: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo")
        
        public let key: APIKey
        
        /// The starting station of a trip
        public var station: Station? = nil
        
        /// The destination station of a trip
        public var destinationStation: Station? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [
                station?.queryItem(name: .from),
                destinationStation?.queryItem(name: .to)
            ]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of trips
            public let stationToStationInfos: [Trip]

            /// Create a station to station info response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - stationToStationInfos: List of station to station information
            public init(stationToStationInfos: [Trip]) {
                self.stationToStationInfos = stationToStationInfos
            }
            
            /// A trip between two stations
            public struct Trip: Codable, Equatable, Hashable {
                /// Average of distance traveled between two stations and straight-line distance (as used for WMATA fare calculations).
                public let compositeMiles: Double
                
                /// Destination station
                public let destination: Station
                
                /// Fare information
                public let railFare: Fare
                
                /// Estimated travel time (schedule time) in minutes between the source and destination station.
                ///
                /// This is not correlated to minutes (Min) in Real-Time Rail Predictions.
                public let railTime: Int
                
                /// Origin station
                public let source: Station

                /// Create a Trip response
                ///
                /// - Parameters:
                ///     - compositeMiles: Average distance travelled between two stations
                ///     - destination: Destination station
                ///     - railFare: Fare information
                ///     - railTime: Estimated travel time in minuites
                ///     - source: Origin station
                public init(
                    compositeMiles: Double,
                    destination: Station,
                    railFare: Fare,
                    railTime: Int,
                    source: Station
                ) {
                    self.compositeMiles = compositeMiles
                    self.destination = destination
                    self.railFare = railFare
                    self.railTime = railTime
                    self.source = source
                }
                
                /// Trip fare information
                public struct Fare: Codable, Equatable, Hashable {
                    /// Fare during off-peak times.
                    public let offPeakTime: Double
                    
                    /// Fare during peak times (weekdays from opening to 9:30 AM and 3-7 PM, and weekends from midnight to closing).
                    // TODO: Create `isPeakTime` function
                    public let peakTime: Double
                    
                    /// Reduced fare for senior citizens or people with disabilities.
                    public let seniorDisabled: Double

                    /// Create a trip fare response
                    ///
                    /// - Parameters:
                    ///     - offPeakTime: Off-peak fare
                    ///     - peakTime: Peak fare
                    ///     - seniorDisabled: Reduced fare
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
            }
        }
    }
    
    /// Reported elevator and escalator outages at a given station
    ///
    /// Omit `station` to receive all incidents
    ///
    /// [WMATA Elevator and Escalator Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76)
    struct ElevatorAndEscalatorIncidents: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/ElevatorIncidents")
        
        public let key: APIKey
        
        /// Station to receive incidents for. Omit for all stations
        public var station: Station? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// All elevator and escalator incidents
            public let incidents: [Incident]

            /// Create an elevator and escalator incidents response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - incidents: List of elevator and escalator incidents
            public init(incidents: [Incident]) {
                self.incidents = incidents
            }
            
            /// An elevator or escalator incident
            public struct Incident: Codable, Equatable, Hashable {
                /// Unique identifier for unit, by type (a single elevator and escalator may have the same UnitName, but no two elevators or two escalators will have the same UnitName).
                public let unitName: String
                
                /// If an incident is for an elevator or escalator
                public enum ElevatorOrEscalator: String, Codable {
                    case elevator = "ELEVATOR"
                    case escalator = "ESCALATOR"
                }
                
                /// If this incident is for an elevator or escalator
                public let unitType: ElevatorOrEscalator
                
                /// If listed here, the unit is inoperational or otherwise impaired.
                ///
                /// >Warning: Deprecated.
                public let unitStatus: String?
                
                /// Station of the incident
                public let station: Station
                
                /// Full station name, may include entrance information (e.g.: Metro Center, G and 11th St Entrance).
                public let stationName: String
                
                /// Free-text description of the unit location within a station (e.g.: Escalator between mezzanine and platform).
                public let locationDescription: String
                
                /// Warning: Deprecated.
                public let symptomCode: String?
                
                /// Warning: Deprecated. Use the time portion of the DateOutOfServ element.
                public let timeOutOfService: String
                
                /// Description for why the unit is out of service or otherwise in reduced operation.
                public let symptomDescription: String
                
                /// Warning: Deprecated.
                public let displayOrder: Double
                
                /// Date and time (Eastern Standard Time) unit was reported out of service.
                public let dateOutOfService: Date
                
                /// Date and time (Eastern Standard Time) outage details was last updated.
                public let dateUpdated: Date
                
                /// Estimated date and time (Eastern Standard Time) by when unit is expected to return to normal service.
                public let estimatedReturnToService: Date

                /// Create a elevator and escalator incident response
                ///
                /// - Parameters:
                ///     - unitName: id for unit
                ///     - unitType: Type of unit. ELEVATOR or ESCALATOR
                ///     - unitStatus: Deprecated.
                ///     - station: Station of incident
                ///     - stationName: Full name of station, including entrance information
                ///     - locationDescription: Location of unit within station
                ///     - symptomCode: Deprecated.
                ///     - timeOutOfService: Deprecated.
                ///     - symptomDescription: Why the unit is out of service
                ///     - displayOrder: Deprecated.
                ///     - dateOutOfService: Time unit reported out of service
                ///     - dateUpdated: Time outage details were last updated
                ///     - estimatedReturnToService: Time unit is expected to return to normal service
                public init(
                    unitName: String,
                    unitType: ElevatorOrEscalator,
                    unitStatus: String?,
                    station: Station,
                    stationName: String,
                    locationDescription: String,
                    symptomCode: String?,
                    timeOutOfService: String,
                    symptomDescription: String,
                    displayOrder: Double,
                    dateOutOfService: Date,
                    dateUpdated: Date,
                    estimatedReturnToService: Date
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
            }
        }
    }
    
    /// Reported MetroRail incidents (significant disruptions and delays to normal service).
    ///
    /// The data is identical to [WMATA's Metrorail Service Status feed](http://www.metroalerts.info/rss.aspx?rs).
    ///
    /// Omit `station` to receive all incidents.
    ///
    /// Refreshed every 20-30 seconds
    ///
    /// [WMATA Rail Incidents Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77)
    struct Incidents: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/Incidents")
        
        public let key: APIKey
        
        /// Station to receive incidents for. Omit to receive all incidents.
        public var station: Station? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of rail incidents
            public let incidents: [Incident]

            /// Create a rail incidents response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - incidents: List of rail incidents
            public init(incidents: [Incident]) {
                self.incidents = incidents
            }
            
            /// A MetroRail incident
            public struct Incident: Codable, Equatable, Hashable {
                /// Unique identifier for an incident.
                public let incidentID: String
                
                /// Free-text description of the incident.
                public let description: String
                
                /// Warning: Deprecated.
                public let startLocationFullName: String?
                
                /// Warning: Deprecated.
                public let endLocationFullName: String?
                
                /// Warning: Deprecated.
                public let passengerDelay: Double
                
                /// Warning: Deprecated.
                public let delaySeverity: String?
                
                /// Free-text description of the incident type. Usually Delay or Alert but is subject to change at any time.
                public let incidentType: String
                
                /// Warning: Deprecated.
                public let emergencyText: String?
                
                /// The lines affected by this incident.
                ///
                /// To get the lines, use ``lines``.
                ///
                /// This struct is needed due to WMATA sending this data in this awful format: Semi-colon and space separated list of line codes (e.g.: "RD;" or "BL; OR;" or "BL; OR; RD;")
                public struct LinesAffected: Codable, Equatable, Hashable {
                    
                    /// The lines effected by an incident
                    public let lines: [Line]
                    
                    /// The original format coming from WMATA
                    private let stringOfLines: String
                    
                    public init(from decoder: Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        
                        let stringOfLines = try container.decode(String.self)
                        
                        self.stringOfLines = stringOfLines
                        self.lines = Self.decode(stringOfLines)
                    }
                    
                    /// Convert WMATA's awful string format to an array of lines
                    ///
                    /// Original format: Semi-colon and space separated list of line codes (e.g.: "RD;" or "BL; OR;" or "BL; OR; RD;") =(
                    private static func decode(_ lines: String) -> [Line] {
                        lines
                            .split(separator: ";")
                            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                            .filter { !$0.isEmpty }
                            .compactMap { Line(rawValue: $0) }
                    }
                    
                    public func encode(to encoder: Encoder) throws {
                        var container = encoder.singleValueContainer()
                        
                        try container.encode(stringOfLines)
                    }
                    
                    /// Create lines affected response
                    ///
                    /// - Parameters:
                    ///     lines: The lines affected by an incident
                    public init(lines: [Line]) {
                        self.lines = lines
                        self.stringOfLines = lines
                            .map { $0.rawValue }
                            .joined(separator: "; ")
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
                
                /// The lines affected by this incident
                public let linesAffected: LinesAffected
                
                /// Date and time (Eastern Standard Time) of last update.
                public let dateUpdated: Date

                /// Create a rail incident response
                ///
                /// - Parameters:
                ///     - incidentID: Unique ID for incident
                ///     - description: Description of incident
                ///     - startLocationFullName: Deprecated.
                ///     - endLocationFullName: Deprecated.
                ///     - passengerDelay: Deprecated.
                ///     - delaySeverity: Deprecated.
                ///     - incidentType: Type of incident
                ///     - emergencyText: Deprecated.
                ///     - linesAffected: The lines affected by this incident
                ///     - dateUpdated: TIme of last status update
                public init(
                    incidentID: String,
                    description: String,
                    startLocationFullName: String?,
                    endLocationFullName: String?,
                    passengerDelay: Double,
                    delaySeverity: String?,
                    incidentType: String,
                    emergencyText: String?,
                    linesAffected: LinesAffected,
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
            }
        }
    }
    
    /// Next train arrival information for one or more stations
    ///
    /// For terminal stations (e.g.: Greenbelt, Shady Grove, etc.), predictions may be displayed twice.
    ///
    /// Some stations have two platforms (e.g.: Gallery Place, Fort Totten, L'Enfant Plaza, and Metro Center). Use ``StationSet/galleryPlace`` and similar for these stations.
    ///
    /// For trains with no passengers, the `destinationName` will be `No Passenger`.
    ///
    /// Refreshes every 20-30 seconds
    ///
    /// [WMATA Next Trains Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
    struct NextTrains: JSONEndpoint {
        internal let baseURL = "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/"
        
        public var url: URLComponents {
            .init(string: baseURL + stations.urlPath())!
        }
        
        /// A set of multiple ``Station``s
        ///
        /// This struct allows you to pass many or all stations to ``Rail/NextTrains``.
        ///
        /// Example values:
        /// ```swift
        ///  .all // All stations
        ///  [.greenbelt, .federalCenterSW] // Multiple stations
        ///  .lenfantPlaza // Both L'Enfant Plaza platforms
        /// ```
        ///
        /// Avoid using single stations like ` [.waterfront]`, ``Rail/NextTrains/init(key:station:delegate:)`` is recommended instead. However, single value sets _are_ supported if your use case requires them.
        public struct StationSet: ExpressibleByArrayLiteral, Equatable, Hashable {
            let stations: [Station]
            let all: Bool
            
            /// Use this when you want to get the next trains at all stations in one API call
            public static let all: StationSet = .init(all: true)
            
            /// Both L'Enfant Plaza platforms
            public static let lenfantPlaza: StationSet = [.lenfantPlazaLower, .lenfantPlazaUpper]
            
            /// Both Metro Center platforms
            public static let metroCenter: StationSet = [.metroCenterLower, .metroCenterUpper]
            
            /// Both Fort Totten platforms
            public static let fortTotten: StationSet = [.fortTottenLower, .fortTottenUpper]
            
            /// Both Gallery Place platforms
            public static let galleryPlace: StationSet = [.galleryPlaceLower, .galleryPlaceUpper]
            
            public init(arrayLiteral elements: Station...) {
                stations = elements
                all = false
            }
            
            init(all: Bool) {
                stations = []
                self.all = all
            }
            
            public typealias ArrayLiteralElement = Station
            
            func urlPath() -> String {
                if all {
                    return "All"
                }
                
                return stations.map(\.rawValue).joined(separator: ",")
            }
        }
        
        public let key: APIKey
        
        /// Stations to get the next arriving trains for. Can be a single station.
        public let stations: StationSet
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            []
        }
        
        /// Create a Next Trains call for multiple or all stations
        ///
        /// - Parameters
        ///     - key: WMATA API Key for this request
        ///     - stations: The stations to get the next trains for
        ///     - delegate: Delegate to send background requests to
        public init(
            key: APIKey,
            stations: StationSet,
            delegate: JSONEndpointDelegate<Rail.NextTrains>? = nil
        ) {
            self.key = key
            self.stations = stations
            self.delegate = delegate
        }
        
        /// Create a Next Trains call for a single station
        ///
        /// - Parameters
        ///     - key: WMATA API Key for this request
        ///     - station: The station to get the next trains for
        ///     - delegate: Delegate to send background requests to
        public init(
            key: APIKey,
            station: Station,
            delegate: JSONEndpointDelegate<Rail.NextTrains>? = nil
        ) {
            self.key = key
            self.stations = [station]
            self.delegate = delegate
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of predictions
            public let trains: [Prediction]

            /// Create a rail predictions response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - trains: List of rail predictions
            public init(trains: [Prediction]) {
                self.trains = trains
            }
            
            ///
            public struct Prediction: Codable, Equatable, Hashable {
                /// The number of cars a train has
                public enum Cars: String, Codable {
                    /// Six cars
                    case six = "6"
                    
                    /// Eight cars
                    case eight = "8"
                    
                    public var intValue: Int {
                        switch self {
                        case .six:
                            return 6
                        case .eight:
                            return 8
                        }
                    }
                }
                
                /// Number of cars on a train
                @MapToNil<Cars, SingleDash> public var car: Cars?
                
                /// Abbreviated version of the final destination for a train.
                ///
                /// This is similar to what is displayed on the signs at stations.
                public let destinationShortName: String
                
                /// Destination station
                public let destination: Station?
                
                /// When `destinationCode` is populated, this is the full name of the destination station, as shown on the WMATA website.
                ///
                /// For trains with no passengers, will be `No Passenger`.
                public let destinationName: String
                
                /// Denotes the track this train is on, but does not necessarily equate to Track 1 or Track 2.
                ///
                /// With the exception of terminal stations, predictions at the same station with different Group values refer to trains on different tracks.
                public let group: String
                
                /// Line of the train
                 @MapToNil<Line, DashesAndNo> public var line: Line?
                
                /// The station the train is currently arriving at
                public let location: Station
                
                /// Full name of the station where the train is arriving.
                public let locationName: String
                
                /// The time until arrival. Matches signs within a MetroRail station
                ///
                /// Sometimes a number in ``minutes(_:)``, can also be ``arriving``, ``boarding`` or ``unknown``.
                public enum Minutes: Codable, Equatable, Hashable {
                    /// Time to arrival in minutes
                    case minutes(Int)
                    
                    /// The train is currently arriving at a station
                    case arriving
                    
                    /// The train is currently boarding passengers at a station
                    case boarding
                    
                    /// The arrival time is unknown.
                    ///
                    /// Typically, the train is delayed or is at a terminal station.
                    case unknown
                    
                    public init(from decoder: Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        
                        let arrivalTime = try container.decode(String.self)
                        
                        switch arrivalTime {
                        case "", "---":
                            self = .unknown
                        case "ARR":
                            self = .arriving
                        case "BRD":
                            self = .boarding
                        default:
                            guard let minutes = Int(arrivalTime) else {
                                throw DecodingError.valueNotFound(
                                    Int.self,
                                    .init(
                                        codingPath: decoder.codingPath,
                                        debugDescription: "Attempted to decode arrival time in minutes, but was unable to convert \(arrivalTime) to Int"
                                    )
                                )
                            }
                            
                            self = .minutes(minutes)
                        }
                    }
                    
                    public func encode(to encoder: Encoder) throws {
                        var container = encoder.singleValueContainer()
                        
                        switch self {
                        case let .minutes(minutes):
                            try container.encode(String(minutes))
                        case .arriving:
                            try container.encode("ARR")
                        case .boarding:
                            try container.encode("BRD")
                        case .unknown:
                            try container.encode("")
                        }
                    }
                }
                
                /// Time until arrival, not neccesarily in minutes
                public let minutes: Minutes

                /// Create a rail prediction response
                ///
                /// - Parameters:
                ///     - car: Number of train cars
                ///     - destination: Abbreviated version of destination
                ///     - destinationCode: Destination station
                ///     - destinationName: Full name of destination
                ///     - group: Track the train is on
                ///     - line: Line of train
                ///     - location: Station the train is currently arriving at
                ///     - locationName: Full name of station the train is currently arriving at
                ///     - minutes: Minutes until arrival
                public init(
                    car: Cars?,
                    destinationShortName: String,
                    destination: Station?,
                    destinationName: String,
                    group: String,
                    line: Line,
                    location: Station,
                    locationName: String,
                    minutes: Minutes
                ) {
                    self.car = car
                    self.destinationShortName = destinationShortName
                    self.destination = destination
                    self.destinationName = destinationName
                    self.group = group
                    self.line = line
                    self.location = location
                    self.locationName = locationName
                    self.minutes = minutes
                }
            }
        }
    }
    
    /// Station location and address information
    ///
    /// [WMATA Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
    struct StationInformation: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationInfo")
        
        public let key: APIKey
        
        /// Station to get information about
        public let station: Station
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// The station's address
            public let address: Address
            
            /// The given station
            public let station: Station
            
            /// Latitude of this station.
            public let latitude: Double
            
            /// Longitude of this station.
            public let longitude: Double
            
            /// First line served by this station
            public let firstLine: Line
            
            /// Second line served by this station
            public let secondLine: Line?
            
            /// Third line served by this station
            public let thirdLine: Line?
            
            /// Fourth line served by this station. Unused.
            public let fourthLine: Line?
            
            /// Name of this station
            public let name: String
            
            /// For stations with multiple platforms (e.g.: Gallery Place, Fort Totten, L'Enfant Plaza, and Metro Center), the additional station will be listed here.
            @MapToNil<Station, EmptyString> public var firstStationTogether: Station?
            
            /// Unused.
            @MapToNil<Station, EmptyString> public var secondStationTogether: Station?

            /// Create a station information response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - address: Address information
            ///     - station: Station code
            ///     - latitude: Latitude of this station
            ///     - longitude: Longitude of this station
            ///     - firstLine: First line of this station
            ///     - secondLine: Second line of this station
            ///     - thirdLine: Third line of this station
            ///     - fourthLine: Fourth line of this station. Unused.
            ///     - name: Name of station
            ///     - firstStationTogether: Additional station for multilevel stations like Fort Totten
            ///     - secondStationTogether: Unused
            public init(
                address: Address,
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
            
            /// Address of a station
            public struct Address: Codable, Equatable, Hashable {
                /// City of this station.
                public let city: String
                
                /// State of this station.
                public let state: String
                
                /// Street address (for GPS use) of this station.
                public let street: String
                
                /// Zip code of this station.
                public let zip: String

                /// Create station address response
                ///
                /// - Parameters:
                ///     - city: City of this station
                ///     - state: State of this station
                ///     - street: Stress address of this station
                ///     - zip: Zip code of this station
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
        }
    }
    
    /// Parking information for a station
    ///
    /// Omit `station` to receive parking information for all stations.
    ///
    /// [WMATA Parking Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
    struct ParkingInformation: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationParking")
        
        public let key: APIKey
        
        /// Station to receive parking information for
        public var station: Station? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// All parking information. Will contain zero elements if a station has no parking.
            public let stationsParking: [Parking]

            /// Create stations parking response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - stationsParking: List of parking information
            public init(stationsParking: [Parking]) {
                self.stationsParking = stationsParking
            }
            
            /// Parking information for a station
            public struct Parking: Codable, Equatable, Hashable {
                /// Station this parking info is for
                public let station: Station
                
                /// Additional parking resources such as nearby lots.
                public let notes: String?
                
                /// All-day parking options.
                public let allDayParking: AllDay
                
                /// Short-term parking options.
                public let shortTermParking: ShortTerm

                /// Create a station parking response
                ///
                /// - Parameters:
                ///     - station: Station for this parking info
                ///     - notes: Additional parking information
                ///     - allDayParking: All-day parking options
                ///     - shortTermParking: Short term parking options
                public init(
                    station: Station,
                    notes: String?,
                    allDayParking: AllDay,
                    shortTermParking: ShortTerm
                ) {
                    self.station = station
                    self.notes = notes
                    self.allDayParking = allDayParking
                    self.shortTermParking = shortTermParking
                }
                
                /// All day parking options
                public struct AllDay: Codable, Equatable, Hashable {
                    /// Number of all-day parking spots available at a station.
                    public let totalCount: Int
                    
                    /// All-day cost per day (weekday) for Metro riders.
                    public let riderCost: Double
                    
                    /// All-day cost per day (weekday) for non-Metro riders.
                    public let nonRiderCost: Double
                    
                    /// Similar to RiderCost, except denoting Saturday prices.
                    public let saturdayRiderCost: Double
                    
                    /// Similar to NonRiderCost, except denoting Saturday prices.
                    public let saturdayNonRiderCost: Double

                    /// Create all day parking response
                    ///
                    /// - Parameters:
                    ///     - totalCount: Number of all day parking spots
                    ///     - riderCost: All day weekday costs for Metro riders
                    ///     - nonRiderCost: All day weekday cost for non-Metro riders
                    ///     - saturdayRiderCost: riderCost, but for Saturdays
                    ///     - saturdayNonRiderCost: nonRiderCost, but for Saturdays
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
                
                /// Short term parking options
                public struct ShortTerm: Codable, Equatable, Hashable {
                    /// Number of short-term parking spots available at a station (parking meters).
                    public let totalCount: Int
                    
                    /// Misc. information relating to short-term parking.
                    public let notes: String?

                    /// Create a short term parking response
                    ///
                    /// - Parameters:
                    ///     - totalCount: Number of parking meters available at this station
                    ///     - notes: Misc. parking information
                    public init(
                        totalCount: Int,
                        notes: String
                    ) {
                        self.totalCount = totalCount
                        self.notes = notes
                    }
                }

            }
        }
    }
    
    /// Ordered stations and distances between two stations on the same line
    ///
    /// If you need to find paths between stations of different lines use ``Rail/StationToStation``
    ///
    /// [WMATA Path Between Stations Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e)
    struct PathBetweenStations: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jPath")
        
        public let key: APIKey
        
        /// Origin station of a trip
        public let startingStation: Station
        
        /// Destination station of a trip
        public let destinationStation: Station
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [
                startingStation.queryItem(name: .from),
                destinationStation.queryItem(name: .to)
            ]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of path information
            public let path: [Path]

            /// Create a path between stations response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - path: List of path information
            public init(path: [Path]) {
                self.path = path
            }
            
            /// A station along a path between two stations
            public struct Path: Codable, Equatable, Hashable {
                /// Distance in feet to the previous station in the list.
                public let distanceToPreviousStation: Int
                
                /// Line of this station
                public let line: Line
                
                /// Order this path appears
                public let sequenceNumber: Int
                
                /// Station code
                public let station: Station
                
                /// Full name for this station, as shown on the WMATA website.
                public let stationName: String

                /// Create a path response
                ///
                /// - Parameters:
                ///     - distanceToPreviousStation: Distance in feet to previous station
                ///     - line: Line of this station
                ///     - sequenceNumber: Order this path appears
                ///     - station: Station code
                ///     - stationName: Full station name
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
            }
        }
    }
    
    /// Opening and scheduled first/last train times for a station
    ///
    /// Omit `station` to receive timings for all stations
    ///
    /// [WMATA Station Timings Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
    struct StationTimings: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationTimes")
        
        public let key: APIKey
        
        /// A station to receive timings for. Omit to receive data for all stations.
        public var station: Station? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }

        public struct Response: Codable, Equatable, Hashable {
            /// List of station times
            public let stationTimes: [Timing]

            /// Create a station timings response
            ///
            /// - Parameters:
            ///     - stationTimes: List of station times
            public init(stationTimes: [Timing]) {
                self.stationTimes = stationTimes
            }
            
            /// Timing information for a station
            public struct Timing: Codable, Equatable, Hashable {
                /// The station this information is for
                public let station: Station
                
                /// Full name of the station.
                public let stationName: String
                
                /// Timing information for Monday
                public let monday: Day
                
                /// Timing information for Tuesday
                public let tuesday: Day
                
                /// Timing information for Wednesday
                public let wednesday: Day
                
                /// Timing information for Thursday
                public let thursday: Day
                
                /// Timing information for Friday
                public let friday: Day
                
                /// Timing information for Saturday
                public let saturday: Day
                
                /// Timing information for Sunday
                public let sunday: Day

                /// Create a station time response
                ///
                /// - Parameters:
                ///     - station: Station code
                ///     - stationName: Name of station
                ///     - monday: Timing information for Monday
                ///     - tuesday: Timing information for Tuesday
                ///     - wednesday: Timing information for Wednesday
                ///     - thursday: Timing information for Thursday
                ///     - friday: Timing information for Friday
                ///     - saturday: Timing information for Saturday
                ///     - sunday: Timing information for Sunday
                public init(
                    station: Station,
                    stationName: String,
                    monday: Day,
                    tuesday: Day,
                    wednesday: Day,
                    thursday: Day,
                    friday: Day,
                    saturday: Day,
                    sunday: Day
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
                
                /// Station timings for a single day
                public struct Day: Codable, Equatable, Hashable {
                    /// Hours and minutes of a time
                    ///
                    /// The WMATA API sends times in the format `"HH:mm"`. This isn't every useful. Here, ``hours`` and ``minutes`` are provided as `Int` for easy date building through `DateComponents` and the like.
                    public struct WMATATime: Codable, Equatable, Hashable {
                        /// Hours of a time
                        public let hours: Int
                        
                        /// Minutes of a time
                        public let minutes: Int
                        
                        /// The original WMATA formatted time
                        ///
                        /// Format: `"HH:mm"`
                        public let stringValue: String
                        
                        public init(from decoder: Decoder) throws {
                            let container = try decoder.singleValueContainer()
                            
                            stringValue = try container.decode(String.self)
                            
                            let splitValue = stringValue.split(separator: ":").map { Int($0) }
                            
                            guard let hours = splitValue[0] else {
                                throw DecodingError.valueNotFound(
                                    Int.self, .init(
                                        codingPath: decoder.codingPath,
                                        debugDescription: "Attempted to get hours from `Timing.Day.openingTime` but wasn't able to get hours from \(stringValue)"
                                    )
                                )
                            }
                            
                            self.hours = hours
                            
                            guard let minutes = splitValue[1] else {
                                throw DecodingError.valueNotFound(
                                    Int.self, .init(
                                        codingPath: decoder.codingPath,
                                        debugDescription: "Attempted to get minutes from `Timing.Day.openingTime` but wasn't able to get minutes from \(stringValue)"
                                    )
                                )
                            }
                            
                            self.minutes = minutes
                        }
                        
                        public func encode(to encoder: Encoder) throws {
                            var container = encoder.singleValueContainer()
                            
                            try container.encode(stringValue)
                        }
                        
                        /// Convenience initializer for testing and debugging
                        public init(hours: Int, minutes: Int) {
                            self.hours = hours
                            self.minutes = minutes
                            self.stringValue = "\(hours):\(minutes)"
                        }
                    }
                    
                    /// Station opening time. Format is HH:mm.
                    public let openingTime: WMATATime
                    
                    /// First train information
                    public let firstTrains: [Time]
                    
                    /// Last train information
                    public let lastTrains: [Time]

                    /// Create a station first last trains response
                    ///
                    /// - Parameters:
                    ///     - openingTime: Station opening time
                    ///     - firstTrains: First train information
                    ///     - lastTrains: Last trains information
                    public init(
                        openingTime: WMATATime,
                        firstTrains: [Time],
                        lastTrains: [Time]
                    ) {
                        self.openingTime = openingTime
                        self.firstTrains = firstTrains
                        self.lastTrains = lastTrains
                    }
                    
                    /// The time and destination of a train departure
                    public struct Time: Codable, Equatable, Hashable {
                        /// Time the train leaves the station.
                        public let time: WMATATime
                        
                        /// Train's destination
                        public let destination: Station

                        /// Create a train time response
                        ///
                        /// - Parameters:
                        ///     - time: Time the train leaves the station
                        ///     - destination: Destination station
                        public init(time: WMATATime, destination: Station) {
                            self.time = time
                            self.destination = destination
                        }
                    }
                }
            }
        }
    }
    
    /// Station location and address information for a given ``Line``
    ///
    /// Omit `line` to receive all stations
    ///
    /// Response is identical to ``Rail/StationInformation/Response``
    ///
    /// [WMATA Station List Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
    struct Stations: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStations")
        
        public let key: APIKey
        
        /// Line to receive station information for. Omit to receive all stations.
        public var line: Line? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        public func queryItems() -> [URLQueryItem?] {
            [line?.queryItem()]
        }
        
        public struct Response: Codable, Equatable, Hashable {
            /// List of station information
            public let stations: [StationInformation.Response]

            /// Create a stations response
            ///
            /// When making requests through an ``Endpoint``, you will not need to call this. This initializer is primarily intended for testing and debugging.
            ///
            /// - Parameters:
            ///     - stations: List of station information
            public init(stations: [StationInformation.Response]) {
                self.stations = stations
            }
        }
    }
}

public extension Rail.GTFS {
    
    /// GTFS 1.0 Service Alerts feed for MetroRail
    ///
    /// Service alerts represent higher level problems with station, lines or all of MetroRail
    ///
    /// [GTFS Alerts Documentation](https://gtfs.org/reference/realtime/v1/#message-alert)
    struct Alerts: GTFSEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-alerts.pb")
        
        public let key: APIKey
        
        public weak var delegate: GTFSEndpointDelegate<Self>? = nil
    }
    
    /// GTFS 1.0 Trip Updates feed for MetroRail
    ///
    /// Trip updates represent fluctuations in the timetable
    ///
    /// [GTFS Trip Updates Documentation](https://gtfs.org/reference/realtime/v1/#message-tripupdate)
    struct TripUpdates: GTFSEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-tripupdates.pb")
        
        public let key: APIKey
        
        public weak var delegate: GTFSEndpointDelegate<Self>? = nil
    }
    
    /// GTFS 1.0 Vehicle Positions feed for MetroRail
    ///
    /// Locations of MetroRail trains
    ///
    /// [GTFS Trip Updates Documentation](https://gtfs.org/reference/realtime/v1/#message-vehicleposition)
    struct VehiclePositions: GTFSEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-vehiclepositions.pb")
        
        public let key: APIKey
        
        public weak var delegate: GTFSEndpointDelegate<Self>? = nil
    }
}
