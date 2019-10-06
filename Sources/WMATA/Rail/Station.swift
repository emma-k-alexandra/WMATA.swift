//
//  Station.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//
import Foundation

/// Fetches information relating to MetroRail Stations
public class Station: Fetcher, RequestBuilder {
    /// Station codes as defined by WMATA
    public enum Code: String, CaseIterable {
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
    
    /// URLs of WMATA endpoints relating to stations
    enum Urls: String {
        case nextTrains = "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/"
        case information = "https://api.wmata.com/Rail.svc/json/jStationInfo"
        case parkingInformation = "https://api.wmata.com/Rail.svc/json/jStationParking"
        case path = "https://api.wmata.com/Rail.svc/json/jPath"
        case timings = "https://api.wmata.com/Rail.svc/json/jStationTimes"
        case stationToStation = "https://api.wmata.com/Rail.svc/json/jSrcStationToDstStationInfo"
    }
    
    /// WMATA API key from dev portal
    public var key: String
    
    /// The station this object refers to
    public var code: Station.Code
    
    /// URLSession to use for all requests
    public var urlSession: URLSession
    
    private let decoder = JSONDecoder()
    
    /// Set up Station
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter code: Station to point this object at
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, code: Station.Code, session: URLSession = URLSession.shared) {
        self.key = apiKey
        self.code = code
        self.urlSession = session
        
    }
    
    /// Next train arrival information for this station
    ///
    /// - parameter completion: Completion handler which returns `RailPredictions`
    public func nextTrains(completion: @escaping (Result<RailPredictions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: "\(Station.Urls.nextTrains)/\(self.code)", andQueryItems: []), completion: completion)
        
    }
    
    /// Location and address information for this station
    ///
    /// - parameter completion: Completion handler which returns `StationInformation`
    public func information(completion: @escaping (Result<StationInformation, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Station.Urls.information.rawValue, andQueryItems: [("StationCode", self.code.rawValue)]), completion: completion)
        
    }
    
    /// Parking information for this station
    ///
    /// - parameter completion: Completion handler which returns `StationsParking`
    public func parkingInformation(completion: @escaping (Result<StationsParking, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Station.Urls.parkingInformation.rawValue, andQueryItems: [("StationCode", self.code.rawValue)]), completion: completion)
        
    }
    
    /// Returns a set of ordered stations and distances between two stations _on the same line_
    ///
    /// - parameter to: Destination station to pathfind to
    /// - parameter completion: Completion handler which returns `PathBetweenStations`
    public func path(to station: Station.Code, completion: @escaping (Result<PathBetweenStations, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Station.Urls.path.rawValue, andQueryItems: [("FromStationCode", self.code.rawValue), ("ToStationCode", station.rawValue)]), completion: completion)
        
    }
    
    /// Opening and scheduled first and last trains for this station
    ///
    /// - parameter completion: Completion handler which returns `StationTimings`
    public func timings(completion: @escaping (Result<StationTimings, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Station.Urls.timings.rawValue, andQueryItems: [("StationCode", self.code.rawValue)]), completion: completion)
        
    }
    
    /// Distance, fare information and estimated travel time between this and another station, _including those on different line_
    ///
    /// - parameter station: Station to travel to
    /// - parameter completion: Completion handler which returns `StationToStationInfos`
    public func to(_ station: Station.Code, completion: @escaping (Result<StationToStationInfos, WMATAError>) -> ()) {
        Rail(apiKey: self.key, session: self.urlSession).station(self.code, to: station, completion: completion)
        
    }
    
}

extension Station: Session {
    func session() -> URLSession {
        self.urlSession
        
    }
    
}

extension Station: ApiKey {
    func apiKey() -> String {
        self.key
        
    }
    
}
