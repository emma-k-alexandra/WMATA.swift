//
//  RailURLs.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// URLs of WMATA endpoints relating to MetroRail
enum RailURL: String {
    case lines = "https://api.wmata.com/Rail.svc/json/jLines"
    case entrances = "https://api.wmata.com/Rail.svc/json/jStationEntrances"
    case positions = "https://api.wmata.com/TrainPositions/TrainPositions"
    case routes = "https://api.wmata.com/TrainPositions/StandardRoutes"
    case circuits = "https://api.wmata.com/TrainPositions/TrackCircuits"
    case elevatorAndEscalatorIncidents = "https://api.wmata.com/Incidents.svc/json/ElevatorIncidents"
    case incidents = "https://api.wmata.com/Incidents.svc/json/Incidents"
    case nextTrains = "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/"
    case information = "https://api.wmata.com/Rail.svc/json/jStationInfo"
    case parkingInformation = "https://api.wmata.com/Rail.svc/json/jStationParking"
    case path = "https://api.wmata.com/Rail.svc/json/jPath"
    case timings = "https://api.wmata.com/Rail.svc/json/jStationTimes"
    case stationToStation = "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo"
    case stations = "https://api.wmata.com/Rail.svc/json/jStations"
}

enum GTFSRTRailURL: String {
    case alerts = "https://api.wmata.com/gtfs/rail-gtfsrt-alerts.pb"
    case tripUpdates = "https://api.wmata.com/gtfs/rail-gtfsrt-tripupdates.pb"
    case vehiclePositions = "https://api.wmata.com/gtfs/rail-gtfsrt-vehiclepositions.pb"
}
