//
//  WMATA.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//
import Foundation

/// Indicates the implementor has a WMATA API key
protocol ApiKey {
    func apiKey() -> String
}

/// Indicates the implementor has a URLSession
protocol Session {
    func session() -> URLSession
}

/// Incidates the implementors can deserialize data
protocol Deserializer {
    func deserialize<T: Codable>(_ data: Data) -> Result<T, WMATAError>
}

extension Deserializer {
    /// Default implemention for deserialize.
    ///
    /// - parameter data: Data to deserialize
    /// - returns: Result container the deserialized data, or an error
    func deserialize<T: Codable>(_ data: Data) -> Result<T, WMATAError> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
            
        } catch {
            do {
                return .failure(try JSONDecoder().decode(WMATAError.self, from: data))
                
            } catch {
                return .failure(error.toWMATAError())
                
            }
            
        }
        
    }
    
}

/// Indicates the implementors can send an HTTP request
protocol Requester: Session {
    func request(with request: URLRequest, completion: @escaping (Result<Data, WMATAError>) -> ())
    
}

extension Requester {
    /// Default implementation for sending an HTTP request.
    ///
    /// - parameter request: The URLRequest to send
    /// - parameter completion: Completion handler to receive output of request.
    func request(with request: URLRequest, completion: @escaping (Result<Data, WMATAError>) -> ()) {
        
        self.session().dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                if let populatedError = error {
                    completion(.failure(populatedError.toWMATAError()))
                    
                } else {
                    completion(.failure(WMATAError(statusCode: 0, message: "Neither data or error are present from request.")))
                    
                }
                
                return
            }
            
            completion(.success(populatedData))
            
        }.resume()
        
    }
    
}

/// Indicates the implementor can request and deserialize data
protocol Fetcher: Requester, Deserializer {
    func fetch<T: Codable>(with urlRequest: URLRequest, completion: @escaping (Result<T, WMATAError>) -> ())
}

extension Fetcher {
    /// Default implementation for requesting and deserializing data
    func fetch<T: Codable>(with urlRequest: URLRequest, completion: @escaping (Result<T, WMATAError>) -> ()) {
        request(with: urlRequest) { (result) in
            switch result {
            case .success(let data):
                completion(self.deserialize(data))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
}

/// Incidates the implmentor can build a URLRequest
protocol RequestBuilder: ApiKey {
    func buildRequest(fromUrl url: String, andQueryItems queryItems: [(String, String)]) -> URLRequest
    
}

extension RequestBuilder {
    /// Default implemention of buildRequest.
    ///
    /// - parameter url: URL to request
    /// - parameter queryItems: Query parameters for request
    /// - returns: A URLRequest
    func buildRequest(fromUrl url: String, andQueryItems queryItems: [(String, String)]) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = queryItems.compactMap { URLQueryItem(name: $0, value: $1) }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey(), forHTTPHeaderField: "api_key")
        
        return request
        
    }
    
}
