//
//  Endpoint.swift
//  
//
//  Created by Emma on 11/4/21.
//

import Foundation
import Combine
import GTFS

protocol Endpoint {
    associatedtype Response
    
    /// Endpoint URL for the Request
    var url: URLComponents { get }
    
    /// WMATA API Key for this request
    var key: APIKey { get }
    
    var delegate: EndpointDelegate? { get set }
    
    /// The query items to attach to the URL
    func queryItems() -> [URLQueryItem?]
    
    func request(with session: URLSession, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void)
    
    func publisher(with session: URLSession) -> AnyPublisher<Response, WMATAError>
}

extension Endpoint {
    func queryItems() -> [URLQueryItem?] {
        []
    }
    
    func request(with session: URLSession = .shared, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void) {
        request(with: session, completion: completion)
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        publisher(with: session)
    }
    
    func url(with queryItems: [URLQueryItem?]) -> URL? {
        var components = self.url
        components.queryItems = queryItems.withoutNil()
        
        return components.url
    }
    
    func request() -> URLRequest? {
        guard let url = url(with: queryItems()) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "api_key")
        
        return request
    }
}

// Standard API
extension Endpoint {
    /// Default implemention for deserialize.
    ///
    /// - Parameters:
    ///     - data: Data to deserialize
    ///
    /// - Returns: Result container the deserialized data, or an error
    private func decode(_ data: Data) -> Result<Response, WMATAError>
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

    // TODO: Allow rethrows
    func request(with session: URLSession = .shared, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void)
    where
        Response: Codable
    {
        guard let request = request() else {
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
            
            let decodedData: Result<Response, WMATAError> = decode(data)
            
            switch decodedData {
            case let .success(response):
                completion(.success(response))
            case let .failure(decodeError):
                completion(.failure(decodeError))
            }
        }.resume()
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError>
    where
        Response: Codable
    {
        guard let request = request() else {
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

// GTFS-RT
extension Endpoint {
    private func decode(_ data: Data) -> Result<Response, WMATAError>
    where
        Response == TransitRealtime_FeedMessage
    {
        do {
            return .success(try TransitRealtime_FeedMessage(serializedData: data))

        } catch {
            return .failure(error.wmataError)
        }
    }
    
    func request(with session: URLSession = .shared, completion: @escaping (Result<Response, WMATAError>) -> Void)
    where
        Response == TransitRealtime_FeedMessage
    {
        guard let request = request() else {
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
            
            let decodedData: Result<TransitRealtime_FeedMessage, WMATAError> = decode(data)
            
            switch decodedData {
            case let .success(response):
                completion(.success(response))
            case let .failure(decodeError):
                completion(.failure(decodeError))
            }
        }.resume()
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError>
    where
        Response == TransitRealtime_FeedMessage
    {
        guard let request = request() else {
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

internal protocol OnlyJSONEndpoint: Endpoint {}

internal extension OnlyJSONEndpoint {
    func queryItems() -> [URLQueryItem?] {
        [URLQueryItem(name: "contentType", value: "json")]
    }
}

class EndpointDelegate: NSObject, URLSessionDataDelegate {
    
}
