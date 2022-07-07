//
//  Decoding.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import SwiftProtobuf

/// Protocol for decoding responses from WMATA's API
public protocol WMATADecoding {
    /// Decode response from the GTFS API.
    ///
    /// For creating your own decoders, see <doc:AdvancedDecoding>.
    func decode(gtfs data: Data) -> Result<TransitRealtime_FeedMessage, WMATAError>
    
    /// Decode responses from the Standard API.
    ///
    /// For creating your own decoders, see <doc:AdvancedDecoding>.
    func decode<Response>(standard data: Data) -> Result<Response, WMATAError> where Response: Codable
}

public extension WMATADecoding {
    func decode(gtfs data: Data) -> Result<TransitRealtime_FeedMessage, WMATAError> {
        do {
            return .success(try TransitRealtime_FeedMessage(serializedData: data))
        } catch {
            return .failure(.decodingGTFSError(underlyingError: error))
        }
    }
    
    func decode<Response>(standard data: Data) -> Result<Response, WMATAError>
    where
        Response: Codable
    {
        do {
            return .success(try WMATAJSONDecoder().decode(Response.self, from: data))
        } catch let DecodingError.keyNotFound(codingKey, context) {
            return .failure(.decodingError(codingKey, context))
        } catch {
            return .failure(.unknown(underlyingError: error))
        }
    }
}
