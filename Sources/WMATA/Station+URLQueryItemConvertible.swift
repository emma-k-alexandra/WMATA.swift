//
//  Station+URLQueryItemConvertible.swift
//  
//
//  Created by Emma on 11/12/21.
//

import Foundation

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
