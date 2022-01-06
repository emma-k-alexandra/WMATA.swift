//
//  Stations.swift
//
//
//  Created by Emma K Alexandra on 10/6/19.
//

import Foundation

/// A Metrorail station
///
/// A station with in enum represents a single level within a physical station. Stations in this enum are named after the first name given by WMATA, with no shortenings. So, Archives-Navy Memorial-Penn Quarter is represented as ``archives``.
///
/// Physical stations with multiple levels like L'Enfant Plaza require multiple station codes. For example, `lenfantPlazaUpper` is a single level within the L'Enfant Plaza station, along with `lenfantPlazaLower`. All stations follow this `...Upper` and `...Lower` naming convention. You can also use ``together`` or ``allTogether`` to get all relevant stations.
///
/// ![A train passes at the Pentagon City Metrorail station](metrorail-station)
public enum Station: String, CaseIterable, Codable, Equatable, Hashable, RawRepresentable {
    /// Red line tracks for Metro Center
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
    case northBethesda = "A12"
    case twinbrook = "A13"
    case rockville = "A14"
    case shadyGrove = "A15"
    /// Red line tracks for Gallery Place
    case galleryPlaceUpper = "B01"
    case judiciarySquare = "B02"
    case unionStation = "B03"
    case rhodeIslandAve = "B04"
    case brookland = "B05"
    /// Red line tracks for Fort Totten
    case fortTottenUpper = "B06"
    case takoma = "B07"
    case silverSpring = "B08"
    case forestGlen = "B09"
    case wheaton = "B10"
    case glenmont = "B11"
    case noma = "B35"
    /// Blue, Orange and Silver line tracks for Metro Center
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
    /// Blue, Orange and Silver line tracks for L'Enfant Plaza
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
    /// Green and Yellow line tracks for Fort Totten
    case fortTottenLower = "E06"
    case westHyattsville = "E07"
    case princeGeorgesPlaza = "E08"
    case collegePark = "E09"
    case greenbelt = "E10"
    /// Green and Yellow line tracks for Gallery Place
    case galleryPlaceLower = "F01"
    case archives = "F02"
    /// Green and Yellow line tracks for L'Enfant Plaza
    case lenfantPlazaUpper = "F03"
    case waterfront = "F04"
    case navyYard = "F05"
    case anacostia = "F06"
    case congressHeights = "F07"
    case southernAvenue = "F08"
    case naylorRoad = "F09"
    case suitland = "F10"
    case branchAve = "F11"
    case benningRoad = "G01"
    case capitolHeights = "G02"
    case addisonRoad = "G03"
    case morganBoulevard = "G04"
    case largoTownCenter = "G05"
    case vanDornStreet = "J02"
    case franconia = "J03"
    case courtHouse = "K01"
    case clarendon = "K02"
    case virginiaSquare = "K03"
    case ballston = "K04"
    case eastFallsChurch = "K05"
    case westFallsChurch = "K06"
    case dunnLoring = "K07"
    case vienna = "K08"
    case mcLean = "N01"
    case tysonsCorner = "N02"
    case greensboro = "N03"
    case springHill = "N04"
    case wiehle = "N06"
    case restonTownCenter = "N07"
    case herndon = "N10"
    case innovationCenter = "N11"
    case dullesInternationalAirport = "N12"
    case loudounGateway = "N14"
    case ashburn = "N15"
}

public extension Station {
    /// A human readable and presentable station name
    ///
    /// This is the official station name given by WMATA.
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

        case .northBethesda:
            return "North Bethesda"

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

        case .galleryPlaceLower:
            return "Gallery Pl-Chinatown"

        case .archives:
            return "Archives-Navy Memorial-Penn Quarter"

        case .lenfantPlazaUpper:
            return "L'Enfant Plaza"

        case .waterfront:
            return "Waterfront"

        case .navyYard:
            return "Navy Yard-Ballpark"

        case .anacostia:
            return "Anacostia"

        case .congressHeights:
            return "Congress Heights"

        case .southernAvenue:
            return "Southern Avenue"

        case .naylorRoad:
            return "Naylor Road"

        case .suitland:
            return "Suitland"

        case .branchAve:
            return "Branch Ave"

        case .benningRoad:
            return "Benning Road"

        case .capitolHeights:
            return "Capitol Heights"

        case .addisonRoad:
            return "Addison Road-Seat Pleasant"

        case .morganBoulevard:
            return "Morgan Boulevard"

        case .largoTownCenter:
            return "Largo Town Center"

        case .vanDornStreet:
            return "Van Dorn Street"

        case .franconia:
            return "Franconia-Springfield"

        case .courtHouse:
            return "Court House"

        case .clarendon:
            return "Clarendon"

        case .virginiaSquare:
            return "Virginia Square-GMU"

        case .ballston:
            return "Ballston-MU"

        case .eastFallsChurch:
            return "East Falls Church"

        case .westFallsChurch:
            return "West Falls Church-VT/UVA"

        case .dunnLoring:
            return "Dunn Loring-Merrifield"

        case .vienna:
            return "Vienna/Fairfax-GMU"

        case .mcLean:
            return "McLean"

        case .tysonsCorner:
            return "Tysons Corner"

        case .greensboro:
            return "Greensboro"

        case .springHill:
            return "Spring Hill"

        case .wiehle:
            return "Wiehle-Reston East"

        case .restonTownCenter:
            return "Reston Town Center"

        case .herndon:
            return "Herndon"

        case .innovationCenter:
            return "Innovation Center"

        case .dullesInternationalAirport:
            return "Dulles International Airport"

        case .loudounGateway:
            return "Loudoun Gateway"

        case .ashburn:
            return "Ashburn"
        }
    }

    /// The ``Line``s this station is on
    var lines: [Line] {
        switch self {
        case .metroCenterUpper, .galleryPlaceUpper, .fortTottenUpper, .farragutNorth, .dupontCircle, .woodleyPark, .clevelandPark, .vanNess, .tenleytown, .friendshipHeights, .bethesda, .medicalCenter, .grosvenor, .northBethesda, .twinbrook, .rockville, .shadyGrove, .judiciarySquare, .unionStation, .rhodeIslandAve, .brookland, .takoma, .silverSpring, .forestGlen, .wheaton, .glenmont, .noma:
            return [.red]

        case .metroCenterLower, .lenfantPlazaLower, .mcphersonSquare, .farragutWest, .foggyBottom, .rosslyn, .federalTriangle, .smithsonian, .federalCenterSW, .capitolSouth, .easternMarket, .potomacAve, .stadium:
            return [.blue, .orange, .silver]

        case .arlingtonCemetery, .vanDornStreet, .franconia:
            return [.blue]

        case .pentagon, .pentagonCity, .crystalCity, .ronaldReaganWashingtonNationalAirport, .potomacYard, .braddockRoad, .kingSt:
            return [.blue, .yellow]

        case .eisenhowerAvenue, .huntington:
            return [.yellow]

        case .minnesotaAve, .deanwood, .cheverly, .landover, .newCarrollton, .westFallsChurch, .dunnLoring, .vienna:
            return [.orange]

        case .fortTottenLower, .galleryPlaceLower, .lenfantPlazaUpper, .mtVernonSq7thSt, .shaw, .uStreet, .columbiaHeights, .georgiaAve, .westHyattsville, .princeGeorgesPlaza, .collegePark, .greenbelt, .archives:
            return [.green, .yellow]

        case .waterfront, .navyYard, .anacostia, .congressHeights, .southernAvenue, .naylorRoad, .suitland, .branchAve:
            return [.green]

        case .benningRoad, .capitolHeights, .addisonRoad, .morganBoulevard, .largoTownCenter:
            return [.blue, .silver]

        case .courtHouse, .clarendon, .virginiaSquare, .ballston, .eastFallsChurch:
            return [.orange, .silver]

        case .mcLean, .tysonsCorner, .greensboro, .springHill, .wiehle, .restonTownCenter, .herndon, .innovationCenter, .dullesInternationalAirport, .loudounGateway, .ashburn:
            return [.silver]
        }
    }

    /// Indicates if a station is open to the public.
    ///
    /// - Returns: `false` if a station is part of the Potomac Yard or Silver Line Phase 2 expansions. Otherwise `true`.
    var open: Bool {
        Station.allOpen.contains(self)
    }
    
    /// All stations that are currently open to the public.
    ///
    /// Potomac Yard and Silver Line Phase 2 expansion stations are excluded.
    static var allOpen: [Self] {
        [.metroCenterUpper, .farragutNorth, .dupontCircle, .woodleyPark, .clevelandPark, .vanNess, .tenleytown, .friendshipHeights, .bethesda, .medicalCenter, .grosvenor, .northBethesda, .twinbrook, .rockville, .shadyGrove, .galleryPlaceUpper, .judiciarySquare, .unionStation, .rhodeIslandAve, .brookland, .fortTottenUpper, .takoma, .silverSpring, .forestGlen, .wheaton, .glenmont, .noma, .metroCenterLower, .mcphersonSquare, .farragutWest, .foggyBottom, .rosslyn, .arlingtonCemetery, .pentagon, .pentagonCity, .crystalCity, .ronaldReaganWashingtonNationalAirport, .braddockRoad, .kingSt, .eisenhowerAvenue, .huntington, .federalTriangle, .smithsonian, .lenfantPlazaLower, .federalCenterSW, .capitolSouth, .easternMarket, .potomacAve, .stadium, .minnesotaAve, .deanwood, .cheverly, .landover, .newCarrollton, .mtVernonSq7thSt, .shaw, .uStreet, .columbiaHeights, .georgiaAve, .fortTottenLower, .westHyattsville, .princeGeorgesPlaza, .collegePark, .greenbelt, .galleryPlaceLower, .archives, .lenfantPlazaUpper, .waterfront, .navyYard, .anacostia, .congressHeights, .southernAvenue, .naylorRoad, .suitland, .branchAve, .benningRoad, .capitolHeights, .addisonRoad, .morganBoulevard, .largoTownCenter, .vanDornStreet, .franconia, .courtHouse, .clarendon, .virginiaSquare, .ballston, .eastFallsChurch, .westFallsChurch, .dunnLoring, .vienna, .mcLean, .tysonsCorner, .greensboro, .springHill, .wiehle]
    }

    /// The opening time for this station on the given date.
    ///
    /// - Parameters:
    ///     - date: Date to check the opening time for. Defaults to current day.
    ///
    /// - Returns: The opening time. `nil` if the station is not ``open`` yet.
    func openingTime(on date: Date = Date()) -> Date? {
        let day = date.wmataDay()
        
        guard let openingTimeDateComponents = Self.openingTimes[self]?[day] else {
            return nil
        }
        
        let openingDateComponents = Calendar(identifier: .gregorian).dateComponents([
            .day,
            .month,
            .year,
            .timeZone,
            .calendar
        ], from: date)

        let openingTime = DateComponents(
            calendar: openingDateComponents.calendar,
            timeZone: openingDateComponents.timeZone,
            year: openingDateComponents.year,
            month: openingDateComponents.month,
            day: openingDateComponents.day,
            hour: openingTimeDateComponents.hour,
            minute: openingTimeDateComponents.minute
        )
            
        guard let openingTime = openingTime.date else {
            return nil
        }
        
        return openingTime
    }

    /// The station located within the same physical station as this station.
    ///
    /// See ``Station`` for more details.
    ///
    /// - Returns: The ``Station`` within the same physical station, if there is one. Otherwise, `nil`.
    var together: Self? {
        switch self {
        case .fortTottenUpper:
            return .fortTottenLower
            
        case .fortTottenLower:
            return .fortTottenUpper
            
        case .galleryPlaceUpper:
            return .galleryPlaceLower
        case .galleryPlaceLower:
            return .galleryPlaceUpper
            
        case .lenfantPlazaLower:
            return .lenfantPlazaUpper
            
        case .lenfantPlazaUpper:
            return .lenfantPlazaLower
            
        case .metroCenterUpper:
            return .metroCenterLower
            
        case .metroCenterLower:
            return .metroCenterUpper
            
        default:
            return nil
        }
    }

    /// Combines this station and other stations within the same physical station.
    ///
    /// See ``Station`` for more details.
    ///
    /// - Returns: This station and the ``together``, if there is one. Otherwise, just this station.
    var allTogether: [Self] {
        if let together = self.together {
            return [self, together]
        }

        return [self]
    }

    /// Get the connecting lines at this station for the given line.
    ///
    /// - Parameter to: The line to get connections for; if nil, returns all lines at this station.
    ///
    /// - Returns: An array of connecting lines; this is empty if the `to` line is the only line at this station.
    func connections(to line: Line?) -> [Line] {
        self.lines.filter({ $0 != line })
    }

    /// Get the connecting lines at this station and any station together with it for the given line.
    ///
    /// - Parameter to: The line to get connections for; if nil, returns all lines at this station.
    ///
    /// - Returns: An array of connecting lines; this is empty if the `to` line is the only line at this station.
    func allConnections(to line: Line?) -> [Line] {
        self.allTogether.flatMap({ $0.connections(to: line) })
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

public extension Array where Element == Station {
    /// Both L'Enfant Plaza platforms
    static let lenfantPlaza: [Station] = [.lenfantPlazaLower, .lenfantPlazaUpper]
   
   /// Both Metro Center platforms
    static let metroCenter: [Station]  = [.metroCenterLower, .metroCenterUpper]
   
   /// Both Fort Totten platforms
    static let fortTotten: [Station]  = [.fortTottenLower, .fortTottenUpper]
   
   /// Both Gallery Place platforms
    static let galleryPlace: [Station]  = [.galleryPlaceLower, .galleryPlaceUpper]
}
