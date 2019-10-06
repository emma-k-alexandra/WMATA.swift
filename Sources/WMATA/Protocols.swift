//
//  WMATA.swift
//  
//
//  Created by Emma Foster on 6/16/19.
//
import Foundation

protocol ApiKey {
    func apiKey() -> String
}

protocol Session {
    func session() -> URLSession
}

protocol Deserializer {
    func deserialize<T: Codable>(_ data: Data) -> Result<T, WMATAError>
}

extension Deserializer {
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

protocol Requester: Session {
    func request(with request: URLRequest, completion: @escaping (Result<Data, WMATAError>) -> ())
    
}

extension Requester {
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

protocol Fetcher: Requester, Deserializer {
    func fetch<T: Codable>(with urlRequest: URLRequest, completion: @escaping (Result<T, WMATAError>) -> ())
}

extension Fetcher {
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

protocol RequestBuilder: ApiKey {
    func buildRequest(fromUrl url: String, andQueryItems queryItems: [(String, String)]) -> URLRequest
    
}

extension RequestBuilder {
    func buildRequest(fromUrl url: String, andQueryItems queryItems: [(String, String)]) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = queryItems.compactMap { URLQueryItem(name: $0, value: $1) }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey(), forHTTPHeaderField: "api_key")
        
        return request
        
    }
    
}
