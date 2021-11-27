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
        } catch is BinaryDecodingError {
            return .failure(.decodingGTFSError)
        } catch {
            return .failure(.unknown(underlyingError: error))
        }
    }
    
    func decode<Response>(standard data: Data) -> Result<Response, WMATAError>
    where
        Response: Codable
    {
        do {
            let decodedObject = try WMATAJSONDecoder().decode(Response.self, from: data)
            return .success(decodedObject)
        } catch let DecodingError.keyNotFound(codingKey, context) {
            // Indicates the API returns an error message
            let errorMessage = try? JSONDecoder().decode(WMATAError.Message.self, from: data)
            
            guard let errorMessage = errorMessage else {
                return .failure(.decodingError(codingKey, context))
            }
            
            return .failure(.errorResponse(message: errorMessage))
            
        } catch {
            return .failure(.unknown(underlyingError: error))
        }
    }
}
