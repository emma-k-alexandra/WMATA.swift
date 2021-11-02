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

extension URLRequest {
    // TODO: Remove
    init(url: String, key: String, queryItems: [(String, String)] = []) {
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = queryItems.compactMap { URLQueryItem(name: $0, value: $1) }

        var request = URLRequest(url: urlComponents.url!)
        request.setValue(key, forHTTPHeaderField: "api_key")

        self = request
    }
    
    init(url: URL, key: APIKey) {
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "api_key")
        
        self = request
    }
}

func generateURLSession(with delegate: WMATADelegate, sharedContainerIdentifier: String? = nil) -> URLSession {
    let config = URLSessionConfiguration.background(withIdentifier: "com.WMATA.swift.\(UUID())")

    if sharedContainerIdentifier != nil {
        config.sharedContainerIdentifier = sharedContainerIdentifier
    }

    return URLSession(
        configuration: config,
        delegate: WMATAURLSessionDataDelegate(wmataDelegate: delegate),
        delegateQueue: nil
    )
}

protocol URLQueryItemConvertable {
    /// Converts the current instance into a URLQueryItem with the given name
    func queryItem(name: String) -> URLQueryItem
}

extension URLComponents {
    init(staticString string: StaticString) {
        guard let urlComponents = URLComponents(string: "\(string)") else {
            preconditionFailure("Given string is not a URL: \(string)")
        }
        
        self = urlComponents
    }
}
