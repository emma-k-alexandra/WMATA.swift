//
//  Line.swift
//  
//
//  Created by Emma Foster on 6/17/19.
//
import Foundation

public class Line {
    /// Line codes as defined by WMATA
    enum Code: String {
        case RD
        case BL
        case YL
        case OR
        case GR
        case SV
    }
    
    /// URLs of WMATA endpoints relating to lines
    enum Urls: String {
        case stations = "https://api.wmata.com/Rail.svc/json/jStations"
    }
    
    /// WMATA API key from dev portal
    var apiKey: String
    
    /// The Line this object refers to
    var line: Line.Code
    
    /// URLSession to use for all requests
    var session: URLSession
    
    private let decoder = JSONDecoder()
    
    /// Set up Station
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter code: Line to point this object at
    /// - parameter session: Session to call on requests on
    init(apiKey: String, line: Line.Code, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.line = line
        self.session = session
        
    }
    
    /// Stations along a Line
    ///
    /// - parameter line: Line to receive stations along.
    /// - parameter completion: Completion handler which returns `Stations`
    func stations(completion: @escaping (_ result: Stations?, _ error: WMATAError?) -> ()) {
        Rail(apiKey: self.apiKey, session: self.session).stations(for: self.line, completion: completion)
        
    }
    
}
