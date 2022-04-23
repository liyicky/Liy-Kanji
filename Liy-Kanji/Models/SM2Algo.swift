//
//  SM2Algo.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI
import CoreData

struct SM2Algo {
    
    private static let DayInSeconds: Int32 = 86400
    private static let WeekInSeconds: Int32 = 86400 * 6
    private static let timestampToday: Int = Int(NSDate().timeIntervalSince1970)
    private static let DefaultQ: Int = 5
    
    public static func UpdateCard(card: FetchedResults<Card>.Element, success: Bool, context: NSManagedObjectContext) {
        if success {
            switch card.repititionNumber {
            case 0: card.interval = self.DayInSeconds
            case 1: card.interval = self.WeekInSeconds
            default:
                card.interval = self.DayInSeconds * Int32(card.easinessFactor)
            }
            
            card.easinessFactor = CalcEF(ef: card.easinessFactor, q: self.DefaultQ)
            card.repititionNumber += 1
            
            
        } else {
            card.repititionNumber = 0
            card.interval = self.DayInSeconds
            card.easinessFactor = CalcEF(ef: card.easinessFactor, q: 0)
        }
    
        do {
            try context.save()
        } catch {
            print("Card #\(card.id) couldn't be created \(error)")
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
