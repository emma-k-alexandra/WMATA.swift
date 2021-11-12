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
    case metroCenterUpper = "A01"
    case farragutNorth = "A02"
    case dupontCircle = "A03"
    case woodleyPark = "A04"
    case clevelandPark = "A05"
    case vanNess = "A06"
    case tenleytown = "A07"
    case friendshipHeights = "A08"
    case bethesda = "A09"
    case medicalCenter = "A10"
    case grosvenor = "A11"
    case whiteFlint = "A12"
    case twinbrook = "A13"
    case rockville = "A14"
    case shadyGrove = "A15"
    case galleryPlaceUpper = "B01"
    case judiciarySquare = "B02"
    case unionStation = "B03"
    case rhodeIslandAve = "B04"
    case brookland = "B05"
    case fortTottenUpper = "B06"
    case takoma = "B07"
    case silverSpring = "B08"
    case forestGlen = "B09"
    case wheaton = "B10"
    case glenmont = "B11"
    case noma = "B35"
    case metroCenterLower = "C01"
    case mcphersonSquare = "C02"
    case farragutWest = "C03"
    case foggyBottom = "C04"
    case rosslyn = "C05"
    case arlingtonCemetery = "C06"
    case pentagon = "C07"
    case pentagonCity = "C08"
    case crystalCity = "C09"
    case ronaldReaganWashingtonNationalAirport = "C10"
    case potomacYard = "C11"
    case braddockRoad = "C12"
    case kingSt = "C13"
    case eisenhowerAvenue = "C14"
    case huntington = "C15"
    case federalTriangle = "D01"
    case smithsonian = "D02"
    case lenfantPlazaLower = "D03"
    case federalCenterSW = "D04"
    case capitolSouth = "D05"
    case easternMarket = "D06"
    case potomacAve = "D07"
    case stadium = "D08"
    case minnesotaAve = "D09"
    case deanwood = "D10"
    case cheverly = "D11"
    case landover = "D12"
    case newCarrollton = "D13"
    case mtVernonSq7thSt = "E01"
    case shaw = "E02"
    case uStreet = "E03"
    case columbiaHeights = "E04"
    case georgiaAve = "E05"
    case fortTottenLower = "E06"
    case westHyattsville = "E07"
    case princeGeorgesPlaza = "E08"
    case collegePark = "E09"
    case greenbelt = "E10"
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
    @available(*, deprecated, renamed: "metroCenterUpper")
    static let A01 = Self.metroCenterUpper
    
    @available(*, deprecated, renamed: "farragutNorth")
    static let A02 = Self.farragutNorth
    
    @available(*, deprecated, renamed: "dupontCircle")
    static let A03 = Self.dupontCircle
    
    @available(*, deprecated, renamed: "woodleyPark")
    static let A04 = Self.woodleyPark
    
    @available(*, deprecated, renamed: "clevelandPark")
    static let A05 = Self.clevelandPark
    
    @available(*, deprecated, renamed: "vanNess")
    static let A06 = Self.vanNess
    
    @available(*, deprecated, renamed: "tenleytown")
    static let A07 = Self.tenleytown
    
    @available(*, deprecated, renamed: "friendshipHeights")
    static let A08 = Self.friendshipHeights
    
    @available(*, deprecated, renamed: "bethesda")
    static let A09 = Self.bethesda
    
    @available(*, deprecated, renamed: "medicalCenter")
    static let A10 = Self.medicalCenter
    
    @available(*, deprecated, renamed: "grosvenor")
    static let A11 = Self.grosvenor
    
    @available(*, deprecated, renamed: "whiteFlint")
    static let A12 = Self.whiteFlint
    
    @available(*, deprecated, renamed: "twinbrook")
    static let A13 = Self.twinbrook
    
    @available(*, deprecated, renamed: "rockville")
    static let A14 = Self.rockville
    
    @available(*, deprecated, renamed: "shadyGrove")
    static let A15 = Self.shadyGrove
    
    @available(*, deprecated, renamed: "galleryPlaceUpper")
    static let B01 = Self.galleryPlaceUpper
    
    @available(*, deprecated, renamed: "judiciarySquare")
    static let B02 = Self.judiciarySquare
    
    @available(*, deprecated, renamed: "unionStation")
    static let B03 = Self.unionStation
    
    @available(*, deprecated, renamed: "rhodeIslandAve")
    static let B04 = Self.rhodeIslandAve
    
    @available(*, deprecated, renamed: "brookland")
    static let B05 = Self.brookland
    
    @available(*, deprecated, renamed: "fortTottenUpper")
    static let B06 = Self.fortTottenUpper
    
    @available(*, deprecated, renamed: "takoma")
    static let B07 = Self.takoma
    
    @available(*, deprecated, renamed: "silverSpring")
    static let B08 = Self.silverSpring
    
    @available(*, deprecated, renamed: "forestGlen")
    static let B09 = Self.forestGlen
    
    @available(*, deprecated, renamed: "wheaton")
    static let B10 = Self.wheaton
    
    @available(*, deprecated, renamed: "glenmont")
    static let B11 = Self.glenmont
    
    @available(*, deprecated, renamed: "noma")
    static let B35 = Self.noma
    
    @available(*, deprecated, renamed: "metroCenterLower")
    static let C01 = Self.metroCenterLower
    
    @available(*, deprecated, renamed: "mcphersonSquare")
    static let C02 = Self.mcphersonSquare
    
    @available(*, deprecated, renamed: "farragutWest")
    static let C03 = Self.farragutWest
    
    @available(*, deprecated, renamed: "foggyBottom")
    static let C04 = Self.foggyBottom
    
    @available(*, deprecated, renamed: "rosslyn")
    static let C05 = Self.rosslyn
    
    @available(*, deprecated, renamed: "arlingtonCemetery")
    static let C06 = Self.arlingtonCemetery
    
    @available(*, deprecated, renamed: "pentagon")
    static let C07 = Self.pentagon
    
    @available(*, deprecated, renamed: "pentagonCity")
    static let C08 = Self.pentagonCity
    
    @available(*, deprecated, renamed: "crystalCity")
    static let C09 = Self.crystalCity
    
    @available(*, deprecated, renamed: "ronaldReaganWashingtonNationalAirport")
    static let C10 = Self.ronaldReaganWashingtonNationalAirport
    
    @available(*, deprecated, renamed: "potomacYard")
    static let C11 = Self.potomacYard
    
    @available(*, deprecated, renamed: "braddockRoad")
    static let C12 = Self.braddockRoad
    
    @available(*, deprecated, renamed: "kingSt")
    static let C13 = Self.kingSt
    
    @available(*, deprecated, renamed: "eisenhowerAvenue")
    static let C14 = Self.eisenhowerAvenue
    
    @available(*, deprecated, renamed: "huntington")
    static let C15 = Self.huntington
    
    @available(*, deprecated, renamed: "federalTriangle")
    static let D01 = Self.federalTriangle
    
    @available(*, deprecated, renamed: "smithsonian")
    static let D02 = Self.smithsonian
    
    @available(*, deprecated, renamed: "lenfantPlazaLower")
    static let D03 = Self.lenfantPlazaLower
    
    @available(*, deprecated, renamed: "federalCenterSW")
    static let D04 = Self.federalCenterSW
    
    @available(*, deprecated, renamed: "capitolSouth")
    static let D05 = Self.capitolSouth
    
    @available(*, deprecated, renamed: "easternMarket")
    static let D06 = Self.easternMarket
    
    @available(*, deprecated, renamed: "potomacAve")
    static let D07 = Self.potomacAve
    
    @available(*, deprecated, renamed: "stadium")
    static let D08 = Self.stadium
    
    @available(*, deprecated, renamed: "minnesotaAve")
    static let D09 = Self.minnesotaAve
    
    @available(*, deprecated, renamed: "deanwood")
    static let D10 = Self.deanwood
    
    @available(*, deprecated, renamed: "cheverly")
    static let D11 = Self.cheverly
    
    @available(*, deprecated, renamed: "landover")
    static let D12 = Self.landover
    
    @available(*, deprecated, renamed: "newCarrollton")
    static let D13 = Self.newCarrollton
    
    @available(*, deprecated, renamed: "mtVernonSq7thSt")
    static let E01 = Self.mtVernonSq7thSt
    
    @available(*, deprecated, renamed: "shaw")
    static let E02 = Self.shaw
    
    @available(*, deprecated, renamed: "uStreet")
    static let E03 = Self.uStreet
    
    @available(*, deprecated, renamed: "columbiaHeights")
    static let E04 = Self.columbiaHeights
    
    @available(*, deprecated, renamed: "georgiaAve")
    static let E05 = Self.georgiaAve
    
    @available(*, deprecated, renamed: "fortTottenLower")
    static let E06 = Self.fortTottenLower
    
    @available(*, deprecated, renamed: "westHyattsville")
    static let E07 = Self.westHyattsville
    
    @available(*, deprecated, renamed: "princeGeorgesPlaza")
    static let E08 = Self.princeGeorgesPlaza
    
    @available(*, deprecated, renamed: "collegePark")
    static let E09 = Self.collegePark
    
    @available(*, deprecated, renamed: "greenbelt")
    static let E10 = Self.greenbelt
}

public extension Station {
    /// A human readable and presentable station name
    var name: String {
        switch self {
        case .metroCenterUpper:
            return "Metro Center"

        case .farragutNorth:
            return "Farragut North"

        case .dupontCircle:
            return "Dupont Circle"

        case .woodleyPark:
            return "Woodley Park-Zoo/Adams Morgan"

        case .clevelandPark:
            return "Cleveland Park"

        case .vanNess:
            return "Van Ness-UDC"

        case .tenleytown:
            return "Tenleytown-AU"

        case .friendshipHeights:
            return "Friendship Heights"

        case .bethesda:
            return "Bethesda"

        case .medicalCenter:
            return "Medical Center"

        case .grosvenor:
            return "Grosvenor-Strathmore"

        case .whiteFlint:
            return "White Flint"

        case .twinbrook:
            return "Twinbrook"

        case .rockville:
            return "Rockville"

        case .shadyGrove:
            return "Shady Grove"

        case .galleryPlaceUpper:
            return "Gallery Pl-Chinatown"

        case .judiciarySquare:
            return "Judiciary Square"

        case .unionStation:
            return "Union Station"

        case .rhodeIslandAve:
            return "Rhode Island Ave-Brentwood"

        case .brookland:
            return "Brookland-CUA"

        case .fortTottenUpper:
            return "Fort Totten"

        case .takoma:
            return "Takoma"

        case .silverSpring:
            return "Silver Spring"

        case .forestGlen:
            return "Forest Glen"

        case .wheaton:
            return "Wheaton"

        case .glenmont:
            return "Glenmont"

        case .noma:
            return "NoMa-Gallaudet U"

        case .metroCenterLower:
            return "Metro Center"

        case .mcphersonSquare:
            return "McPherson Square"

        case .farragutWest:
            return "Farragut West"

        case .foggyBottom:
            return "Foggy Bottom-GWU"

        case .rosslyn:
            return "Rosslyn"

        case .arlingtonCemetery:
            return "Arlington Cemetery"

        case .pentagon:
            return "Pentagon"

        case .pentagonCity:
            return "Pentagon City"

        case .crystalCity:
            return "Crystal City"

        case .ronaldReaganWashingtonNationalAirport:
            return "Ronald Reagan Washington National Airport"

        case .potomacYard:
            return "Potomac Yard"

        case .braddockRoad:
            return "Braddock Road"

        case .kingSt:
            return "King St-Old Town"

        case .eisenhowerAvenue:
            return "Eisenhower Avenue"

        case .huntington:
            return "Huntington"

        case .federalTriangle:
            return "Federal Triangle"

        case .smithsonian:
            return "Smithsonian"

        case .lenfantPlazaLower:
            return "L'Enfant Plaza"

        case .federalCenterSW:
            return "Federal Center SW"

        case .capitolSouth:
            return "Capitol South"

        case .easternMarket:
            return "Eastern Market"

        case .potomacAve:
            return "Potomac Ave"

        case .stadium:
            return "Stadium-Armory"

        case .minnesotaAve:
            return "Minnesota Ave"

        case .deanwood:
            return "Deanwood"

        case .cheverly:
            return "Cheverly"

        case .landover:
            return "Landover"

        case .newCarrollton:
            return "New Carrollton"

        case .mtVernonSq7thSt:
            return "Mt Vernon Sq 7th St-Convention Center"

        case .shaw:
            return "Shaw-Howard U"

        case .uStreet:
            return "U Street/African-Amer Civil War Memorial/Cardozo"

        case .columbiaHeights:
            return "Columbia Heights"

        case .georgiaAve:
            return "Georgia Ave-Petworth"

        case .fortTottenLower:
            return "Fort Totten"

        case .westHyattsville:
            return "West Hyattsville"

        case .princeGeorgesPlaza:
            return "Prince George's Plaza"

        case .collegePark:
            return "College Park-U of Md"

        case .greenbelt:
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
        case .metroCenterUpper, .metroCenterLower:
            return [.BL, .OR, .SV, .RD]

        case .farragutNorth, .dupontCircle, .woodleyPark, .clevelandPark, .vanNess, .tenleytown, .friendshipHeights, .bethesda, .medicalCenter, .grosvenor, .whiteFlint, .twinbrook, .rockville, .shadyGrove, .judiciarySquare, .unionStation, .rhodeIslandAve, .brookland, .takoma, .silverSpring, .forestGlen, .wheaton, .glenmont, .noma:
            return [.RD]

        case .galleryPlaceUpper, .fortTottenUpper, .fortTottenLower, .F01:
            return [.RD, .YL, .GR]

        case .mcphersonSquare, .farragutWest, .foggyBottom, .rosslyn, .federalTriangle, .smithsonian, .federalCenterSW, .capitolSouth, .easternMarket, .potomacAve, .stadium:
            return [.BL, .OR, .SV]

        case .arlingtonCemetery, .J02, .J03:
            return [.BL]

        case .pentagon, .pentagonCity, .crystalCity, .ronaldReaganWashingtonNationalAirport, .potomacYard, .braddockRoad, .kingSt:
            return [.BL, .YL]

        case .eisenhowerAvenue, .huntington:
            return [.YL]

        case .lenfantPlazaLower, .F03:
            return [.GR, .YL, .BL, .OR, .SV]

        case .minnesotaAve, .deanwood, .cheverly, .landover, .newCarrollton, .K06, .K07, .K08:
            return [.OR]

        case .mtVernonSq7thSt, .shaw, .uStreet, .columbiaHeights, .georgiaAve, .westHyattsville, .princeGeorgesPlaza, .collegePark, .greenbelt, .F02:
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
        case .N07, .N10, .N11, .N12, .N14, .N15, .potomacYard:
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
        case .fortTottenUpper:
            return .fortTottenLower
        case .fortTottenLower:
            return .fortTottenUpper
        // Gallery Pl-Chinatown
        case .galleryPlaceUpper:
            return .F01
        case .F01:
            return .galleryPlaceUpper
        // L'Enfant Plaza
        case .lenfantPlazaLower:
            return .F03
        case .F03:
            return .lenfantPlazaLower
        // Metro Center
        case .metroCenterUpper:
            return .metroCenterLower
        case .metroCenterLower:
            return .metroCenterUpper
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
            return .lower(upper: .galleryPlaceUpper)
        case .galleryPlaceUpper:
            return .upper(lower: .F01)
        
        // L'Enfant Plaza
        case .lenfantPlazaLower:
            return .lower(upper: .F03)
        case .F03:
            return .upper(lower: .lenfantPlazaLower)
            
        // Fort Totten
        case .fortTottenUpper:
            return .upper(lower: .fortTottenLower)
        case .fortTottenLower:
            return .lower(upper: .galleryPlaceUpper)
        // Metro Center
        case .metroCenterUpper:
            return .upper(lower: .metroCenterLower)
        case .metroCenterLower:
            return .lower(upper: .metroCenterUpper)
            
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
