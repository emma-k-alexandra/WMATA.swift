//
//  Errors.swift
//
//
//  Created by Emma K Alexandra on 6/23/19.
//

/// Error type for all errors that occur with the WMATA package.
/// - Tag: WMATAError
public struct WMATAError: Codable, Error {
    public let statusCode: Int
    public let message: String
}

extension Error {
    var wmataError: WMATAError {
        WMATAError(statusCode: 0, message: localizedDescription)
    }
}
