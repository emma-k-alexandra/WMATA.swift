//
//  URL.swift
//
//
//  Created by Emma K Alexandra on 11/28/19.
//

import Foundation

internal extension URL {
    var absoluteStringWithoutQuery: String? {
        if var urlcomponents = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            urlcomponents.query = nil
            return urlcomponents.string
        }

        return nil
    }
}

// TODO: Figure out delegate stuff
//func generateURLSession(with delegate: WMATADelegate, sharedContainerIdentifier: String? = nil) -> URLSession {
//    let config = URLSessionConfiguration.background(withIdentifier: "com.WMATA.swift.\(UUID())")
//
//    if sharedContainerIdentifier != nil {
//        config.sharedContainerIdentifier = sharedContainerIdentifier
//    }
//
//    return URLSession(
//        configuration: config,
//        delegate: WMATAURLSessionDataDelegate(wmataDelegate: delegate),
//        delegateQueue: nil
//    )
//}

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
            preconditionFailure("Given string is not a URL: \(string)")
        }
        
        self = urlComponents
    }
}

extension Array where Element == URLQueryItem? {
    func withoutNil() -> [URLQueryItem] {
        self.compactMap { $0 }
    }
}
