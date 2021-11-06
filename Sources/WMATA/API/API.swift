//
//  API.swift
//  
//
//  Created by Emma on 11/1/21.
//

import Foundation

internal enum API {
    internal enum Bus {}
    internal enum Rail {}
}

internal extension API.Bus {
    struct Positions: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jBusPositions")
        
        let key: APIKey
        let route: Route?
        let radiusAtCoordinates: RadiusAtCoordinates?

        func queryItems() -> [URLQueryItem?] {
            var queryItems = [route?.queryItem()]
            queryItems.append(contentsOf: radiusAtCoordinates?.queryItems() ?? [])
            
            return queryItems
        }
    }
    
    struct Incidents: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/BusIncidents")
        
        let key: APIKey
        let route: Route?
        
        func queryItems() -> [URLQueryItem?] {
            [route?.queryItem(name: .route)]
        }
    }
    
    struct PathDetails: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRouteDetails")
        
        let key: APIKey
        let route: Route
        let date: WMATADate?
        
        func queryItems() -> [URLQueryItem?] {
            [
                route.queryItem(),
                date?.queryItem()
            ]
        }
    }
    
    struct RouteSchedule: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRouteSchedule")
        
        let key: APIKey
        let route: Route
        let date: WMATADate?
        let includingVariations: Bool?
        
        func queryItems() -> [URLQueryItem?] {
            [
                route.queryItem(),
                date?.queryItem(),
                URLQueryItem(name: "includingVariations", value: String(includingVariations ?? false))
            ]
        }
    }
    
    struct NextBuses: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/NextBusService.svc/json/jPredictions")
        
        let key: APIKey
        let stop: Stop
        
        func queryItems() -> [URLQueryItem?] {
            [stop.queryItem()]
        }
    }
    
    struct StopSchedule: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jStopSchedule")
        
        let key: APIKey
        let stop: Stop
        let date: WMATADate?
        
        func queryItems() -> [URLQueryItem?] {
            [
                stop.queryItem(),
                date?.queryItem()
            ]
        }
    }
    
    struct StopsSearch: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jStops")
        
        let key: APIKey
        let radiusAtCoordinates: RadiusAtCoordinates?
        
        func queryItems() -> [URLQueryItem?] {
            radiusAtCoordinates?.queryItems() ?? []
        }
    }
    
    struct Routes: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Bus.svc/json/jRoutes")
        
        let key: APIKey
    }
    
    struct Alerts: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-alerts.pb")
        
        let key: APIKey
    }
    
    struct TripUpdates: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-tripupdates.pb")
        
        let key: APIKey
    }
    
    struct VehiclePositions: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/bus-gtfsrt-vehiclepositions.pb")
        
        let key: APIKey
    }
}

internal extension API.Rail {
    struct Lines: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jLines")
        
        let key: APIKey
    }
    
    struct LinesTest: EndpointTest {
        typealias Response = LinesResponse
        
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jLines")
        
        let key: APIKey
    }

    struct Entrances: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationEntrances")
        
        let key: APIKey
        let radiusAtCoordinates: RadiusAtCoordinates?
        
        func queryItems() -> [URLQueryItem?] {
            radiusAtCoordinates?.queryItems() ?? []
        }
    }

    struct Positions: OnlyJSONEndpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrainPositions")
        
        let key: APIKey
    }
    
    struct Routes: OnlyJSONEndpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/StandardRoutes")
        
        let key: APIKey
    }
    
    struct Circuits: OnlyJSONEndpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/TrainPositions/TrackCircuits")
        
        let key: APIKey
    }
    
    struct StationToStation: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo")
        
        let key: APIKey
        let station: Station?
        let destinationStation: Station?
        
        func queryItems() -> [URLQueryItem?] {
            [
                station?.queryItem(name: .from),
                destinationStation?.queryItem(name: .to)
            ]
        }
    }
    
    struct ElevatorAndEscalatorIncidents: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/ElevatorIncidents")
        
        let key: APIKey
        let station: Station?
        
        func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
        }
    }
    
    struct Incidents: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Incidents.svc/json/Incidents")
        
        let key: APIKey
        let station: Station?
        
        func queryItems() -> [URLQueryItem?] {
            [station?.queryItem()]
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
        
        init(key: APIKey, station: Station) {
            self.key = key
            self.stations = [station]
        }
        
        init(key: APIKey, stations: [Station]) {
            self.key = key
            self.stations = stations
        }
    }
    
    struct Information: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationInfo")
        
        let key: APIKey
        let station: Station
        
        func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
    }
    
    struct ParkingInformation: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationParking")
        
        let key: APIKey
        let station: Station
        
        func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
    }
    
    struct Path: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jPath")
        
        let key: APIKey
        let startingStation: Station
        let destinationStation: Station
        
        func queryItems() -> [URLQueryItem?] {
            [
                startingStation.queryItem(name: .from),
                destinationStation.queryItem(name: .to)
            ]
        }
    }
    
    struct Timings: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStationTimes")
        
        let key: APIKey
        let station: Station
        
        func queryItems() -> [URLQueryItem?] {
            [station.queryItem()]
        }
    }
    
    struct Stations: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/Rail.svc/json/jStations")
        
        let key: APIKey
        let line: Line?
        
        func queryItems() -> [URLQueryItem?] {
            [line?.queryItem()]
        }
    }
    
    struct Alerts: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-alerts.pb")
        
        let key: APIKey
    }
    
    struct TripUpdates: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-tripupdates.pb")
        
        let key: APIKey
    }
    
    struct VehiclePositions: Endpoint {
        let url = URLComponents(staticString: "https://api.wmata.com/gtfs/rail-gtfsrt-vehiclepositions.pb")
        
        let key: APIKey
    }
}
