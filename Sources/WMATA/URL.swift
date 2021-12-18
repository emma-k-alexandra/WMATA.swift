//
//  URL.swift
//
//
//  Created by Emma K Alexandra on 11/28/19.
//

import Foundation

extension URL {
    var absoluteStringWithoutQuery: String? {
        if var urlcomponents = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            urlcomponents.query = nil
            return urlcomponents.string
        }

        return nil
    }
}

protocol URLQueryItemConvertible {
    associatedtype URLQueryItemName: RawRepresentable
    
    /// Converts the current instance into a URLQueryItem with the given name
    func queryItem(name: URLQueryItemName) -> URLQueryItem
}

extension String: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case stopID = "StopID"
        case routeID = "RouteID"
        case route = "Route"
    }
    
    func queryItem(name: URLQueryItemName) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: self)
    }
}

extension URLComponents {
    init(staticString string: StaticString) {
        guard let urlComponents = URLComponents(string: "\(string)") else {
            fatalError("Given string is not a URL: \(string)")
        }
        
        self = urlComponents
    }
}

extension Array where Element == URLQueryItem? {
    func withoutNil() -> [URLQueryItem] {
        self.compactMap { $0 }
    }
}
