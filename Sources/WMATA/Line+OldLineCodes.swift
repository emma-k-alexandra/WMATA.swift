//
//  Line+OldLineCodes.swift
//  
//
//  Created by Emma on 11/12/21.
//

import Foundation

public extension Line {
    @available(*, deprecated, renamed: "red")
    static let RD = Self.red
    
    @available(*, deprecated, renamed: "blue")
    static let BL = Self.blue
    
    @available(*, deprecated, renamed: "yellow")
    static let YL = Self.yellow
    
    @available(*, deprecated, renamed: "orange")
    static let OR = Self.orange
    
    @available(*, deprecated, renamed: "green")
    static let GR = Self.green
    
    @available(*, deprecated, renamed: "silver")
    static let SV = Self.silver
}
