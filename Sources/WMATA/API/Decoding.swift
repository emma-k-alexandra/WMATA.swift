//
//  Decoding.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import GTFS

public protocol WMATADecoding {
    func decode(gtfs data: Data) -> Result<TransitRealtime_FeedMessage, WMATAError>
    
    func decode<Response>(standard data: Data) -> Result<Response, WMATAError> where Response: Codable
}

extension WMATADecoding {
    public func decode(gtfs data: Data) -> Result<TransitRealtime_FeedMessage, WMATAError> {
        do {
            return .success(
                try TransitRealtime_FeedMessage(serializedData: data)
            )
        } catch {
            return .failure(error.wmataError)
        }
    }
    
    public func decode<Response>(standard data: Data) -> Result<Response, WMATAError>
    where
        Response: Codable
    {
        do {
            let decodedObject = try WMATAJSONDecoder().decode(Response.self, from: data)
            return .success(decodedObject)
        } catch {
            let originalError = error

            do {
                return .failure(try JSONDecoder().decode(WMATAError.self, from: data))
            } catch {
                return .failure(originalError.wmataError)
            }
        }
    }
}
