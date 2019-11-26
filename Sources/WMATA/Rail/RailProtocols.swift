//
//  RailProtocols.swift
//  
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation

protocol NeedsStation: Fetcher {}

extension NeedsStation {
    func station(_ station: Station?, to destinationStation: Station?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("FromStationCode", station.rawValue))
            
        }
        
        if let destinationStation = destinationStation {
            queryItems.append(("ToStationCode", destinationStation.rawValue))
            
        }
        
        self.fetch(
            with: URLRequest(url: RailURL.stationToStation.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func elevatorAndEscalatorIncidents(at station: Station?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
            
        }
        
        self.fetch(
            with: URLRequest(url: RailURL.elevatorAndEscalatorIncidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func incidents(at station: Station?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailIncidents, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let station = station {
            queryItems.append(("StationCode", station.rawValue))
            
        }
        
        self.fetch(
            with: URLRequest(url: RailURL.incidents.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func nextTrains(at station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: "\(RailURL.nextTrains.rawValue)\(station)", queryItems: [], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func nextTrains(at stations: [Station], withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        var urlArray = [RailURL.nextTrains.rawValue]
        urlArray.append(contentsOf: stations.map { $0.rawValue })
        
        self.fetch(
            with: URLRequest(url: urlArray.joined(separator: ","), queryItems: [], apiKey: apiKey),
            andSession: session,
            completion: completion)
        
    }
    
    func information(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationInformation, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.information.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func parkingInformation(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationsParking, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.parkingInformation.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
    func path(from startingStation: Station, to destinationStation: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(
                url: RailURL.path.rawValue,
                queryItems: [
                    ("FromStationCode", startingStation.rawValue),
                    ("ToStationCode", destinationStation.rawValue)
                ],
                apiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
    func timings(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationTimings, WMATAError>) -> ()) {
        self.fetch(
            with: URLRequest(url: RailURL.timings.rawValue, queryItems: [("StationCode", station.rawValue)], apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
}

protocol NeedsLine: Fetcher {}

extension NeedsLine {
    func stations(for line: Line?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let line = line {
            queryItems.append(("LineCode", line.rawValue))

        }
        
        self.fetch(
            with: URLRequest(url: RailURL.stations.rawValue, queryItems: queryItems, apiKey: apiKey),
            andSession: session,
            completion: completion
        )
        
    }
    
}
