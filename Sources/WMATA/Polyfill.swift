//
//  Polyfill.swift
//  
//
//  Created by Emma on 12/12/21.
//

import Foundation

/// A polyfill for URLSession in iOS 13, macOS 10.15, watchOS 6 and tvOS 13.
extension URLSession {
    @available(iOS, deprecated: 15, message: "This extension is no longer necessary. Use API built into SDK")
    @available(macOS, deprecated: 12, message: "This extension is no longer necessary. Use API built into SDK")
    @available(watchOS, deprecated: 8, message: "This extension is no longer necessary. Use API built into SDK")
    @available(tvOS, deprecated: 15, message: "This extension is no longer necessary. Use API built into SDK")
    func data(from request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
}
