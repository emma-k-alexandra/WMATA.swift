//
//  Station+OldStationCodes.swift
//  
//
//  Created by Emma on 11/12/21.
//

import Foundation

// To be removed in a future version
public extension Station {
    @available(*, deprecated, renamed: "northBethesda")
    static let whiteFlint = Self.northBethesda
    
    @available(*, deprecated, renamed: "hyattsvilleCrossing")
    static let princeGeorgesPlaza = Self.hyattsvilleCrossing
    
    @available(*, deprecated, renamed: "downtownLargo")
    static let largoTownCenter = Self.downtownLargo
    
    @available(*, deprecated, renamed: "tysons")
    static let tysonsCorner = Self.tysons
    
    @available(*, deprecated, renamed: "washingtonDullesInternationalAirport")
    static let dullesInternationalAirport = Self.washingtonDullesInternationalAirport
}
