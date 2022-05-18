//
//  CardExtention.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//

import Foundation

extension KanjiCard {
    
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
    
    func whenDue() -> Int64 {
        return interval - SM2Algo.TodaysTimestamp
    }
    
    func due() -> Bool {
        let due = whenDue() < 0
        return due
    }
    
    func keyword() -> String {
        if let keyword = kanji?.keyword {
            return keyword
        }
        return "error"
    }
    

    
    
}
