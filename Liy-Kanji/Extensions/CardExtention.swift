//
//  CardExtention.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//

import Foundation

extension Card {
    
    
    func intervalInDays() -> Int {
        return Int(interval / 86400)
    }
    
    func dateCreatedString() -> String {
        if let date = dateCreated {
            return date.getFormattedDate(format: "dd/MM/yyyy")
        } else {
            print("Date couldn't be parsed Card#dateCreatedString")
            return "-"
        }
    }
    
    func dateLastReviewedString() -> String {
        if let date = dateLastReviewed {
            return date.getFormattedDate(format: "dd/MM/yyyy")
        } else {
            print("Date couldn't be parsed Card#dateCreatedString")
            return "-"
        }
    }
    
    func dateDueString() -> String {
        if let date = dateLastReviewed {
            
            var dateComponent = DateComponents()
            dateComponent.day = intervalInDays()
            let dueDate = Calendar.current.date(byAdding: dateComponent, to: date)
            
            return dueDate!.getFormattedDate(format: "dd/MM/yyyy")
        } else {
            print("Date couldn't be parsed: Card#dateDueString")
            return "-"
        }
    }
}