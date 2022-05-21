//
//  CardExtention.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//

import Foundation

extension KanjiCard {
    
    static func due() async -> [KanjiCard] {
        return await dbWorker.fetchDueKanjiCards()
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
        let interval = TimeInterval(dateDue)
        return Date(timeIntervalSince1970: interval).formatted()
    }
    
    // Return true if dateDue is between yesterday at 4am and tomorrow at 4am. E.g. grab all cards for the la
    func due() -> Bool {
        return dateDue < Date().tmrTimestamp()
    }
    
    func keyword() -> String {
        if let keyword = kanji?.keyword {
            return keyword
        }
        return "error"
    }
    
    
}
