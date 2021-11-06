////
////  Delegate.swift
////
////
////  Created by Emma K Alexandra on 11/26/19.
////
//
//import Foundation
//import GTFS
//
///// Implement this protocol in order to receive requests in the background.
///// - Tag: WMATADelegate
//public protocol WMATADelegate {
//    /// MetroRail responses
//
//    /// - Tag: DelegateLinesResponse
//    func received(linesResponse result: Result<LinesResponse, WMATAError>)
//
//    /// - Tag: DelegateStationEntrances
//    func received(stationEntrances result: Result<StationEntrances, WMATAError>)
//
//    /// - Tag: DelegateTrainPositions
//    func received(trainPositions result: Result<TrainPositions, WMATAError>)
//
//    /// - Tag: DelegateStandardRoutes
//    func received(standardRoutes result: Result<StandardRoutes, WMATAError>)
//
//    /// - Tag: DelegateTrackCircuits
//    func received(trackCircuits result: Result<TrackCircuits, WMATAError>)
//
//    /// - Tag: DelegateElevatorAndEscalatorIncidents
//    func received(elevatorAndEscalatorIncidents result: Result<ElevatorAndEscalatorIncidents, WMATAError>)
//
//    /// - Tag: DelegateRailIncidents
//    func received(railIncidents result: Result<RailIncidents, WMATAError>)
//
//    /// - Tag: DelegateRailPredictions
//    func received(railPredictions result: Result<RailPredictions, WMATAError>)
//
//    /// - Tag: DelegateStationInformation
//    func received(stationInformation result: Result<StationInformation, WMATAError>)
//
//    /// - Tag: DelegateStationsParking
//    func received(stationsParking result: Result<StationsParking, WMATAError>)
//
//    /// - Tag: DelegatePathBetweenStations
//    func received(pathBetweenStations result: Result<PathBetweenStations, WMATAError>)
//
//    /// - Tag: DelegateStationTimings
//    func received(stationTimings result: Result<StationTimings, WMATAError>)
//
//    /// - Tag: DelegateStationToStationInfos
//    func received(stationToStationInfos result: Result<StationToStationInfos, WMATAError>)
//
//    /// - Tag: DelegateStations
//    func received(stations result: Result<Stations, WMATAError>)
//
//    /// MetroBus responses
//
//    /// - Tag: DelegateRoutesResponse
//    func received(routesResponse result: Result<RoutesResponse, WMATAError>)
//
//    /// - Tag: DelegateStopsSearchResponse
//    func received(stopSearchResponse result: Result<StopsSearchResponse, WMATAError>)
//
//    /// - Tag: DelegateBusIncidents
//    func received(busIncidents result: Result<BusIncidents, WMATAError>)
//
//    /// - Tag: DelegateBusPositions
//    func received(busPositions result: Result<BusPositions, WMATAError>)
//
//    /// - Tag: DelegatePathDetails
//    func received(pathDetails result: Result<PathDetails, WMATAError>)
//
//    /// - Tag: DelegateRouteSchedule
//    func received(routeSchedule result: Result<RouteSchedule, WMATAError>)
//
//    /// - Tag: DelegateBusPredictions
//    func received(busPredictions result: Result<BusPredictions, WMATAError>)
//
//    /// - Tag: DelegateStopSchedule
//    func received(stopSchedule result: Result<StopSchedule, WMATAError>)
//
//    /// GTFS-RT responses
//
//    /// - Tag: DelegateAlerts
//    func received(alerts result: Result<TransitRealtime_FeedMessage, WMATAError>)
//
//    /// - Tag: DelegateTripUpdates
//    func received(tripUpdates result: Result<TransitRealtime_FeedMessage, WMATAError>)
//
//    /// - Tag: DelegateVehiclePositions
//    func received(vehiclePositions result: Result<TransitRealtime_FeedMessage, WMATAError>)
//}
//
//public extension WMATADelegate {
//    /// MetroRail default implementations
//    /// You don't want these.
//    func received(linesResponse _: Result<LinesResponse, WMATAError>) {
//        assertionFailure("Received LinesResponse without overriding default WMATADelegate implementation")
//    }
//
//    func received(stationEntrances _: Result<StationEntrances, WMATAError>) {
//        assertionFailure("Received StationEntrances without overriding default WMATADelegate implementation")
//    }
//
//    func received(trainPositions _: Result<TrainPositions, WMATAError>) {
//        assertionFailure("Received TrainPositions without overriding default WMATADelegate implementation")
//    }
//
//    func received(standardRoutes _: Result<StandardRoutes, WMATAError>) {
//        assertionFailure("Received StandardRoutes without overriding default WMATADelegate implementation")
//    }
//
//    func received(trackCircuits _: Result<TrackCircuits, WMATAError>) {
//        assertionFailure("Received TrackCircuits without overriding default WMATADelegate implementation")
//    }
//
//    func received(elevatorAndEscalatorIncidents _: Result<ElevatorAndEscalatorIncidents, WMATAError>) {
//        assertionFailure("Received ElevatorAndEscalatorIncidents without overriding default WMATADelegate implementation")
//    }
//
//    func received(railIncidents _: Result<RailIncidents, WMATAError>) {
//        assertionFailure("Received RailIncidents without overriding default WMATADelegate implementation")
//    }
//
//    func received(railPredictions _: Result<RailPredictions, WMATAError>) {
//        assertionFailure("Received RailPredictions without overriding default WMATADelegate implementation")
//    }
//
//    func received(stationInformation _: Result<StationInformation, WMATAError>) {
//        assertionFailure("Received StationInformation without overriding default WMATADelegate implementation")
//    }
//
//    func received(stationsParking _: Result<StationsParking, WMATAError>) {
//        assertionFailure("Received StationsParking without overriding default WMATADelegate implementation")
//    }
//
//    func received(pathBetweenStations _: Result<PathBetweenStations, WMATAError>) {
//        assertionFailure("Received PathBetweenStations without overriding default WMATADelegate implementation")
//    }
//
//    func received(stationTimings _: Result<StationTimings, WMATAError>) {
//        assertionFailure("Received StationTimings without overriding default WMATADelegate implementation")
//    }
//
//    func received(stationToStationInfos _: Result<StationToStationInfos, WMATAError>) {
//        assertionFailure("Received StationToStationInfos without overriding default WMATADelegate implementation")
//    }
//
//    func received(stations _: Result<Stations, WMATAError>) {
//        assertionFailure("Received Stations without overriding default WMATADelegate implementation")
//    }
//
//    /// MetroBus default implementations.
//    /// You don't want these.
//    func received(routesResponse _: Result<RoutesResponse, WMATAError>) {
//        assertionFailure("Received RoutesResponse without overriding default WMATADelegate implementation")
//    }
//
//    func received(stopSearchResponse _: Result<StopsSearchResponse, WMATAError>) {
//        assertionFailure("Received StopsSearchResponse without overriding default WMATADelegate implementation")
//    }
//
//    func received(busIncidents _: Result<BusIncidents, WMATAError>) {
//        assertionFailure("Received BusIncidents without overriding default WMATADelegate implementation")
//    }
//
//    func received(busPositions _: Result<BusPositions, WMATAError>) {
//        assertionFailure("Received BusPositions without overriding default WMATADelegate implementation")
//    }
//
//    func received(pathDetails _: Result<PathDetails, WMATAError>) {
//        assertionFailure("Received PathDetails without overriding default WMATADelegate implementation")
//    }
//
//    func received(routeSchedule _: Result<RouteSchedule, WMATAError>) {
//        assertionFailure("Received RouteSchedule without overriding default WMATADelegate implementation")
//    }
//
//    func received(busPredictions _: Result<BusPredictions, WMATAError>) {
//        assertionFailure("Received BusPredictions without overriding default WMATADelegate implementation")
//    }
//
//    func received(stopSchedule _: Result<StopSchedule, WMATAError>) {
//        assertionFailure("Received StopSchedule without overriding default WMATADelegate implementation")
//    }
//
//    func received(alerts _: Result<TransitRealtime_FeedMessage, WMATAError>) {
//        assertionFailure("Received Alerts without overriding default WMATADelegate implementation")
//    }
//
//    func received(tripUpdates _: Result<TransitRealtime_FeedMessage, WMATAError>) {
//        assertionFailure("Received TripUpdates without overriding default WMATADelegate implementation")
//    }
//
//    func received(vehiclePositions _: Result<TransitRealtime_FeedMessage, WMATAError>) {
//        assertionFailure("Received VehiclePositions without overriding default WMATADelegate implementation")
//    }
//}
//
//public class WMATAURLSessionDataDelegate: NSObject, URLSessionDataDelegate, Deserializer, GTFSDeserializer {
//    public let wmataDelegate: WMATADelegate?
//
//    var data = Data()
//
//    public init(wmataDelegate: WMATADelegate?) {
//        self.wmataDelegate = wmataDelegate
//    }
//
////    public func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError _: Error?) {
////        guard let delegate = wmataDelegate else {
////            assertionFailure("Called method that required a delegate without providing a delegate. Provide a delegate before calling this method.")
////            exit(1)
////        }
////
////        // This all is pretty gross, but I don't think Swift supports anything to help clean this up
////        guard let originalURL = task.originalRequest?.url?.absoluteStringWithoutQuery else {
////            assertionFailure("Request send with unknown URL")
////            exit(1)
////        }
////
////        let requestURL: String
////
////        // Unfortunately, WMATA deviates from their URL scheme in this one.
////        if originalURL.contains(RailURL.nextTrains.rawValue), let lastIndexOfSlash = originalURL.lastIndex(of: "/") {
////            requestURL = String(originalURL[...lastIndexOfSlash])
////
////        } else {
////            requestURL = originalURL
////        }
////
////        if let url = RailURL(rawValue: requestURL) {
////            switch url {
////            case .lines:
////                delegate.received(linesResponse: deserialize(data))
////
////            case .entrances:
////                delegate.received(stationEntrances: deserialize(data))
////
////            case .positions:
////                delegate.received(trainPositions: deserialize(data))
////
////            case .routes:
////                delegate.received(standardRoutes: deserialize(data))
////
////            case .circuits:
////                delegate.received(trackCircuits: deserialize(data))
////
////            case .elevatorAndEscalatorIncidents:
////                delegate.received(elevatorAndEscalatorIncidents: deserialize(data))
////
////            case .incidents:
////                delegate.received(railIncidents: deserialize(data))
////
////            case .nextTrains:
////                delegate.received(railPredictions: deserialize(data))
////
////            case .information:
////                delegate.received(stationInformation: deserialize(data))
////
////            case .parkingInformation:
////                delegate.received(stationsParking: deserialize(data))
////
////            case .path:
////                delegate.received(pathBetweenStations: deserialize(data))
////
////            case .timings:
////                delegate.received(stationTimings: deserialize(data))
////
////            case .stationToStation:
////                delegate.received(stationToStationInfos: deserialize(data))
////
////            case .stations:
////                delegate.received(stations: deserialize(data))
////            }
////
////        } else if let url = GTFSRTRailURL(rawValue: requestURL) {
////            switch url {
////            case .alerts:
////                delegate.received(alerts: deserialize(data))
////
////            case .tripUpdates:
////                delegate.received(tripUpdates: deserialize(data))
////
////            case .vehiclePositions:
////                delegate.received(vehiclePositions: deserialize(data))
////            }
////
////        } else if let url = GTFSRTBusURL(rawValue: requestURL) {
////            switch url {
////            case .alerts:
////                delegate.received(alerts: deserialize(data))
////
////            case .tripUpdates:
////                delegate.received(tripUpdates: deserialize(data))
////
////            case .vehiclePositions:
////                delegate.received(vehiclePositions: deserialize(data))
////            }
////
////        } else if let url = BusURL(rawValue: requestURL) {
////            switch url {
////            case .routes:
////                delegate.received(routesResponse: deserialize(data))
////
////            case .stops:
////                delegate.received(stopSearchResponse: deserialize(data))
////
////            case .incidents:
////                delegate.received(busIncidents: deserialize(data))
////
////            case .positions:
////                delegate.received(busPositions: deserialize(data))
////
////            case .pathDetails:
////                delegate.received(pathDetails: deserialize(data))
////
////            case .routeSchedule:
////                delegate.received(routeSchedule: deserialize(data))
////
////            case .nextBuses:
////                delegate.received(busPredictions: deserialize(data))
////
////            case .stopSchedule:
////                delegate.received(stopSchedule: deserialize(data))
////            }
////
////        } else {
////            assertionFailure("Request performed on unknown URL")
////            exit(1)
////        }
////
////        data = Data()
////    }
//
//    public func urlSession(_: URLSession, dataTask _: URLSessionDataTask, didReceive data: Data) {
//        self.data.append(data)
//    }
//}
