//
//  Requests.swift
//
//
//  Created by Emma K Alexandra on 6/16/19.
//
import Combine
import Foundation
import GTFS

/// Indicates the implementors can send an HTTP request
protocol Requester {}

extension Requester {
    /// Default implementation for sending an HTTP request.
    ///
    /// - parameter request: The URLRequest to send
    /// - parameter session: Session to run URLRequest with
    /// - parameter completion: Completion handler to receive output of request.
    func request(request: URLRequest, session: URLSession, completion: @escaping (Result<Data, WMATAError>) -> Void) {
        session.dataTask(with: request) { data, _, error in
            guard let populatedData = data else {
                if let populatedError = error {
                    completion(.failure(populatedError.wmataError))

                } else {
                    completion(.failure(WMATAError(statusCode: 0, message: "Neither data or error are present from request.")))
                }

                return
            }

            completion(.success(populatedData))

        }.resume()
    }

    func request(request: URLRequest, session: URLSession) {
        session.dataTask(with: request).resume()
    }
}

/// Indicates the implementor can request and deserialize data
protocol Fetcher: Requester, Deserializer {}

extension Fetcher {
    /// Default implementation for requesting and deserializing data
    func fetch<T: Codable>(request: URLRequest, session: URLSession, completion: @escaping (Result<T, WMATAError>) -> Void) {
        self.request(request: request, session: session) { result in
            switch result {
            case let .success(data):
                completion(self.deserialize(data))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension Fetcher {
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    func publisher<T: Codable>(request: URLRequest, session: URLSession) -> AnyPublisher<T, WMATAError> {
        session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}

protocol GTFSRTFetcher: Requester, GTFSDeserializer {}

extension GTFSRTFetcher {
    func fetch(request: URLRequest, session: URLSession, completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        self.request(request: request, session: session) { result in
            switch result {
            case let .success(data):
                completion(self.deserialize(data))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension GTFSRTFetcher {
    func publisher(request: URLRequest, session: URLSession) -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { try TransitRealtime_FeedMessage(serializedData: $0.data) }
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}
