//
//  RailProtocols.swift
//  
//
//  Created by Emma K Alexandra on 10/10/19.
//

import Foundation

protocol NeedsStation: Fetcher, RequestBuilder {}

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
            with: self.buildRequest(
                fromUrl: RailURL.stationToStation.rawValue,
                andQueryItems: queryItems,
                withApiKey: apiKey
            ),
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
            with: self.buildRequest(
                fromUrl: RailURL.elevatorAndEscalatorIncidents.rawValue,
                andQueryItems: queryItems,
                withApiKey: apiKey
            ),
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
            with: self.buildRequest(
                fromUrl: RailURL.incidents.rawValue,
                andQueryItems: queryItems,
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
    func nextTrains(at station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        self.fetch(
            with: self.buildRequest(
                fromUrl: "\(RailURL.nextTrains.rawValue)\(station)",
                andQueryItems: [],
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
    func information(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationInformation, WMATAError>) -> ()) {
        self.fetch(
            with: self.buildRequest(
                fromUrl: RailURL.information.rawValue,
                andQueryItems: [("StationCode", station.rawValue)],
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
    func parkingInformation(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationsParking, WMATAError>) -> ()) {
        self.fetch(
            with: self.buildRequest(
                fromUrl: RailURL.parkingInformation.rawValue,
                andQueryItems: [("StationCode", station.rawValue)],
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
    func path(from startingStation: Station, to destinationStation: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> ()) {
        self.fetch(
            with: self.buildRequest(
                fromUrl: RailURL.path.rawValue,
                andQueryItems: [("FromStationCode", startingStation.rawValue), ("ToStationCode", destinationStation.rawValue)],
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
    func timings(for station: Station, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<StationTimings, WMATAError>) -> ()) {
        self.fetch(
            with: self.buildRequest(
                fromUrl: RailURL.timings.rawValue,
                andQueryItems: [("StationCode", station.rawValue)],
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
}

protocol NeedsLine: Fetcher, RequestBuilder {}

extension NeedsLine {
    func stations(for line: Line?, withApiKey apiKey: String, andSession session: URLSession, completion: @escaping (Result<Stations, WMATAError>) -> ()) {
        var queryItems = [(String, String)]()
        
        if let line = line {
            queryItems.append(("LineCode", line.rawValue))

        }
        
        self.fetch(
            with: self.buildRequest(
                fromUrl: RailURL.stations.rawValue,
                andQueryItems: queryItems,
                withApiKey: apiKey
            ),
            andSession: session,
            completion: completion
        )
        
    }
    
}
