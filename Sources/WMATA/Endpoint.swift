//
//  Endpoint.swift
//  
//
//  Created by Emma on 11/4/21.
//

import Foundation
import Combine
import GTFS

public protocol Endpoint: WMATADecoding {
    /// The response WMATA sends back when calling this endpoint
    associatedtype Response
    
    /// WMATA API Key for this request
    var key: APIKey { get }
    
    /// Send an HTTP request to this endpoint
    func request(with session: URLSession, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void)
    
    /// Send an async HTTP request to this endpoint
    @available(macOS 12, iOS 15, watchOS 7, tvOS 15, *)
    func request(with session: URLSession) async -> Result<Response, WMATAError>
    
    /// Send a background HTTP request to the endpoint.
    func backgroundRequest()
    
    /// Send an HTTP request to this endpoint and receive a Combine Publisher with the response
    func publisher(with session: URLSession) -> AnyPublisher<Response, WMATAError>
    
    /// The URL this request is sent to
    ///
    /// > Note: You generally will not need this in typical usage
    var url: URLComponents { get }
}

internal extension Endpoint {
    func queryItems() -> [URLQueryItem?] {
        []
    }
    
    func url(with queryItems: [URLQueryItem?]) -> URL? {
        var components = self.url
        components.queryItems = queryItems.withoutNil()
        
        return components.url
    }
    
    func urlRequest() -> URLRequest? {
        guard let url = url(with: queryItems()) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "api_key")
        
        return request
    }
}

public protocol JSONEndpoint: Endpoint where Response: Codable {
    /// Optional. Delegate to send background requests to
    var delegate: JSONEndpointDelegate<Self>? { get set }
}

public extension JSONEndpoint {
    func backgroundRequest() {
        guard let delegate = delegate else {
            preconditionFailure("Request sent to delegate without delegate defined on endpoint \(String(describing: self))")
        }
        
        guard let request = urlRequest() else {
            delegate.received(
                .failure(.init(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                ))
            )
            return
        }
        
        delegate.session.downloadTask(with: request).resume()
    }
    
    // TODO: Allow rethrows
    func request(with session: URLSession = .shared, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void) {
        guard let request = urlRequest() else {
            completion(.failure(.init(
                statusCode: 1,
                message: "Unable to create URLRequest for endpoint \(String(describing: self))"
            )))
            return
        }
        
        session.dataTask(with: request) { data, _response, error in
            guard let data = data else {
                guard let error = error else {
                    completion(
                        .failure(
                            .init(
                                statusCode: 3,
                                message: "Neither data or error are present in response"
                            )
                        )
                    )
                    return
                }
                
                completion(.failure(error.wmataError))
                return
            }
            
            completion(decode(standard: data))
        }.resume()
    }
    
    @available(macOS 12, iOS 15, watchOS 7, tvOS 15, *)
    func request(with session: URLSession = .shared) async -> Result<Response, WMATAError> {
        guard let request = urlRequest() else {
            return .failure(.init(
                statusCode: 1,
                message: "Unable to create URLRequest for endpoint \(String(describing: self))"
            ))
        }
        
        do {
            let (data, _) = try await session.data(for: request)
            
            return decode(standard: data)
        } catch {
            return .failure(error.wmataError)
        }
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        guard let request = urlRequest() else {
            return Fail(
                error: WMATAError(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                )
            ).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Response.self, decoder: WMATAJSONDecoder())
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}

public protocol GTFSEndpoint: Endpoint where Response == TransitRealtime_FeedMessage {
    /// Optional. Delegate to send background requests to
    var delegate: GTFSEndpointDelegate<Self>? { get set }
}

// GTFS-RT
public extension GTFSEndpoint {
    func backgroundRequest() {
        guard let delegate = delegate else {
            preconditionFailure("Request sent to delegate without delegate defined on endpoint \(String(describing: self))")
        }
        
        guard let request = urlRequest() else {
            delegate.received(
                .failure(.init(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                ))
            )
            return
        }
        
        delegate.session.downloadTask(with: request).resume()
    }
    
    func request(with session: URLSession = .shared, completion: @escaping (Result<Response, WMATAError>) -> Void) {
        guard let request = urlRequest() else {
            completion(.failure(.init(statusCode: 1, message: "Unable to create URLRequest for endpoint \(String(describing: self))")))
            return
        }
        
        session.dataTask(with: request) { data, _response, error in
            guard let data = data else {
                guard let error = error else {
                    completion(.failure(.init(statusCode: 3, message: "Neither data or error are present in response")))
                    return
                }
                
                completion(.failure(error.wmataError))
                return
            }
            
            let decodedData: Result<TransitRealtime_FeedMessage, WMATAError> = decode(gtfs: data)
            
            switch decodedData {
            case let .success(response):
                completion(.success(response))
            case let .failure(decodeError):
                completion(.failure(decodeError))
            }
        }.resume()
    }
    
    @available(macOS 12, iOS 15, watchOS 7, tvOS 15, *)
    func request(with session: URLSession = .shared) async -> Result<Response, WMATAError> {
        guard let request = urlRequest() else {
            return .failure(.init(
                statusCode: 1,
                message: "Unable to create URLRequest for endpoint \(String(describing: self))"
            ))
        }
        
        do {
            let (data, _) = try await session.data(for: request)
            
            return decode(gtfs: data)
        } catch {
            return .failure(error.wmataError)
        }
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        guard let request = urlRequest() else {
            return Fail(
                error: WMATAError(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                )
            ).eraseToAnyPublisher()
            
        }
            
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try TransitRealtime_FeedMessage(serializedData: $0.data) }
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}
