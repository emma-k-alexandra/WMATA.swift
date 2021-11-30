//
//  Decoding.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import GTFS
import SwiftProtobuf

public protocol WMATADecoding {
    func decode(gtfs data: Data) -> Result<TransitRealtime_FeedMessage, WMATAError>
    
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
        print("Decoding into \(Response.self)", String(data: data, encoding: .utf8))
        do {
            return .success(try WMATAJSONDecoder().decode(Response.self, from: data))
        } catch let DecodingError.keyNotFound(codingKey, context) {
            return .failure(.decodingError(codingKey, context))
        } catch {
            return .failure(.unknown(underlyingError: error))
        }
    }
}
