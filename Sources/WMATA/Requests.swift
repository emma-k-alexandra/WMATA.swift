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
    // TODO: Remove
    /// Default implementation for sending an HTTP request.
    ///
    /// - Parameters:
    ///     - request: The URLRequest to send
    ///     - session: Session to run URLRequest with
    ///     - completion: A completion handler
    ///     - result: Data of response or [WMATAError](x-source-tag://WMATAError)
    func request(request: URLRequest, session: URLSession, completion: @escaping (_ result: Result<Data, WMATAError>) -> Void) {
        session.dataTask(with: request) { data, _, error in
            guard let populatedData = data else {
                if let populatedError = error {
                    completion(.failure(populatedError.wmataError))

                } else {
                    completion(
                        .failure(
                            WMATAError(
                                statusCode: 0,
                                message: "Neither data or error are present from request."
                            )
                        )
                    )
                }

                return
            }

            completion(.success(populatedData))

        }.resume()
    }

    // TODO: Remove
    func request(request: URLRequest, session: URLSession) {
        session.dataTask(with: request).resume()
    }
    
    /// Default implementation for sending an HTTP request.
    ///
    /// - Parameters:
    ///     - request: The URLRequest to send
    ///     - session: Session to run URLRequest with
    ///     - completion: A completion handler
    ///     - result: Data of response or [WMATAError](x-source-tag://WMATAError)
    func request(endpoint: Endpoint, session: URLSession, completion: @escaping (_ result: Result<Data, WMATAError>) -> Void) {
        session.dataTask(with: endpoint.request()) { data, _, error in
            guard let populatedData = data else {
                if let populatedError = error {
                    completion(.failure(populatedError.wmataError))

                } else {
                    completion(
                        .failure(
                            WMATAError(
                                statusCode: 0,
                                message: "Neither data or error are present from request."
                            )
                        )
                    )
                }

                return
            }

            completion(.success(populatedData))

        }.resume()
    }
    
    func request(endpoint: Endpoint, session: URLSession) {
        session.dataTask(with: endpoint.request()).resume()
    }
    
}

/// Indicates the implementor can request and deserialize data
protocol Fetcher: Requester, Deserializer {}

extension Fetcher {
    // TODO: Remove
    /// Default implementation for requesting and deserializing data
    func fetch<T>(request: URLRequest, session: URLSession, completion: @escaping (Result<T, WMATAError>) -> Void)
        where T: Codable {
        self.request(request: request, session: session) { result in
            switch result {
            case let .success(data):
                completion(self.deserialize(data))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    /// Default implementation for requesting and deserializing data
    func fetch<T>(endpoint: Endpoint, session: URLSession, completion: @escaping (Result<T, WMATAError>) -> Void)
        where T: Codable {
        self.request(endpoint: endpoint, session: session) { result in
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
    // TODO: Remove
    func publisher<T>(request: URLRequest, session: URLSession) -> AnyPublisher<T, WMATAError>
        where T: Codable {
        session
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: WMATAJSONDecoder())
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
    
    func publisher<T>(endpoint: Endpoint, session: URLSession) -> AnyPublisher<T, WMATAError>
        where T: Codable {
        session
            .dataTaskPublisher(for: endpoint.request())
            .map(\.data)
            .decode(type: T.self, decoder: WMATAJSONDecoder())
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}

protocol GTFSRTFetcher: Requester, GTFSDeserializer {}

extension GTFSRTFetcher {
    // TODO: Remove
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
    
    func fetch(endpoint: Endpoint, session: URLSession, completion: @escaping (Result<TransitRealtime_FeedMessage, WMATAError>) -> Void) {
        self.request(endpoint: endpoint, session: session) { result in
            switch result {
            case let .success(data):
                completion(self.deserialize(data))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


extension GTFSRTFetcher {
    // TODO: Remove
    func publisher(request: URLRequest, session: URLSession) -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { try TransitRealtime_FeedMessage(serializedData: $0.data) }
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
    
    func publisher(endpoint: Endpoint, session: URLSession) -> AnyPublisher<TransitRealtime_FeedMessage, WMATAError> {
        session
            .dataTaskPublisher(for: endpoint.request())
            .tryMap { try TransitRealtime_FeedMessage(serializedData: $0.data) }
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}
