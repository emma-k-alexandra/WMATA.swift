//
//  Bus.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import GTFS

/// A namespace for MetroBus endpoints
public enum Bus {}

public extension Bus {
    struct Positions: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jBusPositions")
        
        public let key: APIKey
        public var route: Route? = nil
        public var location: WMATALocation? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil

        internal func queryItems() -> [URLQueryItem?] {
            var queryItems = [route?.queryItem()]
            queryItems.append(contentsOf: location?.queryItems() ?? [])
            
            return queryItems
        }
        
        /// Response from the [Bus Position API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
        public struct Response: Codable {
            /// List of bus positions
            public let busPositions: [Position]

            /// Create a bus position response
            ///
            /// - Parameters:
            ///     - busPositions: List of bus positions
            public init(busPositions: [Position]) {
                self.busPositions = busPositions
            }
            
            public struct Position: Codable {
                /// Date and time (Eastern Standard Time) of last position update.
                public let dateTime: Date
                
                /// Deviation, in minutes, from schedule. Positive values indicate that the bus is running late while negative ones are for buses running ahead of schedule.
                public let deviation: Double
                
                /// Deprecated. Use the DirectionText for a customer-friendly description of direction.
                public let directionNumber: Int
                
                /// General direction of the trip, not the bus itself (e.g.: NORTH, SOUTH, EAST, WEST).
                public let directionText: String
                
                /// Latitude of bus.
                public let latitude: Double
                
                /// Longitude of bus.
                public let longitude: Double
                
                /// Base route name as shown on the bus. Note that the base route name could also refer to any variant, so a Route of 10A could refer to 10A, 10Av1, 10Av2, etc.
                public let route: Route
                
                /// Scheduled end date and time (Eastern Standard Time) of the bus's current trip.
                public let tripEndTime: Date
                
                /// Destination of the bus.
                public let tripHeadsign: String
                
                /// Unique trip ID. This can be correlated with the data returned from the schedule-related methods.
                public let tripID: String
                
                /// Scheduled start date and time (Eastern Standard Time) of the bus's current trip.
                public let tripStartTime: Date
                
                /// Unique identifier for the bus. This is usually visible on the bus itself.
                public let vehicleID: String
                
                /// Undocumented by WMATA
                public let blockNumber: String

                /// Create a bus position
                ///
                /// - Parameters:
                ///     - dateTime: Time of last position update
                ///     - deviation: Deviation in minutes from schedule
                ///     - directionNumber: Deprecated. Use directionText
                ///     - directionText: General direction of trip
                ///     - latitude: Latitude of bus
                ///     - longitude: Longitude of bus
                ///     - route: Route ID of this bus
                ///     - tripEndTime: Scheduled end of this trip
                ///     - tripHeadsign: Destination of bus
                ///     - tripID: Unique trip ID
                ///     - tripStartTime: Schedule start time of this trip
                ///     - vehicleID: Unique id for this vehicle
                ///     - blockNumber: Undocumented by WMATA
                public init(
                    dateTime: Date,
                    deviation: Double,
                    directionNumber: Int,
                    directionText: String,
                    latitude: Double,
                    longitude: Double,
                    route: Route,
                    tripEndTime: Date,
                    tripHeadsign: String,
                    tripID: String,
                    tripStartTime: Date,
                    vehicleID: String,
                    blockNumber: String
                ) {
                    self.dateTime = dateTime
                    self.deviation = deviation
                    self.directionNumber = directionNumber
                    self.directionText = directionText
                    self.latitude = latitude
                    self.longitude = longitude
                    self.route = route
                    self.tripEndTime = tripEndTime
                    self.tripHeadsign = tripHeadsign
                    self.tripID = tripID
                    self.tripStartTime = tripStartTime
                    self.vehicleID = vehicleID
                    self.blockNumber = blockNumber
                }
            }
        }
    }
    
    struct Incidents: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/BusIncidents")
        
        public let key: APIKey
        public var route: Route? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        internal func queryItems() -> [URLQueryItem?] {
            [route?.queryItem(name: .route)]
        }
        
        /// Response from the [Bus Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75)
        /// - Tag: BusIncidents
        public struct Response: Codable {
            /// List of incidents
            public let busIncidents: [Incident]

            /// Create a bus incidents response
            ///
            /// - Parameters:
            ///     - incidents: List of incidents
            public init(busIncidents: [Incident]) {
                self.busIncidents = busIncidents
            }
            
            /// Response from the [Bus Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75)
            /// - Tag: BusIncident
            public struct Incident: Codable {
                /// Date and time (Eastern Standard Time) of last update.
                public let dateUpdated: Date
                
                /// Free-text description of the delay or incident.
                public let description: String
                
                /// Unique identifier for an incident.
                public let incidentID: String
                
                /// Free-text description of the incident type. Usually Delay or Alert but is subject to change at any time.
                public let incidentType: String
                
                /// Array containing routes affected. Routes listed are usually identical to base route names (i.e.: not 10Av1 or 10Av2, but 10A), but may differ from what our bus methods return.
                public let routesAffected: [Route]

                /// Create a bus incident response
                ///
                /// - Parameters:
                ///     - dateUpdated: Time of last status update
                ///     - description: Description of incident
                ///     - incidentId: Unique ID of incident
                ///     - incidentType: Description of incident type
                ///     - routesAffected: List of routes affected
                public init(
                    dateUpdated: Date,
                    description: String,
                    incidentID: String,
                    incidentType: String,
                    routesAffected: [Route]
                ) {
                    self.dateUpdated = dateUpdated
                    self.description = description
                    self.incidentID = incidentID
                    self.incidentType = incidentType
                    self.routesAffected = routesAffected
                }
            }
        }
    }
    
    struct PathDetails: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRouteDetails")
        
        public let key: APIKey
        public let route: Route
        public  var date: Date? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        internal func queryItems() -> [URLQueryItem?] {
            [
                route.queryItem(),
                date?.queryItem()
            ]
        }
        
        /// Response from the [Path Details API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
        /// - Tag: PathDetails
        public struct Response: Codable {
            
            /// Bus route
            public let route: Route
            
            /// Descriptive name for the route.
            public let name: String
            
            /// Structures describing path/stop information.
            /// Most routes will return content in both Direction0 and Direction1 elements, though a few will return NULL for Direction0 or for Direction1.
            /// 0 or 1 are binary properties. There is no specific mapping to direction, but a different value for the same route signifies that the route is in an opposite direction.
            public let directionZero: Direction
            
            /// Structures describing path/stop information.
            /// Most routes will return content in both Direction0 and Direction1 elements, though a few will return NULL for Direction0 or for Direction1.
            /// 0 or 1 are binary properties. There is no specific mapping to direction, but a different value for the same route signifies that the route is in an opposite direction.
            public let directionOne: Direction

            /// Create path details
            ///
            /// - Parameters:
            ///     - route: Bus route
            ///     - name: Name of the route
            ///     - directionZero: Path information
            ///     - directionOne: Path information
            public init(
                route: Route,
                name: String,
                directionZero: Direction,
                directionOne: Direction
            ) {
                self.route = route
                self.name = name
                self.directionZero = directionZero
                self.directionOne = directionOne
            }
            
            /// Structures describing path/stop information. From the [Path Details API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
            /// - Tag: PathDirection
            public struct Direction: Codable {
                
                /// Descriptive text of where the bus is headed. This is similar, but not necessarily identical, to what is displayed on the bus.
                public let tripHeadsign: String
                
                /// General direction of the route variant (NORTH, SOUTH, EAST, WEST, LOOP, etc.).
                public let directionText: String
                
                /// Warning: Deprecated. Use the DirectionText element to denote the general direction of the route variant.
                public let directionNumber: String
                
                /// Array containing shape point information.
                public let shape: [Point]
                
                /// Array containing stop information.
                public let stops: [Stop]

                /// Create a path direction
                ///
                /// - Parameters:
                ///     - tripHeadsign: Description of where the bus is headed
                ///     - directionText: General direction of route
                ///     - directionNumber: Deprecated. Use directionText
                ///     - shape: Shape point information
                ///     - stops: Stop information
                public init(
                    tripHeadsign: String,
                    directionText: String,
                    directionNumber: String,
                    shape: [Point],
                    stops: [Stop]
                ) {
                    self.tripHeadsign = tripHeadsign
                    self.directionText = directionText
                    self.directionNumber = directionNumber
                    self.shape = shape
                    self.stops = stops
                }
            }
            
            /// Shape point information. From the [Path Details API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
            /// - Tag: PathStop
            public struct Point: Codable {
                /// Latitude of stop.
                public let latitude: Double
                
                /// Longitude of stop.
                public let longitude: Double
                
                /// Order of the point in the sequence of PathStop.
                public let sequenceNumber: Int

                /// Create a path stop
                ///
                /// - Parameters:
                ///     - latitude: Latitude of stop
                ///     - longitude: Longitude of stop
                ///     - sequenceNumber: Index of this point
                public init(
                    latitude: Double,
                    longitude: Double,
                    sequenceNumber: Int
                ) {
                    self.latitude = latitude
                    self.longitude = longitude
                    self.sequenceNumber = sequenceNumber
                }
            }
            
            /// Stop information. From the [Path Details API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
            /// - Tag: StopResponse
            public struct Stop: Codable {
                /// 7-digit regional ID which can be used in various bus-related methods.
                public let stop: WMATA.Stop
                
                /// Stop name. May be slightly different from what is spoken or displayed in the bus.
                public let name: String
                
                /// Latitude of stop.
                public let latitude: Double
                
                /// Longitude of stop.
                public let longitude: Double
                
                /// Array of route variants which provide service at this stop. Note that these are not date-specific; any route variant which stops at this stop on any day will be listed.
                public let routes: [Route]

                /// Create a Stop response
                ///
                /// - Parameters:
                ///     - stop: Stop ID of the stop
                ///     - name: Name of stop
                ///     - latitude: latitude of stop
                ///     - longitude: longitude of stop
                ///     - routes: Routes that provide service to this stop
                public init(
                    stop: WMATA.Stop,
                    name: String,
                    latitude: Double,
                    longitude: Double,
                    routes: [Route]
                ) {
                    self.stop = stop
                    self.name = name
                    self.latitude = latitude
                    self.longitude = longitude
                    self.routes = routes
                }
            }
        }
    }
    
    struct RouteSchedule: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRouteSchedule")
        
        public let key: APIKey
        public let route: Route
        public var date: Date? = nil
        public var includingVariations: Bool = false
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        internal func queryItems() -> [URLQueryItem?] {
            [
                route.queryItem(),
                date?.queryItem(),
                URLQueryItem(name: "includingVariations", value: String(includingVariations))
            ]
        }
        
        /// Response from the [Schedule API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
        public struct Response: Codable {
            /// Descriptive name for the route.
            public let name: String
            
            /// Arrays containing trip information.
            ///
            /// Most routes will return content in both Direction0 and Direction1 elements, though a few (especially ones which run in a loop, such as the U8) will return content only for Direction0 and NULL content for Direction1.
            ///
            /// 0 or 1 are binary properties. There is no specific mapping to direction, but a different value for the same route signifies that the route is in an opposite direction.
            public let directionZero: [RouteInfo]
            
            /// Arrays containing trip information.
            ///
            /// Most routes will return content in both Direction0 and Direction1 elements, though a few (especially ones which run in a loop, such as the U8) will return content only for Direction0 and NULL content for Direction1.
            ///
            /// 0 or 1 are binary properties. There is no specific mapping to direction, but a different value for the same route signifies that the route is in an opposite direction.
            public let directionOne: [RouteInfo]

            /// Create a route schedule response
            ///
            /// - Parameters:
            ///     - name: Name of route
            ///     - directionZero: List of route info
            ///     - directionOne: List of route info
            public init(
                name: String,
                directionZero: [RouteInfo],
                directionOne: [RouteInfo]
            ) {
                self.name = name
                self.directionZero = directionZero
                self.directionOne = directionOne
            }
            
            /// Response from the [Schedule API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
            /// - Tag: RouteInfo
            public struct RouteInfo: Codable {
                /// Bus route variant. This can be used in several other bus methods which accept variants.
                public let route: Route
                
                /// Warning: Deprecated. Use the TripDirectionText element to denote the general direction of the trip.
                public let directionNumber: String
                
                /// General direction of the trip (NORTH, SOUTH, EAST, WEST, LOOP, etc.).
                public let tripDirectionText: String
                
                /// Descriptive text of where the bus is headed. This is similar, but not necessarily identical, to what is displayed on the bus.
                public let tripHeadsign: String
                
                /// Scheduled start date and time (Eastern Standard Time) for this trip.
                public let startTime: Date
                
                /// Scheduled end date and time (Eastern Standard Time) for this trip.
                public let endTime: Date
                
                /// List of location and time information
                public let stopTimes: [StopInfo]
                
                /// Unique trip ID. This can be correlated with the data returned from the schedule-related methods.
                public let tripID: String

                /// Create a route info response
                ///
                /// - Parameters:
                ///     - route: Route ID
                ///     - directionNumber: Deprecated. Direction of route
                ///     - tripDirectionText: General direction of trip
                ///     - tripHeadsign: Destination of route
                ///     - startTime: Start time of trip
                ///     - endTime: End time of trip
                ///     - stopTimes: List of location and time information
                ///     - tripID: Unique trip ID
                public init(
                    route: Route,
                    directionNumber: String,
                    tripDirectionText: String,
                    tripHeadsign: String,
                    startTime: Date,
                    endTime: Date,
                    stopTimes: [StopInfo],
                    tripID: String
                ) {
                    self.route = route
                    self.directionNumber = directionNumber
                    self.tripDirectionText = tripDirectionText
                    self.tripHeadsign = tripHeadsign
                    self.startTime = startTime
                    self.endTime = endTime
                    self.stopTimes = stopTimes
                    self.tripID = tripID
                }
                
                /// Response from the [Schedule API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
                /// - Tag: StopInfo
                public struct StopInfo: Codable {
                    /// 7-digit regional ID which can be used in various bus-related methods. If unavailable, the StopID will be 0 or NULL.
                    public let stop: Stop
                    
                    /// Stop name. May be slightly different from what is spoken or displayed in the bus.
                    public let stopName: String
                    
                    /// Order of the stop in the sequence
                    public let stopSequence: Int
                    
                    /// Scheduled departure date and time (Eastern Standard Time) from this stop.
                    public let time: Date

                    /// Create a stop info response
                    ///
                    /// - Parameters:
                    ///     - stop: Stop ID
                    ///     - stopName: Name of stop
                    ///     - stopSequence: Order of the stop in sequence
                    ///     - time: Scheduled departure time from this stop
                    public init(
                        stop: Stop,
                        stopName: String,
                        stopSequence: Int,
                        time: Date
                    ) {
                        self.stop = stop
                        self.stopName = stopName
                        self.stopSequence = stopSequence
                        self.time = time
                    }
                }
                
            }
        }
    }
    
    struct NextBuses: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/NextBusService.svc/json/jPredictions")
        
        public let key: APIKey
        public let stop: Stop
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        internal func queryItems() -> [URLQueryItem?] {
            [stop.queryItem()]
        }
        
        /// Response from the [Next Buses API](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
        /// - Tag: BusPredictions
        public struct Response: Codable {
            /// List of predictions
            public let predictions: [Prediction]
            
            /// The full name from the given stop
            public let stopName: String
            
            /// Create a new response
            ///
            /// - Parameters:
            ///     - predictions: A list of predictions
            public init(predictions: [Prediction], stopName: String) {
                self.predictions = predictions
                self.stopName = stopName
            }
            
            /// Response from the [Next Buses API](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
            /// - Tag: BusPrediction
            public struct Prediction: Codable {
                /// Denotes a binary direction (0 or 1) of the bus. There is no specific mapping to direction, but a different value for the same route signifies that the buses are traveling in opposite directions. Use the DirectionText element to show the actual destination of the bus.
                public let directionNumber: String
                
                /// Customer-friendly description of direction and destination for a bus.
                public let directionText: String
                
                /// Minutes until bus arrival at this stop.
                public let minutes: Int
                
                /// Route ID of the bus. Base route name as shown on the bus. This can be used in other bus-related methods. Note that all variants will be shown as their base route names (i.e.: 10Av1 and 10Av2 will be shown as 10A).
                public let route: Route
                
                /// Trip identifier. This can be correlated with the data in our bus schedule information as well as bus positions.
                public let tripID: String
                
                /// Bus identifier. This can be correlated with results returned from bus positions.
                public let vehicleID: String

                /// Create a prediction
                ///
                /// - Parameters:
                ///     - directionNumber: Direction of the bus
                ///     - directionText: Customer friend description of direction and destination of bus
                ///     - minutes: Time until arrival at this stop
                ///     - route: Route ID of the bus
                ///     - tripID: Trip ID of this bus
                ///     - vehicleID: Unique vehicle identifier
                public init(
                    directionNumber: String,
                    directionText: String,
                    minutes: Int,
                    route: Route,
                    tripID: String,
                    vehicleID: String
                ) {
                    self.directionNumber = directionNumber
                    self.directionText = directionText
                    self.minutes = minutes
                    self.route = route
                    self.tripID = tripID
                    self.vehicleID = vehicleID
                }
            }
        }
    }
    
    struct StopSchedule: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jStopSchedule")
        
        public let key: APIKey
        public let stop: Stop
        public var date: Date? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        internal func queryItems() -> [URLQueryItem?] {
            [
                stop.queryItem(),
                date?.queryItem()
            ]
        }
        
        /// Response from the [Schedule at Stop API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
        /// - Tag: StopSchedule
        public struct Response: Codable {
            /// Arrivals at this stop
            public let scheduleArrivals: [Arrival]
            
            /// Stop information
            public let stop: StopSchedule

            /// Create a stop schedule
            ///
            /// - Parameters:
            ///     - arrivals: Arrivals at this stop
            ///     - stop: Stop information
            public init(
                scheduleArrivals: [Arrival],
                stop: StopSchedule
            ) {
                self.scheduleArrivals = scheduleArrivals
                self.stop = stop
            }
            
            /// Response from the [Schedule at Stop API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
            /// - Tag: BusArrival
            public struct Arrival: Codable {
                /// Date and time (Eastern Standard Time) when the bus is scheduled to stop at this location.
                public let scheduleTime: Date
                
                /// Denotes a binary direction (0 or 1) of the bus. There is no specific mapping to direction, but a different value for the same route signifies that the buses are traveling in opposite directions. Use the tripDirectionText element to show the actual destination of the bus.
                public let directionNumber: String
                
                /// Scheduled start date and time (Eastern Standard Time) for this trip.
                public let startTime: Date
                
                /// Scheduled end date and time (Eastern Standard Time) for this trip.
                public let endTime: Date
                
                /// Bus route variant identifier (pattern). This variant can be used in several other bus methods which accept variants. Note that customers will never see anything other than the base route name, so variants 10A, 10Av1, 10Av2, etc. will be displayed as 10A on the bus.
                public let route: Route
                
                /// General direction of the trip (e.g.: NORTH, SOUTH, EAST, WEST).
                public let tripDirectionText: String
                
                /// Destination of the bus.
                public let tripHeadsign: String
                
                /// Trip identifier. This can be correlated with the data in our bus schedule information as well as bus positions.
                public let tripID: String

                /// Create a bus arrival
                ///
                /// - Parameters:
                ///     - scheduleTime: Time the bus is schedule to arrive at this stop
                ///     - directionNumber: 0 to 1, as a String
                ///     - startTime: Start time of this trip
                ///     - endTime: End time of this trip
                ///     - route: Route variant
                ///     - tripDirectionText: General direction of bus
                ///     - tripHeadsign: Destination of bus
                ///     - tripID: Trip Identifier
                public init(
                    scheduleTime: Date,
                    directionNumber: String,
                    startTime: Date,
                    endTime: Date,
                    route: Route,
                    tripDirectionText: String,
                    tripHeadsign: String,
                    tripID: String
                ) {
                    self.scheduleTime = scheduleTime
                    self.directionNumber = directionNumber
                    self.startTime = startTime
                    self.endTime = endTime
                    self.route = route
                    self.tripDirectionText = tripDirectionText
                    self.tripHeadsign = tripHeadsign
                    self.tripID = tripID
                }
            }
            
            /// Response from the [Stop Search API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
            /// - Tag: StopScheduleResponse
            public struct StopSchedule: Codable {
                /// 7-digit regional ID which can be used in various bus-related methods. If unavailable, the StopID will be 0 or NULL.
                public let stop: Stop?
                
                /// Stop name. May be slightly different from what is spoken or displayed in the bus.
                public let name: String
                
                /// Latitude of stop.
                public let latitude: Double
                
                /// Longitude of stop.
                public let longitude: Double
                
                /// Array of route variants which provide service at this stop. Note that these are not date-specific; any route variant which stops at this stop on any day will be listed.
                public let routes: [Route]

                /// Create a stop schedule response
                ///
                /// - Parameters:
                ///     - stop: Stop ID
                ///     - name: Stop name
                ///     - latitude: Latitude of stop
                ///     - longitude: Longitude of stop
                ///     - routes: Routes that service this stop
                public init(
                    stop: Stop?,
                    name: String,
                    latitude: Double,
                    longitude: Double,
                    routes: [Route]
                ) {
                    self.stop = stop
                    self.name = name
                    self.latitude = latitude
                    self.longitude = longitude
                    self.routes = routes
                }
            }
        }
    }
    
    struct StopsSearch: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jStops")
        
        public let key: APIKey
        public var location: WMATALocation? = nil
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        internal func queryItems() -> [URLQueryItem?] {
            location?.queryItems() ?? []
        }
        
        /// Response from the [Stop Search API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
        /// - Tag: StopsSearchResponse
        public struct Response: Codable {
            /// List of stop schedules
            public let stops: [StopSchedule]
            
            /// Create a stop search response
            ///
            /// - Parameters:
            ///     - stops: Stop schedules
            public init(stops: [StopSchedule]) {
                self.stops = stops
            }
            
            /// Response from the [Stop Search API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
            /// - Tag: StopScheduleResponse
            public struct StopSchedule: Codable {
                /// 7-digit regional ID which can be used in various bus-related methods. If unavailable, the StopID will be 0 or NULL.
                public let stop: Stop?
                
                /// Stop name. May be slightly different from what is spoken or displayed in the bus.
                public let name: String
                
                /// Latitude of stop.
                public let latitude: Double
                
                /// Longitude of stop.
                public let longitude: Double
                
                /// Array of route variants which provide service at this stop. Note that these are not date-specific; any route variant which stops at this stop on any day will be listed.
                public let routes: [Route]

                /// Create a stop schedule response
                ///
                /// - Parameters:
                ///     - stop: Stop ID
                ///     - name: Stop name
                ///     - latitude: Latitude of stop
                ///     - longitude: Longitude of stop
                ///     - routes: Routes that service this stop
                public init(
                    stop: Stop?,
                    name: String,
                    latitude: Double,
                    longitude: Double,
                    routes: [Route]
                ) {
                    self.stop = stop
                    self.name = name
                    self.latitude = latitude
                    self.longitude = longitude
                    self.routes = routes
                }
            }
        }
    }
    
    struct Routes: JSONEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRoutes")
        
        public let key: APIKey
        
        public weak var delegate: JSONEndpointDelegate<Self>? = nil
        
        /// Response from the [Routes API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a)
        public struct Response: Codable {
            /// List of routes
            public let routes: [Route]

            /// Create a routes response
            ///
            /// - Parameters:
            ///     - routes: List of routes
            public init(routes: [Route]) {
                self.routes = routes
            }
            
            /// Response from the [Routes API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a)
            /// - Tag: RouteResponse
            public struct Route: Codable {
                /// Unique identifier for a given route variant. Can be used in various other bus-related methods.
                public let route: WMATA.Route
                
                /// Descriptive name of the route variant.
                public let name: String
                
                /// Denotes the route variant’s grouping – lines are a combination of routes which lie in the same corridor and which have significant portions of their paths along the same roadways.
                public let lineDescription: String

                /// Create a route response
                ///
                /// - Parameters:
                ///     - route: Route identifier
                ///     - name: Name of the route variant
                ///     - lineDescription: Route variant's grouping
                public init(
                    route: WMATA.Route,
                    name: String,
                    lineDescription: String
                ) {
                    self.route = route
                    self.name = name
                    self.lineDescription = lineDescription
                }
            }
        }
    }
    
    struct Alerts: GTFSEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-alerts.pb")
        
        public let key: APIKey
        
        public weak var delegate: GTFSEndpointDelegate<Self>? = nil
    }
    
    struct TripUpdates: GTFSEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-tripupdates.pb")
        
        public let key: APIKey
        
        public weak var delegate: GTFSEndpointDelegate<Self>? = nil
    }
    
    struct VehiclePositions: GTFSEndpoint {
        public let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-vehiclepositions.pb")
        
        public let key: APIKey
        
        public weak var delegate: GTFSEndpointDelegate<Self>? = nil
    }
}
