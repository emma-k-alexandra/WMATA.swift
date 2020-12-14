//
//  Date.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

public struct WMATADate {
    public let year: Int
    public let month: Int
    public let day: Int
}

extension WMATADate: CustomStringConvertible {
    public var description: String {
        String(format: "%04d-%02d-%02d", year, month, day)
    }
}

let FORMAT = "yyyy-MM-dd'T'HH:mm:ss"

extension String {
    func toWMATADate() throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = FORMAT
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!
        guard let date = formatter.date(from: self) else {
            throw WMATAError(statusCode: 0, message: "Date provided not valid")
        }

        return date
    }
}

extension Date {
    func toWMATAString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = FORMAT
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!

        return formatter.string(from: self)
    }
}

extension Date {
    func weekdaySaturdayOrSunday() -> WeekdaySaturdayOrSunday {
        let weekday = Calendar(identifier: .gregorian).component(.weekday, from: self)
        if weekday == 1 {
            return .sunday

        } else if weekday > 1, weekday < 7 {
            return .weekday

        } else {
            return .saturday
        }
    }
}

enum WeekdaySaturdayOrSunday {
    case weekday
    case saturday
    case sunday
}
