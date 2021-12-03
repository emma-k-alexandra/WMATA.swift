//
//  WMATAError.swift
//
//
//  Created by Emma K Alexandra on 6/23/19.
//
import Foundation

/// Error type for all errors that occur with the WMATA package.
public enum WMATAError: Error {
    
    /// You received a response from the WMATA API, but it was an error
    case errorResponse(message: String)
    
    /// A 400 error from the WMATA API, bad user input
    case badRequest(message: String)
    
    /// A 401 error from WMATA API, unauthorized
    ///
    /// Typically caused by an invaid API Key. Get a key from https://developer.wmata.com
    case accessDenied(message: String)
    
    /// A 529 error from WMATA API. Too many requests sent too quickly
    ///
    /// Default rate limit for WMATA's API is 10 calls/sec and 50,000 calls/day
    case rateLimitExceeded(message: String)
    
    /// Failed to make a URLRequest for an endpoint.
    ///
    /// This typically means your API key or inputs are invalid
    case unableToCreateRequest(endpoint: String)
    
    /// Received no data or error from a request to WMATA's API
    ///
    /// This shouldn't happen in practice, if this does happen please file a report on github with logs
    case requestFailed(response: URLResponse?)
    
    /// Request to WMATA's API returned no data and gave an error
    case requestEnded(underlyingError: Error)
    
    /// When using a delegate, was unable to load a file downloaded via background session
    ///
    /// Your file may have been cleaned up, or your request failed and you should look for other logs
    case unableToLoadBackgroundFile(location: URL, underlyingError: Error)
    
    /// Your background request completed with an error
    ///
    /// See [Apple's Documentation](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate/1411610-urlsession)
    case backgroundSessionFailure(underlyingError: Error)
    
    /// Your background request became invalid while running
    ///
    /// See [Apple's Documentation](https://developer.apple.com/documentation/foundation/urlsessiondelegate/1407776-urlsession)
    case backgroundSessionBecameInvalid(underlyingError: Error)
    
    /// There was an error while decoding the response from the WMATA Standard API
    ///
    /// This shouldn't happen in practice. If you encounter this error, please file an issue on github
    case decodingError(CodingKey, DecodingError.Context)
    
    /// There was an error while decoding the response from the WMATA GTFS API
    ///
    /// This shouldn't happen in practice. If you encounter this error, please file an issue on github
    case decodingGTFSError(underlyingError: Error)
    
    /// An error occured while decoding a ``WMATAError/Message``
    ///
    /// If you encounter this error, please file an issue on github with logs
    case errorDecodingErrorMessage(underlyingError: Error)
    
    /// Some error occured within WMATA.swift
    ///
    /// If you encounter this error, please file an issue on github with logs so it can be fixed
    case unknown(underlyingError: Error)
    
    /// An error message from the WMATA  API
    struct Message: Codable, Hashable, Equatable, Error {
        /// Status code of the response. Matches the HTTP code of the response
        let statusCode: Int?
        
        /// Error message
        let message: String
        
        public enum CodingKeys: String, CodingKey {
            case statusCode
            case message = "Message"
            case alsoMessage = "message"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
            
            if let message = try container.decodeIfPresent(String.self, forKey: .message) {
                self.message = message
            } else if let message = try container.decodeIfPresent(String.self, forKey: .alsoMessage) {
                self.message = message
            } else {
                throw DecodingError.typeMismatch(
                    Self.self,
                    .init(
                        codingPath: container.codingPath,
                        debugDescription: "Key `message` or `Message` was not found in WMATAError.Message while decoding",
                        underlyingError: nil
                    )
                )
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(statusCode, forKey: .statusCode)
            try container.encode(message, forKey: .message)
        }
    }
}
