//
//  Errors.swift
//
//
//  Created by Emma K Alexandra on 6/23/19.
//

// TODO: Improve this awful mess
/// Error type for all errors that occur with the WMATA package.
/// - Tag: WMATAError
public struct WMATAError: Codable, Error {
    public var statusCode = 0
    public let message: String
    
    public enum CodingKeys: String, CodingKey {
        case message = "Message"
    }
}

extension Error {
    var wmataError: WMATAError {
        WMATAError(statusCode: 0, message: localizedDescription)
    }
}
