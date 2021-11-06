//
//  API.swift
//  
//
//  Created by Emma on 11/1/21.
//

import Foundation
import GTFS

public enum Bus {}
public enum Rail {}

public extension Bus {
    struct Positions: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jBusPositions")
        
        let key: APIKey
        var route: Route? = nil
        var location: WMATALocation? = nil
        
        var delegate: EndpointDelegate? = nil

        func queryItems() -> [URLQueryItem?] {
            var queryItems = [route?.queryItem()]
            queryItems.append(contentsOf: location?.queryItems() ?? [])
            
            return queryItems
        }
        
        /// Response from the [Bus Position API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
        struct Response: Codable {
            /// List of bus positions
            public let busPositions: [Position]

            /// Create a bus position response
            ///
            /// - Parameters:
            ///     - busPositions: List of bus positions
            public init(busPositions: [Position]) {
                self.busPositions = busPositions
            }
            
            struct Position: Codable {
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
    
    struct Incidents: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/BusIncidents")
        
        let key: APIKey
        var route: Route? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [route?.queryItem(name: .route)]
        }
        
        /// Response from the [Bus Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75)
        /// - Tag: BusIncidents
        struct Response: Codable {
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
            struct Incident: Codable {
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
    
    struct PathDetails: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRouteDetails")
        
        let key: APIKey
        let route: Route
        var date: WMATADate? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [
                route.queryItem(),
                date?.queryItem()
            ]
        }
        
        /// Response from the [Path Details API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69)
        /// - Tag: PathDetails
        struct Response: Codable {
            
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
            struct Direction: Codable {
                
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
            struct Point: Codable {
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
            struct Stop: Codable {
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
    
    struct RouteSchedule: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRouteSchedule")
        
        let key: APIKey
        let route: Route
        var date: WMATADate? = nil
        var includingVariations: Bool = false
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [
                route.queryItem(),
                date?.queryItem(),
                URLQueryItem(name: "includingVariations", value: String(includingVariations))
            ]
        }
        
        /// Response from the [Schedule API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b)
        struct Response: Codable {
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
            struct RouteInfo: Codable {
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
                struct StopInfo: Codable {
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
    
    struct NextBuses: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/NextBusService.svc/json/jPredictions")
        
        let key: APIKey
        let stop: Stop
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [stop.queryItem()]
        }
        
        /// Response from the [Next Buses API](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
        /// - Tag: BusPredictions
        struct Response: Codable {
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
            struct Prediction: Codable {
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
    
    struct StopSchedule: Endpoint {
        
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jStopSchedule")
        
        let key: APIKey
        let stop: Stop
        var date: WMATADate? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [
                stop.queryItem(),
                date?.queryItem()
            ]
        }
        
        /// Response from the [Schedule at Stop API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c)
        /// - Tag: StopSchedule
        struct Response: Codable {
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
            struct Arrival: Codable {
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
            struct StopSchedule: Codable {
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
    
    struct StopsSearch: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jStops")
        
        let key: APIKey
        var location: WMATALocation? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            location?.queryItems() ?? []
        }
        
        /// Response from the [Stop Search API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d)
        /// - Tag: StopsSearchResponse
        struct Response: Codable {
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
            struct StopSchedule: Codable {
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
    
    struct Routes: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRoutes")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
        
        /// Response from the [Routes API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a)
        /// - Tag: RoutesResponse
        struct Response: Codable {
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
            struct Route: Codable {
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
    
    struct Alerts: Endpoint {
        typealias Response = TransitRealtime_FeedMessage
        
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-alerts.pb")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
    }
    
    struct TripUpdates: Endpoint {
        typealias Response = TransitRealtime_FeedMessage
        
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-tripupdates.pb")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
    }
    
    struct VehiclePositions: Endpoint {
        typealias Response = TransitRealtime_FeedMessage
        
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-vehiclepositions.pb")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
    }
}

public extension Rail {
    struct Lines: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jLines")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
        
        /// Response from the [Lines API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
        /// - Tag: LinesResponse
        public struct Response: Codable {
            /// List of lines
            public let lines: [Line]

            /// Create lines response
            ///
            /// - Parameters:
            ///     - lines: List of lines
            public init(lines: [Line]) {
                self.lines = lines
            }
            
            /// Response from the [Lines API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
            /// - Tag: LineResponse
            public struct Line: Codable {
                /// The actual line
                public let line: WMATA.Line
                
                /// Full name of the Line.
                public let displayName: String
                
                /// Station for start of the Line.
                public let startStation: Station
                
                /// Station for end of the Line
                public let endStation: Station
                
                /// Intermediate terminal station. During normal service, some trains on some lines might end their trip prior to the StartStationCode or EndStationCode. A good example is on the Red Line where some trains stop at A11 (Grosvenor) or B08 (Silver Spring).
                @MapToNil<Station, EmptyString> public var firstInternalDestination: Station?
                
                /// Intermediate terminal station. During normal service, some trains on some lines might end their trip prior to the StartStationCode or EndStationCode. A good example is on the Red Line where some trains stop at A11 (Grosvenor) or B08 (Silver Spring).
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

    struct Entrances: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationEntrances")
        
        let key: APIKey
        var location: WMATALocation? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            location?.queryItems() ?? []
        }
        
        /// Response from the [Station Entrances API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f)
        /// - Tag: StationEntrances
        struct Response: Codable {
            /// List of station entrances
            public let entrances: [Entrance]

            /// Create a station entrances response
            ///
            /// - Parameters:
            ///     - entrances: List of station entrances
            public init(entrances: [Entrance]) {
                self.entrances = entrances
            }
            
            /// Response from the [Station Entrances API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f)
            /// - Tag: StationEntrance
            struct Entrance: Codable {
                /// Additional information for the entrance.
                public let description: String
                
                /// Warning: Deprecated.
                public let id: String
                
                /// Latitude of entrance.
                public let latitude: Double
                
                /// Longitude of entrance.
                public let longitude: Double
                
                /// Name of entrance.
                public let name: String
                
                /// First station for this entrance
                public let firstStation: Station
                
                /// Second station for this entrance. See multilevel stations like L'Enfant Plaza, Metro Center
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

    struct Positions: OnlyJSONEndpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrainPositions")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
        
        /// Response from the [Live Train Positions API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
        /// - Tag: TrainPositions
        struct Response: Codable {
            /// List of train positions
            public let trainPositions: [Positions]

            /// Create a train positions response
            ///
            /// - Parameters:
            ///     - trainPositions: List of train positions
            public init(trainPositions: [Positions]) {
                self.trainPositions = trainPositions
            }
            
            /// Response from the [Live Train Positions API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
            /// - Tag: TrainPosition
            struct Positions: Codable {
                /// Uniquely identifiable internal train identifier
                public let trainID: String
                
                /// Non-unique train identifier, often used by WMATA's Rail Scheduling and Operations Teams, as well as over open radio communication.
                public let trainNumber: String
                
                /// Number of cars. Can be 0.
                public let carCount: Int
                
                /// The direction of movement regardless of which track the train is on.
                public let directionNumber: Int
                
                /// The circuit identifier the train is currently on.
                public let circuitID: Int
                
                /// Destination of train
                public let destination: Station?
                
                /// Line the train is on
                public let line: Line?
                
                /// Approximate "dwell time". This is not an exact value, but can be used to determine how long a train has been reported at the same track circuit.
                public let secondsAtLocation: Int
                
                /// Service Type of a train.
                public let serviceType: String

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
                    serviceType: String
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
    
    struct Routes: OnlyJSONEndpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/StandardRoutes")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
        
        /// Response from the [Standard Routes API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
        /// - Tag: StandardRoutes
        struct Response: Codable {
            /// List of standard routes
            public let standardRoutes: [Route]

            /// Create a standard routes response
            ///
            /// - Parameters:
            ///     - standardRoutes: List of standard routes
            public init(standardRoutes: [Route]) {
                self.standardRoutes = standardRoutes
            }
            
            /// Response from the [Standard Routes API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
            /// - Tag: StandardRoute
            struct Route: Codable {
                /// Line of this route
                public let line: Line
                
                /// Track number. 1 or 2.
                public let trackNumber: Int
                
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
                    trackNumber: Int,
                    trackCircuits: [TrackCircuit]
                ) {
                    self.line = line
                    self.trackNumber = trackNumber
                    self.trackCircuits = trackCircuits
                }
                
                /// Response from the [Standard Routes API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca)
                /// - Tag: TrackCircuitWithStation
                struct TrackCircuit: Codable {
                    /// Order in which the circuit appears for the given line and track.
                    public let sequenceNumber: Int
                    
                    /// An internal system-wide uniquely identifiable circuit number.
                    public let circuitID: Int
                    
                    /// Station this circuit is at, if it is at a station
                    public let station: Station?

                    /// Create a track circuit with station response
                    ///
                    /// - Parameters:
                    ///     - sequenceNumber: Order the ciruit appears in
                    ///     - circuitId: Unique circuit id
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
    
    struct Circuits: OnlyJSONEndpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrackCircuits")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
        
        /// Response from the [Track Circuits API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
        /// - Tag: TrackCircuits
        struct Response: Codable {
            /// List of track ciruits
            public let trackCircuits: [TrackCircuit]

            /// Create a track circuits response
            ///
            /// - Parameters:
            ///     - trackCircuits: List of track circuits
            public init(trackCircuits: [TrackCircuit]) {
                self.trackCircuits = trackCircuits
            }
            
            /// Response from the [Track Circuits API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
            /// - Tag: TrackCircuit
            struct TrackCircuit: Codable {
                /// Track number. 1 and 2 denote "main" lines, while 0 and 3 are connectors (between different types of tracks) and pocket tracks, respectively.
                public let track: Int
                
                /// An internal system-wide uniquely identifiable circuit number.
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
                    track: Int,
                    circuitID: Int,
                    neighbors: [TrackNeighbor]
                ) {
                    self.track = track
                    self.circuitID = circuitID
                    self.neighbors = neighbors
                }
                
                /// Response from the [Track Circuits API](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb)
                /// - Tag: TrackNeighbor
                struct TrackNeighbor: Codable {
                    public enum NeighborType: String, Codable {
                        case left = "Left"
                        case right = "Right"
                    }
                    
                    /// Left or Right neighbor group. Generally speaking, left neighbors are to the west and south, while right neighbors are to the east/north.
                    public let neighborType: NeighborType
                    
                    /// Neighboring circuit ids.
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
    
    struct StationToStation: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo")
        
        let key: APIKey
        var station: Station? = nil
        var destinationStation: Station? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [
                station?.queryItem(name: .from),
                destinationStation?.queryItem(name: .to)
            ]
        }
        
        /// Response from the [Station to Station Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
        /// - Tag: StationToStationInfos
        struct Response: Codable {
            /// List of station to station info
            public let stationToStationInfos: [Info]

            /// Create a station to station infos response
            ///
            /// - Parameters:
            ///     - stationToStationInfos: List of station to station information
            public init(stationToStationInfos: [Info]) {
                self.stationToStationInfos = stationToStationInfos
            }
            
            /// Response from the [Station to Station Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
            /// - Tag: StationToStationInfo
            struct Info: Codable {
                /// Average of distance traveled between two stations and straight-line distance (as used for WMATA fare calculations).
                public let compositeMiles: Double
                
                /// Destination station
                public let destination: Station
                
                /// Fare information
                public let railFare: Fare
                
                /// Estimated travel time (schedule time) in minutes between the source and destination station. This is not correlated to minutes (Min) in Real-Time Rail Predictions.
                public let railTime: Int
                
                /// Origin station
                public let source: Station

                /// Create a station to station info response
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
                
                /// Response from the [Station to Station Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313)
                /// - Tag: RailFare
                struct Fare: Codable {
                    /// Fare during off-peak times.
                    public let offPeakTime: Double
                    
                    /// Fare during peak times (weekdays from opening to 9:30 AM and 3-7 PM, and weekends from midnight to closing).
                    public let peakTime: Double
                    
                    /// Reduced fare for senior citizens or people with disabilities.
                    public let seniorDisabled: Double

                    /// Create a rail fare response
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
    
    struct ElevatorAndEscalatorIncidents: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/ElevatorIncidents")
        
        let key: APIKey
        var station: Station? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }
        
        /// Response from the [Elevator and Escalator Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76)
        /// - Tag: ElevatorAndEscalatorIncidents
        struct Response: Codable {
            /// List of elevator and escalator incidents
            public let incidents: [Incident]

            /// Create an elevator and escalator incidents response
            ///
            /// - Parameters:
            ///     - incidents: List of elevator and escalator incidents
            public init(incidents: [Incident]) {
                self.incidents = incidents
            }
            
            /// Response from the [Elevator and Escalator Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76)
            /// - Tag: ElevatorAndEscalatorIncident
            struct Incident: Codable {
                /// Unique identifier for unit, by type (a single elevator and escalator may have the same UnitName, but no two elevators or two escalators will have the same UnitName).
                public let unitName: String
                
                /// Type of unit. Will be ELEVATOR or ESCALATOR.
                public let unitType: String
                
                /// Warning: Deprecated. If listed here, the unit is inoperational or otherwise impaired.
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
                public let dateUpdated: String
                
                /// Estimated date and time (Eastern Standard Time) by when unit is expected to return to normal service.
                public let estimatedReturnToService: String

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
            }
        }
    }
    
    struct Incidents: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/Incidents")
        
        let key: APIKey
        var station: Station? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }
        
        /// Response from the [Rail Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77)
        /// - Tag: RailIncidents
        struct Response: Codable {
            /// List of rail incidents
            public let incidents: [Incident]

            /// Create a rail incidents response
            ///
            /// - Parameters:
            ///     - incidents: List of rail incidents
            public init(incidents: [Incident]) {
                self.incidents = incidents
            }
            
            /// Response from the [Rail Incidents API](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77)
            /// - Tag: RailIncident
            struct Incident: Codable {
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
                
                //TODO: Parse this to array of `Line`
                /// Semi-colon and space separated list of line codes (e.g.: RD; or BL; OR; or BL; OR; RD;). =(
                public let linesAffected: String
                
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
                ///     - linesAffected: Semi-colon and space separated list of line codes. (e.g.: RD; or BL; OR; or BL; OR; RD;). =(
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
            }
        }
    }
    
    struct NextTrains: Endpoint {
        private let baseURL = "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/"
        
        var url: URLComponents {
            let url = baseURL + stations.map(\.rawValue).joined(separator: ",")
            
            return URLComponents(string: url)!
        }
        
        let key: APIKey
        let stations: [Station]
        
        var delegate: EndpointDelegate? = nil
        
        init(key: APIKey, station: Station, delegate: EndpointDelegate? = nil) {
            self.key = key
            self.stations = [station]
            self.delegate = delegate
        }
        
        init(key: APIKey, stations: [Station], delegate: EndpointDelegate? = nil) {
            self.key = key
            self.stations = stations
            self.delegate = delegate
        }
        
        /// Response from the [Next Trains API](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
        /// - Tag: RailPredictions
        struct Response: Codable {
            /// List of predictions
            public let trains: [Prediction]

            /// Create a rail predictions response
            ///
            /// - Parameters:
            ///     - trains: List of rail predictions
            public init(trains: [Prediction]) {
                self.trains = trains
            }
            
            /// Response from the [Next Trains API](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
            /// - Tag: RailPrediction
            struct Prediction: Codable {
                public enum Cars: String, Codable {
                    case six = "6"
                    case eight = "8"
                    case unknown = "-"
                }
                
                // TODO: @MapToNil?
                /// Number of cars on a train, usually 6 or 8, but might also return -.
                public let car: Cars?
                
                /// Abbreviated version of the final destination for a train. This is similar to what is displayed on the signs at stations.
                public let destinationShortName: String
                
                /// Destination station
                public let destination: Station?
                
                // TODO: Map to enum to support "No Passengers"
                /// When DestinationCode is populated, this is the full name of the destination station, as shown on the WMATA website.
                public let destinationName: String
                
                /// Denotes the track this train is on, but does not necessarily equate to Track 1 or Track 2. With the exception of terminal stations, predictions at the same station with different Group values refer to trains on different tracks.
                public let group: String
                
                /// Line of the train
                 @MapToNil<Line, Dashes> public var line: Line?
                
                /// The station the train is currently arriving at
                public let location: Station
                
                /// Full name of the station where the train is arriving.
                public let locationName: String
                
                //TODO: Move to enum
                /// Minutes until arrival. Can be a numeric value, ARR (arriving), BRD (boarding), ---, or empty.
                public let minutes: String

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
                    minutes: String
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
    
    struct StationInformation: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationInfo")
        
        let key: APIKey
        let station: Station
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
        
        /// Response from the [Station Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310),
        /// - Tag: StationInformation
        struct Response: Codable {
            /// Address information.
            public let address: Address
            
            /// Station code
            public let station: Station
            
            /// Latitude of this station.
            public let latitude: Double
            
            /// Longitude of this station.
            public let longitude: Double
            
            /// First line of this station
            public let firstLine: Line
            
            /// Second line of this station
            public let secondLine: Line?
            
            /// Third line of this station
            public let thirdLine: Line?
            
            /// Fourth line of this station. Unused.
            public let fourthLine: Line?
            
            /// Name of this station
            public let name: String
            
            /// For stations with multiple platforms (e.g.: Gallery Place, Fort Totten, L'Enfant Plaza, and Metro Center), the additional station will be listed here.
            @MapToNil<Station, EmptyString> public var firstStationTogether: Station?
            
            /// Unused.
            @MapToNil<Station, EmptyString> public var secondStationTogether: Station?

            /// Create a station information response
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
            
            /// Response from the [Station Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
            /// - Tag: StationAddress
            struct Address: Codable {
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
    
    struct ParkingInformation: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationParking")
        
        let key: APIKey
        let station: Station
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
        
        /// Response from the [Parking Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
        /// - Tag: StationsParking
        struct Response: Codable {
            /// List of parking information
            public let stationsParking: [Parking]

            /// Create stations parking response
            ///
            /// - Parameters:
            ///     - stationsParking: List of parking information
            public init(stationsParking: [Parking]) {
                self.stationsParking = stationsParking
            }
            
            /// Response from the [Parking Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
            /// - Tag: StationParking
            struct Parking: Codable {
                /// Station this parking info is for
                public let station: Station
                
                /// When not empty, provides additional parking resources such as nearby lots.
                public let notes: String
                
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
                    notes: String,
                    allDayParking: AllDay,
                    shortTermParking: ShortTerm
                ) {
                    self.station = station
                    self.notes = notes
                    self.allDayParking = allDayParking
                    self.shortTermParking = shortTermParking
                }
                
                /// Response from the [Parking Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
                /// - Tag: AllDayParking
                struct AllDay: Codable {
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
                
                /// Response from the [Parking Information API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d)
                /// - Tag: ShortTermParking
                struct ShortTerm: Codable {
                    /// Number of short-term parking spots available at a station (parking meters).
                    public let totalCount: Int
                    
                    /// Misc. information relating to short-term parking.
                    public let notes: String

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
    
    struct Path: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jPath")
        
        let key: APIKey
        let startingStation: Station
        let destinationStation: Station
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [
                startingStation.queryItem(name: .from),
                destinationStation.queryItem(name: .to)
            ]
        }
        
        /// Response from the [Path Between Stations API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e)
        /// - Tag: PathBetweenStations
        struct Response: Codable {
            /// List of path information
            public let path: [Path]

            /// Create a path between stations response
            ///
            /// - Parameters:
            ///     - path: List of path information
            public init(path: [Path]) {
                self.path = path
            }
            
            /// Response from the [Path Between Stations API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e)
            /// - Tag: Path
            struct Path: Codable {
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
    
    struct Timings: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationTimes")
        
        let key: APIKey
        let station: Station
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
        
        /// Response from the [Station Timings API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
        /// - Tag: StationTimings
        struct Response: Codable {
            /// List of station times
            public let stationTimes: [Timing]

            /// Create a station timings response
            ///
            /// - Parameters:
            ///     - stationTimes: List of station times
            public init(stationTimes: [Timing]) {
                self.stationTimes = stationTimes
            }
            
            /// Response from the [Station Timings API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
            /// - Tag: StationTime
            struct Timing: Codable {
                /// Station code
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
                
                /// Response from the [Station Timings API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
                /// - Tag: StationFirstLastTrains
                struct Day: Codable {
                    /// Station opening time. Format is HH:mm.
                    public let openingTime: String
                    
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
                        openingTime: String,
                        firstTrains: [Time],
                        lastTrains: [Time]
                    ) {
                        self.openingTime = openingTime
                        self.firstTrains = firstTrains
                        self.lastTrains = lastTrains
                    }
                    
                    /// Response from the [Station Timings API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312)
                    /// - Tag: TrainTime
                    struct Time: Codable {
                        /// Time the train leaves the station. Format is HH:mm.
                        public let time: String
                        
                        /// Train's destination
                        public let destination: Station

                        /// Create a train time response
                        ///
                        /// - Parameters:
                        ///     - time: Time the train leaves the station
                        ///     - destination: Destination station
                        public init(time: String, destination: Station) {
                            self.time = time
                            self.destination = destination
                        }
                    }
                }
            }
        }
    }
    
    struct Stations: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStations")
        
        let key: APIKey
        var line: Line? = nil
        
        var delegate: EndpointDelegate? = nil
        
        func queryItems() -> [URLQueryItem?] {
            [line?.queryItem()]
        }
        
        /// Response from the [Station List API](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311)
        /// - Tag: Stations
        struct Response: Codable {
            /// List of station information
            public let stations: [StationInformation.Response]

            /// Create a stations response
            ///
            /// - Parameters:
            ///     - stations: List of station information
            public init(stations: [StationInformation.Response]) {
                self.stations = stations
            }
        }
    }
    
    struct Alerts: Endpoint {
        typealias Response = TransitRealtime_FeedMessage
        
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-alerts.pb")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
    }
    
    struct TripUpdates: Endpoint {
        typealias Response = TransitRealtime_FeedMessage
        
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-tripupdates.pb")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
    }
    
    struct VehiclePositions: Endpoint {
        typealias Response = TransitRealtime_FeedMessage
        
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-vehiclepositions.pb")
        
        let key: APIKey
        
        var delegate: EndpointDelegate? = nil
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
