//
//  DailyStateExtenions.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/26.
//

import Foundation
import SwiftUICalendar

extension DailyState {
    
    public static func allDailyStates() -> [DailyState] {
        return []
    }
    
    func date() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    func yearMonthDay() -> YearMonthDay? {
        if let year = try? date().getYear(), let month = try? date().getMonth(), let day = try? date().getDay() {
            
            return YearMonthDay(year: year, month: month, day: day)
        }
        return nil
    }
}
