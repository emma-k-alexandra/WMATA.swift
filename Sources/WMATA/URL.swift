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
    init(url: String, queryItems: [(String, String)], apiKey: String) {
        var urlComponents = URLComponents(string: url)!

        urlComponents.queryItems = queryItems.compactMap { URLQueryItem(name: $0, value: $1) }

        var request = URLRequest(url: urlComponents.url!)
        request.setValue(apiKey, forHTTPHeaderField: "api_key")

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
