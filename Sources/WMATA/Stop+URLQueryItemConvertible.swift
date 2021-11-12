//
//  Stop+URLQueryItemConvertible.swift
//  
//
//  Created by Emma on 11/12/21.
//

import Foundation


extension Stop: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case standard = "StopID"
    }
    
    func queryItem(name: URLQueryItemName = .standard) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: id)
    }
}
