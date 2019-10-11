//
//  StationCodes.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

/// Station codes as defined by WMATA
public enum Station: String, CaseIterable {
    case A01
    case A02
    case A03
    case A04
    case A05
    case A06
    case A07
    case A08
    case A09
    case A10
    case A11
    case A12
    case A13
    case A14
    case A15
    case B01
    case B02
    case B03
    case B04
    case B05
    case B06
    case B07
    case B08
    case B09
    case B10
    case B11
    case B35
    case C01
    case C02
    case C03
    case C04
    case C05
    case C06
    case C07
    case C08
    case C09
    case C10
    case C12
    case C13
    case C14
    case C15
    case D01
    case D02
    case D03
    case D04
    case D05
    case D06
    case D07
    case D08
    case D09
    case D10
    case D11
    case D12
    case D13
    case E01
    case E02
    case E03
    case E04
    case E05
    case E06
    case E07
    case E08
    case E09
    case E10
    case F01
    case F02
    case F03
    case F04
    case F05
    case F06
    case F07
    case F08
    case F09
    case F10
    case F11
    case G01
    case G02
    case G03
    case G04
    case G05
    case J02
    case J03
    case K01
    case K02
    case K03
    case K04
    case K05
    case K06
    case K07
    case K08
    case N01
    case N02
    case N03
    case N04
    case N06
}

extension Station: NeedsStation {
    /// Distance, fare information, and estimated travel time between this and another station.
    /// - Parameter destinationStation: Optional. Station to travel to
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion that returns `StationToStationInfos`
    public func station(to destinationStation: Station?, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> ()) {
        (self as NeedsStation).station(self, to: destinationStation, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Reported elevator and escalator incidents at this Station
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `ElevatorAndEscalatorIncidents`
    public func elevatorAndEscalatorIncidents(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<ElevatorAndEscalatorIncidents, WMATAError>) -> ()) {
        (self as NeedsStation).elevatorAndEscalatorIncidents(at: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Reported MetroRail incidents at this Station
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `RailIncidents`
    public func incidents(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<RailIncidents, WMATAError>) -> ()) {
        (self as NeedsStation).incidents(at: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    ///  Next train arrival information for this Station
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `RailPredictions`
    public func nextTrains(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        (self as NeedsStation).nextTrains(at: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Location and address information for this Station
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `StationInformation`
    public func information(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StationInformation, WMATAError>) -> ()) {
        (self as NeedsStation).information(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Parking information for this Station
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `StationsParking`
    public func parkingInformation(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StationsParking, WMATAError>) -> ()) {
        (self as NeedsStation).parkingInformation(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Returns a set of ordered stations and distances from this Station to another Station _on the same line_
    /// - Parameter destinationStation: Destination station to pathfind to
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `PathBetweenStations`
    public func path(to destinationStation: Station, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> ()) {
        (self as NeedsStation).path(from: self, to: destinationStation, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Opening and scheduled first and last trains for this Station
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler that returns `StationTimings`
    public func timings(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<StationTimings, WMATAError>) -> ()) {
        (self as NeedsStation).timings(for: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
}
