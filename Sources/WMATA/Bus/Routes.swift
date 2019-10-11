//
//  File.swift
//  
//
//  Created by Emma Foster on 10/6/19.
//

import Foundation

/// Route ids as defined by WMATA
public enum Route: String {
    case _10A = "10A"
    case _10B = "10B"
    case _10E = "10E"
    case _10N = "10N"
    case _11Y = "11Y"
    case _11Yv1 = "11Yv1"
    case _11Yv2 = "11Yv2"
    case _11Yv3 = "11Yv3"
    case _11Yv4 = "11Yv4"
    case _15K = "15K"
    case _15Kv1 = "15Kv1"
    case _16A = "16A"
    case _16C = "16C"
    case _16Cv1 = "16Cv1"
    case _16E = "16E"
    case _16G = "16G"
    case _16Gv1 = "16Gv1"
    case _16H = "16H"
    case _16L = "16L"
    case _16Y = "16Y"
    case _16Yv1 = "16Yv1"
    case _17B = "17B"
    case _17G = "17G"
    case _17H = "17H"
    case _17K = "17K"
    case _17L = "17L"
    case _17M = "17M"
    case _18G = "18G"
    case _18H = "18H"
    case _18J = "18J"
    case _18P = "18P"
    case _18Pv1 = "18Pv1"
    case _18Pv2 = "18Pv2"
    case _1A = "1A"
    case _1B = "1B"
    case _1C = "1C"
    case _1Cv1 = "1Cv1"
    case _1Cv2 = "1Cv2"
    case _1Cv3 = "1Cv3"
    case _1Cv4 = "1Cv4"
    case _21A = "21A"
    case _21D = "21D"
    case _22A = "22A"
    case _22Av1 = "22Av1"
    case _22C = "22C"
    case _22F = "22F"
    case _23A = "23A"
    case _23B = "23B"
    case _23Bv1 = "23Bv1"
    case _23T = "23T"
    case _25B = "25B"
    case _25Bv1 = "25Bv1"
    case _25Bv2 = "25Bv2"
    case _25Bv3 = "25Bv3"
    case _26A = "26A"
    case _28A = "28A"
    case _28Av1 = "28Av1"
    case _28F = "28F"
    case _28G = "28G"
    case _29C = "29C"
    case _29G = "29G"
    case _29K = "29K"
    case _29Kv1 = "29Kv1"
    case _29N = "29N"
    case _29Nv1 = "29Nv1"
    case _29W = "29W"
    case _2A = "2A"
    case _2B = "2B"
    case _2Bv1 = "2Bv1"
    case _2Bv2 = "2Bv2"
    case _2Bv3 = "2Bv3"
    case _30N = "30N"
    case _30S = "30S"
    case _31 = "31"
    case _32 = "32"
    case _32v1 = "32v1"
    case _33 = "33"
    case _34 = "34"
    case _36 = "36"
    case _37 = "37"
    case _38B = "38B"
    case _38Bv1 = "38Bv1"
    case _38Bv2 = "38Bv2"
    case _39 = "39"
    case _3A = "3A"
    case _3Av1 = "3Av1"
    case _3T = "3T"
    case _3Tv1 = "3Tv1"
    case _3Y = "3Y"
    case _42 = "42"
    case _43 = "43"
    case _4A = "4A"
    case _4B = "4B"
    case _52 = "52"
    case _52v1 = "52v1"
    case _52v2 = "52v2"
    case _52v3 = "52v3"
    case _54 = "54"
    case _54v1 = "54v1"
    case _59 = "59"
    case _5A = "5A"
    case _60 = "60"
    case _62 = "62"
    case _62v1 = "62v1"
    case _63 = "63"
    case _64 = "64"
    case _64v1 = "64v1"
    case _70 = "70"
    case _70v1 = "70v1"
    case _74 = "74"
    case _79 = "79"
    case _7A = "7A"
    case _7Av1 = "7Av1"
    case _7Av2 = "7Av2"
    case _7Av3 = "7Av3"
    case _7C = "7C"
    case _7F = "7F"
    case _7Fv1 = "7Fv1"
    case _7M = "7M"
    case _7Mv1 = "7Mv1"
    case _7P = "7P"
    case _7W = "7W"
    case _7Y = "7Y"
    case _7Yv1 = "7Yv1"
    case _80 = "80"
    case _80v1 = "80v1"
    case _80v2 = "80v2"
    case _80v3 = "80v3"
    case _83 = "83"
    case _83v1 = "83v1"
    case _83v2 = "83v2"
    case _83v3 = "83v3"
    case _83v4 = "83v4"
    case _86 = "86"
    case _86v1 = "86v1"
    case _86v2 = "86v2"
    case _87 = "87"
    case _87v1 = "87v1"
    case _87v2 = "87v2"
    case _87v3 = "87v3"
    case _87v4 = "87v4"
    case _87v5 = "87v5"
    case _89 = "89"
    case _89v1 = "89v1"
    case _89M = "89M"
    case _8S = "8S"
    case _8W = "8W"
    case _8Z = "8Z"
    case _90 = "90"
    case _90v1 = "90v1"
    case _90v2 = "90v2"
    case _92 = "92"
    case _92v1 = "92v1"
    case _92v2 = "92v2"
    case _96 = "96"
    case _96v1 = "96v1"
    case _96v2 = "96v2"
    case _96v3 = "96v3"
    case _96v4 = "96v4"
    case _96v5 = "96v5"
    case _97 = "97"
    case _97v1 = "97v1"
    case A12
    case A12v1
    case A12v2
    case A12v3
    case A2
    case A2v1
    case A2v2
    case A2v3
    case A31
    case A32
    case A33
    case A4
    case A4v1
    case A4v2
    case A4v3
    case A4v4
    case A4v5
    case A6
    case A6v1
    case A7
    case A8
    case A8v1
    case A9
    case B2
    case B2v1
    case B2v2
    case B2v3
    case B2v4
    case B21
    case B22
    case B22v1
    case B24
    case B24v1
    case B27
    case B29
    case B29v1
    case B29v2
    case B30
    case B8
    case B8v1
    case B8v2
    case B9
    case BL1
    case BL5
    case C11
    case C12
    case C13
    case C14
    case C2
    case C2v1
    case C2v2
    case C2v3
    case C21
    case C21v1
    case C21v2
    case C22
    case C22v1
    case C26
    case C26v1
    case C28
    case C28v1
    case C29_1
    case C29_2
    case C29_4
    case C29
    case C4
    case C4v1
    case C4v2
    case C4v3
    case C8
    case C8v1
    case C8v2
    case C8v3
    case D1
    case D12
    case D12v1
    case D12v2
    case D13
    case D13v1
    case D14
    case D14v1
    case D14v2
    case D2
    case D2v1
    case D31
    case D32
    case D33
    case D34
    case D4
    case D4v1
    case D4v2
    case D5
    case D6
    case D6v1
    case D6v2
    case D6v3
    case D8
    case D8v1
    case E2
    case E4
    case E4v1
    case E4v2
    case E6
    case F1
    case F12
    case F12v1
    case F13
    case F13v1
    case F13v2
    case F13v3
    case F14
    case F14v1
    case F2
    case F2v1
    case F2v2
    case F4
    case F4v1
    case F4v2
    case F6
    case F6v1
    case F6v2
    case F8
    case G12
    case G12v1
    case G12v2
    case G14
    case G14v1
    case G14v2
    case G2
    case G2v1
    case G8
    case G8v1
    case G8v2
    case G8v3
    case G9
    case G9v1
    case H1
    case H11
    case H12
    case H12v1
    case H13
    case H2
    case H3
    case H4
    case H4v1
    case H6
    case H6v1
    case H8
    case H9
    case J1
    case J1v1
    case J12
    case J12v1
    case J2
    case J2v1
    case J2v2
    case J4
    case K12
    case K12v1
    case K12v2
    case K2
    case K6
    case K6v1
    case K9
    case K9v1
    case L1
    case L2
    case L2v1
    case L2v2
    case L8
    case M4
    case M4v1
    case M4v2
    case M6
    case M6v1
    case MW1
    case N2
    case N4
    case N4v1
    case N6
    case NH1
    case P12
    case P12v1
    case P12v2
    case P18
    case P19
    case P6
    case P6v1
    case P6v2
    case P6v3
    case P6v4
    case Q1
    case Q2
    case Q2v1
    case Q2v2
    case Q4
    case Q4v1
    case Q5
    case Q6
    case Q6v1
    case R1
    case R12
    case R12v1
    case R2
    case R2v1
    case R2v2
    case R4
    case REX
    case REXv1
    case REXv2
    case S1
    case S1v1
    case S2
    case S2v1
    case S35
    case S4
    case S4v1
    case S41
    case S80
    case S80v1
    case S80v2
    case S9
    case S9v1
    case S91
    case S91v1
    case T14
    case T14v1
    case T18
    case T18v1
    case T2
    case U4
    case U4v1
    case U4v2
    case U5
    case U6
    case U6v1
    case U6v2
    case U7
    case U7v1
    case U7v2
    case U7v3
    case U7v4
    case V1
    case V12
    case V14
    case V14v1
    case V2
    case V2v1
    case V4
    case V4v1
    case V7
    case V8
    case W1
    case W14
    case W14v1
    case W14v2
    case W2
    case W2v1
    case W2v2
    case W2v3
    case W2v4
    case W2v5
    case W2v6
    case W2v7
    case W3
    case W3v1
    case W4
    case W4v1
    case W4v2
    case W45
    case W47
    case W5
    case W6
    case W6v1
    case W8
    case W8v1
    case W8v2
    case X1
    case X2
    case X2v1
    case X2v2
    case X2v3
    case X3
    case X3v1
    case X8
    case X9
    case X9v1
    case X9v2
    case Y2
    case Y7
    case Y8
    case YL3
    case YL4
    case Z11
    case Z11v1
    case Z2
    case Z2v1
    case Z2v2
    case Z2v3
    case Z6
    case Z6v1
    case Z6v2
    case Z7
    case Z7v1
    case Z8
    case Z8v1
    case Z8v2
    case Z8v3
    case Z8v4
    case Z8v5
    case Z8v6
}

extension Route: NeedsRoute {
    /// Bus positions on this Route including latlong and direction.
    ///
    /// - Parameter radiusAtCoordinates: Radius at latlong to search at
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `BusPositions`
    func positions(at radiusAtCoordinates: RadiusAtCoordinates?, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusPositions, WMATAError>) -> ()) {
        (self as NeedsRoute).positions(on: self, at: radiusAtCoordinates, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    
    /// Bus incidents along this Route.
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which return `BusIncidents`
    func incidents(withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<BusIncidents, WMATAError>) -> ()) {
        (self as NeedsRoute).incidents(on: self, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Ordered latlong points along this Route for a given date.
    /// - Parameter date: Optional . Date in `YYYY-MM-DD` format for which to receive path information. Omit for today.
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `PathDetails`
    func pathDetails(on date: String? = nil, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<PathDetails, WMATAError>) -> ()) {
        (self as NeedsRoute).pathDetails(for: self, on: date, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
    /// Scheduled stops for this Route
    /// - Parameter date: Optional. Date in `YYYY-MM-DD` format. Omit for today.
    /// - Parameter includingVariations: Whether to include route variations. Example: B30v1 and B30v2 for Route B30
    /// - Parameter apiKey: WMATA API Key to use with this request
    /// - Parameter session: Optional. URL Session to make this request with
    /// - Parameter completion: completion handler which returns `RoutesResponse`
    func schedule(on date: String? = nil, includingVariations: Bool? = false, withApiKey apiKey: String, andSession session: URLSession = URLSession.shared, completion: @escaping (Result<RoutesResponse, WMATAError>) -> ()) {
        (self as NeedsRoute).schedule(for: self, on: date, includingVariations: includingVariations, withApiKey: apiKey, andSession: session, completion: completion)
    }
    
}
