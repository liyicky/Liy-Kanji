//
//  SM2Algo.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI
import CoreData

struct SM2Algo {
    
    static let DayInSeconds: Int64 = 86400
    static let WeekInSeconds: Int64 = 86400 * 6
    static let TodaysTimestamp = Int64(NSDate().timeIntervalSince1970)
    private static let OneDay = {
        SM2Algo.DayInSeconds + SM2Algo.TodaysTimestamp
    }
    private static let OneWeek = {
        SM2Algo.WeekInSeconds + SM2Algo.TodaysTimestamp
    }
    private static let DefaultQ: Int = 5
    
    public static func UpdateCard(card: KanjiCard, success: Bool, context: NSManagedObjectContext) {
        if success {
            switch card.repCount {
            case 0: card.interval = SM2Algo.OneDay()
            case 1: card.interval = SM2Algo.OneWeek()
            default:
                card.interval = (SM2Algo.DayInSeconds * Int64(card.easinessFactor)) + SM2Algo.TodaysTimestamp
            }
            
            card.easinessFactor = CalcEF(ef: card.easinessFactor, q: SM2Algo.DefaultQ)
            card.repCount += 1
            
            
        } else {
            card.repCount = 0
            card.interval = SM2Algo.OneDay()
            card.easinessFactor = CalcEF(ef: card.easinessFactor, q: 0)
        }
        
        card.dateLastReviewed = Date.now
    
        do {
            print("Saving card. SM2Algo#UpdateCard")
            try context.save()
        } catch {
            print("Card #\(card.id) couldn't be updated \(error)")
        }
    }
    
    private static func CalcEF(ef: Double, q: Int) -> Double {
        var ef = ef
        let q = Double(q)
        let easeSetting: Double = Double(5 - q)
        let calc: Double = ef + (0.1 - easeSetting * (0.08 + easeSetting * 0.02))
        if ef > 1.3 { ef = 1.3 }
        return calc.rounded()
    }
    
}
