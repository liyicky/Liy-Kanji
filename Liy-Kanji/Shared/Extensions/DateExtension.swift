//
//  DateExtension.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//
//  Vishal Vaghasiya https://stackoverflow.com/questions/35700281/date-format-in-swift

import Foundation

// MARK: - Formatted String Date
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

extension Date {
    
    enum ExtractDateError: Error {
        case failedToExtractDateFromString
    }
    
    func extractTime(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getYearFrom(_ date: Date) throws -> Int {
        if let year = Int(extractTime(date: date, format: "yyyy")) {
            return year
        }
        throw ExtractDateError.failedToExtractDateFromString
    }
    
    func getDayFrom(_ date: Date) throws -> Int {
        if let day = Int(extractTime(date: date, format: "dd")) {
            return day
        }
        throw ExtractDateError.failedToExtractDateFromString
    }
    
    func getMonthFrom(_ date: Date) throws -> Int {
        if let month = Int(extractTime(date: date, format: "MM")) {
            return month
        }
        throw ExtractDateError.failedToExtractDateFromString
    }
}

extension Date {
    
    enum Get4amDateError: Error {
        case calendarFailedToReturnDate
    }
    
    func get4amOn(date: Date) -> Date? {
        let cal = Calendar.current
        let components = DateComponents(
            year: try? getYearFrom(date),
            month: try? getMonthFrom(date),
            day: try? getDayFrom(date),
            hour: 4
        )
        return cal.date(from: components)
    }
    
    func yesterdayAt4am() throws -> Date {
        if let date = get4amOn(date: Date().dayBefore) {
            return date
        }
        throw Get4amDateError.calendarFailedToReturnDate
    }
    
    func tomorrowAt4am() throws -> Date {
        if let date = get4amOn(date: Date().dayAfter) {
            return date
        }
        throw Get4amDateError.calendarFailedToReturnDate
    }
    
    func ydaTimestamp() -> Int {
        do {
            return try Int(yesterdayAt4am().timeIntervalSince1970)
        } catch {
            print("Cannot get the time for yesterday at 4am")
            fatalError()
        }
    }

    func tmrTimestamp() -> Int {
        do {
            return try Int(tomorrowAt4am().timeIntervalSince1970)
        } catch {
            print("Cannot get the time for tomorrow at 4am")
            fatalError()
        }
    }
    
}
