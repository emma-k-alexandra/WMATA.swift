//
//  Date.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

extension Date: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case date = "Date"
    }
    
    func queryItem(name: URLQueryItemName = .date) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: description)
    }
    
    func queryFormat() -> String {
        DateFormatter.wmataQueryFormat.string(from: self)
    }
}

extension DateFormatter {
    static var wmataQueryFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!
        
        return formatter
    }
}
