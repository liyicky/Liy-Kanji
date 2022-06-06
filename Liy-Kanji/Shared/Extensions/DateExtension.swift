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
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getYear() throws -> Int {
        if let year = Int(self.toString(format: "yyyy")) {
            return year
        }
        throw ExtractDateError.failedToExtractDateFromString
    }
    
    func getDay() throws -> Int {
        if let day = Int(self.toString(format: "dd")) {
            return day
        }
        throw ExtractDateError.failedToExtractDateFromString
    }
    
    func getMonth() throws -> Int {
        if let month = Int(self.toString(format: "MM")) {
            return month
        }
        throw ExtractDateError.failedToExtractDateFromString
    }
}

extension Date {
    
    enum Get4amDateError: Error {
        case calendarFailedToReturnDate
    }
    
    func get4am() -> Date? {
        let cal = Calendar.current
        let components = DateComponents(
            year: try? self.getYear(),
            month: try? self.getMonth(),
            day: try? self.getDay(),
            hour: 4
        )
        return cal.date(from: components)
    }
    
    // If today is May 25, returns "May 24, 2022 at 4:00 AM"
    func yesterdayAt4am() throws -> Date {
        if let date = self.dayBefore.get4am() {
            return date
        }
        throw Get4amDateError.calendarFailedToReturnDate
    }
    
    // If today is May 25, returns "May 25, 2022 at 4:00 AM"
    func todayAt4am() throws -> Date {
        if let date = self.get4am() {
            return date
        }
        throw Get4amDateError.calendarFailedToReturnDate
    }
    
    // If today is May 25, returns "May 26, 2022 at 4:00 AM"
    func tomorrowAt4am() throws -> Date {
        if let date = self.dayAfter.get4am() {
            return date
        }
        throw Get4amDateError.calendarFailedToReturnDate
    }
    
    // If today is May 25, returns "May 27, 2022 at 4:00 AM"
    func twoDaysFromNowAt4am() throws -> Date {
        if let date = self.dayAfter.dayAfter.get4am() {
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
    
    func todaysTimestamp() -> Int {
        do {
            return try Int(todayAt4am().timeIntervalSince1970)
        } catch {
            print("Cannot get the time for today at 4am")
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
    
    func twoDaysFromNowTimestamp() -> Int {
        do {
            return try Int(twoDaysFromNowAt4am().timeIntervalSince1970)
        } catch {
            print("Cannot get the time for two days from now at 4am")
            fatalError()
        }
    }
}

// Hint Date Extention
extension String {
    
    func hintDateToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'-'MM'-'yyy"
        return dateFormatter.date(from: self)
    }
}
