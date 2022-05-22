//
//  SM2Algo.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI
import CoreData

struct SM2Algo {
    
    static let DayInSeconds: Int32 = 86400
    static let WeekInSeconds: Int32 = 86400 * 6
//    static let TodaysTimestamp = Int32(Date().timeIntervalSince1970)
    private static let OneDay = {
        SM2Algo.DayInSeconds + SM2Algo.TodaysTimestamp()
    }
    private static let OneWeek = {
        SM2Algo.WeekInSeconds + SM2Algo.TodaysTimestamp()
    }
    private static let DefaultQ: Double = 5
    
    private static func TodaysTimestamp() -> Int32 {
        return Int32(Date().timeIntervalSince1970)
    }
    
    public static func UpdateCard(card: KanjiCard, success: Bool) {
        if success {
            switch card.repStreak {
            case 0: card.dateDue = SM2Algo.OneDay()
            case 1: card.dateDue = SM2Algo.OneWeek()
            default:
                card.dateDue = (SM2Algo.DayInSeconds * Int32(card.easinessFactor)) + SM2Algo.TodaysTimestamp()
            }
            
            card.easinessFactor = CalcEF(ef: card.easinessFactor, q: SM2Algo.DefaultQ)
            card.repsSuccessful += 1
            card.repStreak += 1
        
        } else /* failed */ {
            print("Failing Card at \(Date().formatted())")
            card.dateDue = Int32(Date().timeIntervalSince1970) + 60 // Plus 1 minute
            card.repStreak = 0
//            card.easinessFactor = CalcEF(ef: card.easinessFactor, q: 0)
        }
        
        card.repCount += 1
        card.dateLastReviewed = Date.now
        
        print("Saving card: \(card.keyword()). SM2Algo#UpdateCard")
        print("Card's due date became: \(card.dateDueString())")
        persistenceController.save()
    }
    
    private static func CalcEF(ef: Double, q: Double) -> Double {
        let easeSetting = 5 - q
        var calc = ef + (0.1 - easeSetting * (0.08 + easeSetting * 0.02))
        if calc > 1.3 { calc = 1.3 }
        return calc
    }
    
}
