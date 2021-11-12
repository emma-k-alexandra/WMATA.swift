//
//  Line+URLQueryItemConvertible.swift
//  
//
//  Created by Emma on 11/12/21.
//

import Foundation

extension Line: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case standard = "LineCode"
    }
    
    func queryItem(name: URLQueryItemName = .standard) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: rawValue)
    }
}
