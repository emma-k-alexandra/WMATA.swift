//
//  Stations.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Combine
import Foundation

/// Station codes as defined by WMATA
///
/// - Note: A station code represents a single level within a physical station.
///
/// Physical stations with multiple levels like L'Enfant Plaza require multiple station codes
/// to represent the entire physical station. Use [`together`]((x-source-tag://together)) or [`allTogether`]((x-source-tag://allTogether)) to match
/// station codes with their corresponding sister station codes.
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
    case C11
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
    case N07
    case N10
    case N11
    case N12
    case N14
    case N15
}

public extension Station {
    /// A human readable and presentable station name
    var name: String {
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

        case .C11:
            return "Potomac Yard"

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

        case .N07:
            return "Reston Town Center"

        case .N10:
            return "Herndon"

        case .N11:
            return "Innovation Center"

        case .N12:
            return "Dulles International Airport"

        case .N14:
            return "Loudoun Gateway"

        case .N15:
            return "Ashburn"
        }
    }

    /// The `Line`s this station is on
    var lines: [Line] {
        switch self {
        case .A01, .C01:
            return [.BL, .OR, .SV, .RD]

        case .A02, .A03, .A04, .A05, .A06, .A07, .A08, .A09, .A10, .A11, .A12, .A13, .A14, .A15, .B02, .B03, .B04, .B05, .B07, .B08, .B09, .B10, .B11, .B35:
            return [.RD]

        case .B01, .B06, .E06, .F01:
            return [.RD, .YL, .GR]

        case .C02, .C03, .C04, .C05, .D01, .D02, .D04, .D05, .D06, .D07, .D08:
            return [.BL, .OR, .SV]

        case .C06, .J02, .J03:
            return [.BL]

        case .C07, .C08, .C09, .C10, .C11, .C12, .C13:
            return [.BL, .YL]

        case .C14, .C15:
            return [.YL]

        case .D03, .F03:
            return [.GR, .YL, .BL, .OR, .SV]

        case .D09, .D10, .D11, .D12, .D13, .K06, .K07, .K08:
            return [.OR]

        case .E01, .E02, .E03, .E04, .E05, .E07, .E08, .E09, .E10, .F02:
            return [.GR, .YL]

        case .F04, .F05, .F06, .F07, .F08, .F09, .F10, .F11:
            return [.GR]

        case .G01, .G02, .G03, .G04, .G05:
            return [.BL, .SV]

        case .K01, .K02, .K03, .K04, .K05:
            return [.OR, .SV]

        case .N01, .N02, .N03, .N04, .N06, .N07, .N10, .N11, .N12, .N14, .N15:
            return [.SV]
        }
    }

    /// Indicates if a station is open to the public. `false` if a station is part of the Potomac Yard or Silver Line Phase 2 expansions. Otherwise `true`.
    var open: Bool {
        switch self {
        case .N07, .N10, .N11, .N12, .N14, .N15, .C11:
            return false
        default:
            return true
        }
    }

    /// The opening time for this station on the given date.
    ///
    /// - Parameters:
    ///     - date: Date to check the opening time for. Omit for today.
    ///
    /// - Returns: The opening time
    func openingTime(on date: Date? = nil) -> Date {
        let day: WeekdaySaturdayOrSunday
        let openingDate: Date

        if let date = date {
            (day, openingDate) = (date.weekdaySaturdayOrSunday(), date)

        } else {
            openingDate = Date()
            day = openingDate.weekdaySaturdayOrSunday()
        }

        let openingTimeDateComponents = Station.openingTimes[self]![day]!
        let openingDateComponents = Calendar(identifier: .gregorian).dateComponents([.day, .month, .year, .timeZone, .calendar], from: openingDate)

        return DateComponents(
            calendar: openingDateComponents.calendar,
            timeZone: openingDateComponents.timeZone!,
            year: openingDateComponents.year!,
            month: openingDateComponents.month!,
            day: openingDateComponents.day!,
            hour: openingTimeDateComponents.hour!,
            minute: openingTimeDateComponents.minute!
        ).date!
    }

    /// The station located within the same physical station as this station.
    ///
    /// - Note:
    ///     [WMATA Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
    ///
    /// - Returns: The `Station` within the same physical station.
    /// - Tag: together
    var together: Station? {
        switch self {
        // Fort Totten
        case .B06:
            return .E06
        case .E06:
            return .B06
        // Gallery Pl-Chinatown
        case .B01:
            return .F01
        case .F01:
            return .B01
        // L'Enfant Plaza
        case .D03:
            return .F03
        case .F03:
            return .D03
        // Metro Center
        case .A01:
            return .C01
        case .C01:
            return .A01
        default:
            return nil
        }
    }

    /// Combines this station and other stations within the same physical station.
    /// This is effectively the result of joining the `StationTogether1`
    /// and `StationTogether2` values from the WMATA API.
    ///
    /// - Note:
    ///     [WMATA Station Information Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310)
    ///
    /// - Returns: An array containing this station and the `Station` `together`, if there is one.
    /// - Tag: allTogether
    var allTogether: [Station] {
        if let together = self.together {
            return [self, together]
        }

        return [self]
    }
    
    /// The platform of a station within a physical station
    enum Platform {
        case upper(lower: Station)
        case lower(upper: Station)
        case single
    }
    
    /// If the current station code is for the upper or lower platform
    ///
    /// - Returns: `.single` for stations with only one platform
    var platform: Platform {
        switch self {
        // Gallery Pl-Chinatown
        case .F01:
            return .lower(upper: .B01)
        case .B01:
            return .upper(lower: .F01)
        
        // L'Enfant Plaza
        case .D03:
            return .lower(upper: .F03)
        case .F03:
            return .upper(lower: .D03)
            
        // Fort Totten
        case .B06:
            return .upper(lower: .E06)
        case .E06:
            return .lower(upper: .B06)
            
        // Metro Center
        case .A01:
            return .upper(lower: .C01)
        case .C01:
            return .lower(upper: .A01)
            
        default:
            return .single
        }
    }
}

extension Station: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case standard = "StationCode"
        case to = "ToStationCode"
        case from = "FromStationCode"
    }
    
    func queryItem(name: URLQueryItemName = .standard) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: rawValue)
    }
}
