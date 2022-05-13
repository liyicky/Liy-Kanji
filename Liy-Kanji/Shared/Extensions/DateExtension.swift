//
//  DateExtension.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//
//  Vishal Vaghasiya https://stackoverflow.com/questions/35700281/date-format-in-swift

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
