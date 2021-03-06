//
//  Deserialize.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation
import GTFS

/// Incidates the implementors can deserialize data
protocol Deserializer {}

extension Deserializer {
    /// Default implemention for deserialize.
    ///
    /// - Parameters:
    ///     - data: Data to deserialize
    ///
    /// - Returns: Result container the deserialized data, or an error
    func deserialize<T: Codable>(_ data: Data) -> Result<T, WMATAError> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))

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

protocol GTFSDeserializer {}

extension GTFSDeserializer {
    func deserialize(_ data: Data) -> Result<TransitRealtime_FeedMessage, WMATAError> {
        do {
            return .success(try TransitRealtime_FeedMessage(serializedData: data))

        } catch {
            return .failure(error.wmataError)
        }
    }
}
