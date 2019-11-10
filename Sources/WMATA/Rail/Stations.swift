//
//  Stations.swift
//  
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// Station codes as defined by WMATA
public enum Station: String, CaseIterable, Codable {
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

extension Station {
    public var name: String {
        switch self {
        case .A01:
            return "Metro Center"
            
        case .A02:
            return "Farragut North"
            
        case .A03:
            return "Dupont Circle"
            
        case .A04:
            return "Woodley Park-Zoo/Adams Morgan"
            
        case .A05:
            return "Cleveland Park"
            
        case .A06:
            return "Van Ness-UDC"
            
        case .A07:
            return "Tenleytown-AU"
            
        case .A08:
            return "Friendship Heights"
            
        case .A09:
            return "Bethesda"
            
        case .A10:
            return "Medical Center"
            
        case .A11:
            return "Grosvenor-Strathmore"
            
        case .A12:
            return "White Flint"
            
        case .A13:
            return "Twinbrook"
            
        case .A14:
            return "Rockville"
            
        case .A15:
            return "Shady Grove"
            
        case .B01:
            return "Gallery Pl-Chinatown"
            
        case .B02:
            return "Judiciary Square"
            
        case .B03:
            return "Union Station"
            
        case .B04:
            return "Rhode Island Ave-Brentwood"
            
        case .B05:
            return "Brookland-CUA"
            
        case .B06:
            return "Fort Totten"
            
        case .B07:
            return "Takoma"
            
        case .B08:
            return "Silver Spring"
            
        case .B09:
            return "Forest Glen"
            
        case .B10:
            return "Wheaton"
            
        case .B11:
            return "Glenmont"
            
        case .B35:
            return "NoMa-Gallaudet U"
            
        case .C01:
            return "Metro Center"
            
        case .C02:
            return "McPherson Square"
            
        case .C03:
            return "Farragut West"
            
        case .C04:
            return "Foggy Bottom-GWU"
            
        case .C05:
            return "Rosslyn"
            
        case .C06:
            return "Arlington Cemetery"
            
        case .C07:
            return "Pentagon"
            
        case .C08:
            return "Pentagon City"
            
        case .C09:
            return "Crystal City"
            
        case .C10:
            return "Ronald Reagan Washington National Airport"
            
        case .C12:
            return "Braddock Road"
            
        case .C13:
            return "King St-Old Town"
            
        case .C14:
            return "Eisenhower Avenue"
            
        case .C15:
            return "Huntington"
            
        case .D01:
            return "Federal Triangle"
            
        case .D02:
            return "Smithsonian"
            
        case .D03:
            return "L'Enfant Plaza"
            
        case .D04:
            return "Federal Center SW"
            
        case .D05:
            return "Capitol South"
            
        case .D06:
            return "Eastern Market"
            
        case .D07:
            return "Potomac Ave"
            
        case .D08:
            return "Stadium-Armory"
            
        case .D09:
            return "Minnesota Ave"
            
        case .D10:
            return "Deanwood"
            
        case .D11:
            return "Cheverly"
            
        case .D12:
            return "Landover"
            
        case .D13:
            return "New Carrollton"
            
        case .E01:
            return "Mt Vernon Sq 7th St-Convention Center"
            
        case .E02:
            return "Shaw-Howard U"
            
        case .E03:
            return "U Street/African-Amer Civil War Memorial/Cardozo"
            
        case .E04:
            return "Columbia Heights"
            
        case .E05:
            return "Georgia Ave-Petworth"
            
        case .E06:
            return "Fort Totten"
            
        case .E07:
            return "West Hyattsville"
            
        case .E08:
            return "Prince George's Plaza"
            
        case .E09:
            return "College Park-U of Md"
            
        case .E10:
            return "Greenbelt"
            
        case .F01:
            return "Gallery Pl-Chinatown"
            
        case .F02:
            return "Archives-Navy Memorial-Penn Quarter"
            
        case .F03:
            return "L'Enfant Plaza"
            
        case .F04:
            return "Waterfront"
            
        case .F05:
            return "Navy Yard-Ballpark"
            
        case .F06:
            return "Anacostia"
            
        case .F07:
            return "Congress Heights"
            
        case .F08:
            return "Southern Avenue"
            
        case .F09:
            return "Naylor Road"
            
        case .F10:
            return "Suitland"
            
        case .F11:
            return "Branch Ave"
            
        case .G01:
            return "Benning Road"
            
        case .G02:
            return "Capitol Heights"
            
        case .G03:
            return "Addison Road-Seat Pleasant"
            
        case .G04:
            return "Morgan Boulevard"
            
        case .G05:
            return "Largo Town Center"
            
        case .J02:
            return "Van Dorn Street"
            
        case .J03:
            return "Franconia-Springfield"
            
        case .K01:
            return "Court House"
            
        case .K02:
            return "Clarendon"
            
        case .K03:
            return "Virginia Square-GMU"
            
        case .K04:
            return "Ballston-MU"
            
        case .K05:
            return "East Falls Church"
            
        case .K06:
            return "West Falls Church-VT/UVA"
            
        case .K07:
            return "Dunn Loring-Merrifield"
            
        case .K08:
            return "Vienna/Fairfax-GMU"
            
        case .N01:
            return "McLean"
            
        case .N02:
            return "Tysons Corner"
            
        case .N03:
            return "Greensboro"
            
        case .N04:
            return "Spring Hill"
            
        case .N06:
            return "Wiehle-Reston East"
            
        }
        
    }
    
}

extension Station: CustomStringConvertible {
    public var description: String {
        self.rawValue
        
    }
    
}
