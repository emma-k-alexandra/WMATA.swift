//
//  Delegate.swift
//  
//
//  Created by Emma K Alexandra on 11/26/19.
//

import Foundation

public protocol WMATADelegate {
    /// MetroRail responses
    func received(linesResponse result: Result<LinesResponse, WMATAError>)
    
    func received(stationEntrances result: Result<StationEntrances, WMATAError>)
    
    func received(trainPositions result: Result<TrainPositions, WMATAError>)
    
    func received(standardRoutes result: Result<StandardRoutes, WMATAError>)
    
    func received(trackCircuits result: Result<TrackCircuits, WMATAError>)
    
    func received(elevatorAndEscalatorIncidents result: Result<ElevatorAndEscalatorIncidents, WMATAError>)
    
    func received(railIncidents result: Result<RailIncidents, WMATAError>)
    
    func received(railPredictions result: Result<RailPredictions, WMATAError>)
    
    func received(stationInformation result: Result<StationInformation, WMATAError>)
    
    func received(stationsParking result: Result<StationsParking, WMATAError>)
    
    func received(pathBetweenStations result: Result<PathBetweenStations, WMATAError>)
    
    func received(stationTimings result: Result<StationTimings, WMATAError>)
    
    func received(stationToStationInfos result: Result<StationToStationInfos, WMATAError>)
    
    func received(stations result: Result<Stations, WMATAError>)
    
    /// MetroBus responses
    func received(routesResponse result: Result<RoutesResponse, WMATAError>)
    
    func received(stopSearchResponse result: Result<StopsSearchResponse, WMATAError>)
    
    func received(busIncidents result: Result<BusIncidents, WMATAError>)
    
    func received(busPositions result: Result<BusPositions, WMATAError>)
    
    func received(pathDetails result: Result<PathDetails, WMATAError>)
    
    func received(routeSchedule result: Result<RouteSchedule, WMATAError>)
    
    func received(busPredictions result: Result<BusPredictions, WMATAError>)
    
    func received(stopSchedule result: Result<StopSchedule, WMATAError>)
    
    func received(alerts result: Result<TransitRealtime_FeedMessage, WMATAError>)
    
    func received(tripUpdates result: Result<TransitRealtime_FeedMessage, WMATAError>)
    
    func received(vehiclePositions result: Result<TransitRealtime_FeedMessage, WMATAError>)
    
}

extension WMATADelegate {
    /// MetroRail default implementations
    /// You don't want these.
    func received(linesResponse result: Result<LinesResponse, WMATAError>) {
        assertionFailure("Received LinesResponse without overriding default WMATADelegate implementation")
        
    }
    
    func received(stationEntrances result: Result<StationEntrances, WMATAError>) {
        assertionFailure("Received StationEntrances without overriding default WMATADelegate implementation")
        
    }
    
    func received(trainPositions result: Result<TrainPositions, WMATAError>) {
        assertionFailure("Received TrainPositions without overriding default WMATADelegate implementation")
        
    }
    
    func received(standardRoutes result: Result<StandardRoutes, WMATAError>) {
        assertionFailure("Received StandardRoutes without overriding default WMATADelegate implementation")
        
    }
    
    func received(trackCircuits result: Result<TrackCircuits, WMATAError>) {
        assertionFailure("Received TrackCircuits without overriding default WMATADelegate implementation")
        
    }
    
    func received(elevatorAndEscalatorIncidents result: Result<ElevatorAndEscalatorIncidents, WMATAError>) {
        assertionFailure("Received ElevatorAndEscalatorIncidents without overriding default WMATADelegate implementation")
        
    }
    
    func received(railIncidents result: Result<RailIncidents, WMATAError>) {
        assertionFailure("Received RailIncidents without overriding default WMATADelegate implementation")
        
    }
    
    func received(railPredictions result: Result<RailPredictions, WMATAError>) {
        assertionFailure("Received RailPredictions without overriding default WMATADelegate implementation")
        
    }
    
    func received(stationInformation result: Result<StationInformation, WMATAError>) {
        assertionFailure("Received StationInformation without overriding default WMATADelegate implementation")
        
    }
    
    func received(stationsParking result: Result<StationsParking, WMATAError>) {
       assertionFailure("Received StationsParking without overriding default WMATADelegate implementation")
        
    }
    
    func received(pathBetweenStations result: Result<PathBetweenStations, WMATAError>) {
        assertionFailure("Received PathBetweenStations without overriding default WMATADelegate implementation")
        
    }
    
    func received(stationTimings result: Result<StationTimings, WMATAError>) {
        assertionFailure("Received StationTimings without overriding default WMATADelegate implementation")
        
    }
    
    func received(stationToStationInfos result: Result<StationToStationInfos, WMATAError>) {
        assertionFailure("Received StationToStationInfos without overriding default WMATADelegate implementation")
        
    }
    
    func received(stations result: Result<Stations, WMATAError>) {
        assertionFailure("Received Stations without overriding default WMATADelegate implementation")
        
    }
    
    /// MetroBus default implementations.
    /// You don't want these.
    func received(routesResponse result: Result<RoutesResponse, WMATAError>) {
        assertionFailure("Received RoutesResponse without overriding default WMATADelegate implementation")
        
    }
    
    func received(stopSearchResponse result: Result<StopsSearchResponse, WMATAError>) {
        assertionFailure("Received StopsSearchResponse without overriding default WMATADelegate implementation")
        
    }
    
    func received(busIncidents result: Result<BusIncidents, WMATAError>) {
        assertionFailure("Received BusIncidents without overriding default WMATADelegate implementation")
        
    }
    
    func received(busPositions result: Result<BusPositions, WMATAError>) {
        assertionFailure("Received BusPositions without overriding default WMATADelegate implementation")
        
    }
    
    func received(pathDetails result: Result<PathDetails, WMATAError>) {
        assertionFailure("Received PathDetails without overriding default WMATADelegate implementation")
        
    }
    
    func received(routeSchedule result: Result<RouteSchedule, WMATAError>) {
        assertionFailure("Received RouteSchedule without overriding default WMATADelegate implementation")
        
    }
    
    func received(busPredictions result: Result<BusPredictions, WMATAError>) {
        assertionFailure("Received BusPredictions without overriding default WMATADelegate implementation")
        
    }
    
    func received(stopSchedule result: Result<StopSchedule, WMATAError>) {
        assertionFailure("Received StopSchedule without overriding default WMATADelegate implementation")
        
    }
    
    func received(alerts result: Result<TransitRealtime_FeedMessage, WMATAError>) {
        assertionFailure("Received Alerts without overriding default WMATADelegate implementation")
        
    }
    
    func received(tripUpdates result: Result<TransitRealtime_FeedMessage, WMATAError>) {
        assertionFailure("Received TripUpdates without overriding default WMATADelegate implementation")
        
    }
    
    func received(vehiclePositions result: Result<TransitRealtime_FeedMessage, WMATAError>) {
        assertionFailure("Received VehiclePositions without overriding default WMATADelegate implementation")
        
    }
    
}

public class WMATAURLSessionDataDelegate: NSObject, URLSessionDataDelegate, Deserializer, GTFSDeserializer {
    public let wmataDelegate: WMATADelegate?
    
    var data: Data = Data()
    
    public init(wmataDelegate: WMATADelegate?) {
        self.wmataDelegate = wmataDelegate
        
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let delegate = self.wmataDelegate else {
            assertionFailure("Called method that required a delegate without providing a delegate. Provide a delegate before calling this method.")
            exit(1)
            
        }
        
        // This all is pretty gross, but I don't think Swift supports anything to help clean this up
        guard let originalURL = task.originalRequest?.url?.absoluteStringWithoutQuery else {
            assertionFailure("Request send with unknown URL")
            exit(1)
            
        }
        
        let requestURL: String
        
        // Unfortunately, WMATA deviates from their URL scheme in this one.
        if originalURL.contains(RailURL.nextTrains.rawValue), let lastIndexOfSlash = originalURL.lastIndex(of: "/") {
            requestURL = String(originalURL[...lastIndexOfSlash])
            
        } else {
            requestURL = originalURL
            
        }
        
        if let url = RailURL(rawValue: requestURL) {
            switch url {
            case .lines:
                delegate.received(linesResponse: self.deserialize(self.data))
                
            case .entrances:
                delegate.received(stationEntrances: self.deserialize(self.data))
                
            case .positions:
                delegate.received(trainPositions: self.deserialize(self.data))
                
            case .routes:
                delegate.received(standardRoutes: self.deserialize(self.data))
                
            case .circuits:
                delegate.received(trackCircuits: self.deserialize(self.data))
                
            case .elevatorAndEscalatorIncidents:
                delegate.received(elevatorAndEscalatorIncidents: self.deserialize(self.data))
                
            case .incidents:
                delegate.received(railIncidents: self.deserialize(self.data))
                
            case .nextTrains:
                delegate.received(railPredictions: self.deserialize(self.data))
                
            case .information:
                delegate.received(stationInformation: self.deserialize(self.data))
                
            case .parkingInformation:
                delegate.received(stationsParking: self.deserialize(self.data))
                
            case .path:
                delegate.received(pathBetweenStations: self.deserialize(self.data))
                
            case .timings:
                delegate.received(stationTimings: self.deserialize(self.data))
                
            case .stationToStation:
                delegate.received(stationToStationInfos: self.deserialize(self.data))
                
            case .stations:
                delegate.received(stations: self.deserialize(self.data))
                
            }
            
        } else if let url = GTFSRTRailURL(rawValue: requestURL) {
            switch url {
            case .alerts:
                delegate.received(alerts: self.deserialize(self.data))
                
            case .tripUpdates:
                delegate.received(tripUpdates: self.deserialize(self.data))
                
            case .vehiclePositions:
                delegate.received(vehiclePositions: self.deserialize(self.data))
                
            }
            
        } else if let url = GTFSRTBusURL(rawValue: requestURL) {
            switch url {
            case .alerts:
                delegate.received(alerts: self.deserialize(self.data))
                
            case .tripUpdates:
                delegate.received(tripUpdates: self.deserialize(self.data))
                
            case .vehiclePositions:
                delegate.received(vehiclePositions: self.deserialize(self.data))
                
            }
            
        } else if let url = BusURL(rawValue: requestURL) {
            switch url {
            case .routes:
                delegate.received(routesResponse: self.deserialize(self.data))
                
            case .stops:
                delegate.received(stopSearchResponse: self.deserialize(self.data))
                
            case .incidents:
                delegate.received(busIncidents: self.deserialize(self.data))
                
            case .positions:
                delegate.received(busPositions: self.deserialize(self.data))
                
            case .pathDetails:
                delegate.received(pathDetails: self.deserialize(self.data))
                
            case .routeSchedule:
                delegate.received(routeSchedule: self.deserialize(self.data))
                
            case .nextBuses:
                delegate.received(busPredictions: self.deserialize(self.data))
                
            case .stopSchedule:
                delegate.received(stopSchedule: self.deserialize(self.data))
                
            }
            
        } else {
            assertionFailure("Request performed on unknown URL")
            exit(1)
            
        }
        
        self.data = Data()
        
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
        
    }
    
}
