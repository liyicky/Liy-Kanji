//
//  AppManager.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/19.
//

import Foundation
import SwiftUI

class AppManager: ObservableObject {
    
    static let shared = AppManager()
    var reviewCards: [KanjiCard] = []
    
    @Published var appState: AppState!
    @Published var dailyState: DailyState!
    
    @Published var topCard: KanjiCard? = nil
    @Published var nextCard: KanjiCard? = nil
    
    @Published var dailyStates: [DailyState] = []
    
    // Settings
    @Published var difficulty = 1
    let difficulties = [1, 2, 3, 4, 5]
    @Published var reminderDate = Date.now
    @Published var darkModeIsOn = false
    @Published var colorScheme = ColorScheme.light
    @Published var newCardsPerDaySelection = ""
    
    enum AppManagerError: Error {
        case noAppState
        case noDailyState
        case custom(error: Error)
    }
    
    func sync() async {
        
        // Only Sync one time
        if self.synced() {
            return
        }
        
        await DBWorker.shared.sync()
        self.disableSyncing()
    }
}


// MARK: - ReviewView
extension AppManager {
    
    func leftSwipe() {
        print("Swipped Left")
        print("TopCard is \(topCard!.keyword()) - Due: \(topCard!.dateDueString()) - Last was Success: \(topCard!.repStreak >= 1 ? "yes" : "no")")
        print("NextCard is \(nextCard!.keyword()) - Due: \(nextCard!.dateDueString()) - Last was Success: \(nextCard!.repStreak >= 1 ? "yes" : "no")")
        print("Review Cards:")
        for (index, object) in reviewCards.enumerated() {
            print("\(index): \(object.keyword()) - Due: \(object.dateDueString()) - Last was Success: \(object.repStreak >= 1 ? "yes" : "no")")
        }
        reviewCards.append(topCard!)
        topCard = nextCard
        nextCard = reviewCards.removeFirst()
        
        print("Swipped Left Results")
        print("TopCard became \(topCard!.keyword()) - Due: \(topCard!.dateDueString()) - Last was Success: \(topCard!.repStreak >= 1 ? "yes" : "no")")
        print("NextCard became \(nextCard!.keyword()) - Due: \(nextCard!.dateDueString()) - Last was Success: \(nextCard!.repStreak >= 1 ? "yes" : "no")")
        print("Review Cards became:")
        for (index, object) in reviewCards.enumerated() {
            print("\(index): \(object.keyword()) - Due: \(object.dateDueString()) - Last was Success: \(object.repStreak >= 1 ? "yes" : "no")")
        }
        
        self.recordRepCount()
    }
    
    func rightSwipe() {
        print("Swipped Right")
        print("TopCard is \(topCard!.keyword()) - Due: \(topCard!.dateDueString()) - Last was Success: \(topCard!.repStreak >= 1 ? "yes" : "no")")
        print("NextCard is \(nextCard!.keyword()) - Due: \(nextCard!.dateDueString()) - Last was Success: \(nextCard!.repStreak >= 1 ? "yes" : "no")")
        print("Review Cards:")
        for (index, object) in reviewCards.enumerated() {
            print("\(index): \(object.keyword()) - Due: \(object.dateDueString()) - Last was Success: \(object.repStreak >= 1 ? "yes" : "no")")
        }
        topCard = nextCard
        nextCard = reviewCards.removeFirst()
        print("Swipped Right Results")
        print("TopCard became \(topCard!.keyword()) - Due: \(topCard!.dateDueString()) - Last was Success: \(topCard!.repStreak >= 1 ? "yes" : "no")")
        print("NextCard became \(nextCard!.keyword()) - Due: \(nextCard!.dateDueString()) - Last was Success: \(nextCard!.repStreak >= 1 ? "yes" : "no")")
        print("Review Cards became:")
        for (index, object) in reviewCards.enumerated() {
            print("\(index): \(object.keyword()) - Due: \(object.dateDueString()) - Last was Success: \(object.repStreak >= 1 ? "yes" : "no")")
        }
        
        self.recordRepCount()
    }
}

// MARK: - Handle Kanji Card Reviews
extension AppManager {
    
    func loadReviewCards() async {
        self.reviewCards = await KanjiCard.due()
    }
    
    func reviewCards() async -> [KanjiCard] {
        return self.reviewCards
    }
    
    func takeTopCard() -> KanjiCard {
        reviewCards.removeFirst()
    }
    
    func cycleCards() {
        
        switch reviewCards.count {
        case 0:
            topCard = nil
            nextCard = nil
        case 1:
            topCard = reviewCards.removeFirst()
            nextCard = nil
        default:
            topCard = reviewCards.removeFirst()
            nextCard = reviewCards.removeFirst()
        }
    }
}

// MARK: - Manage App State
extension AppManager {
    
    func setAppState() async {
        await self.appState = DBWorker.shared.fetchAppState()
    }
    
    func synced() -> Bool {
        return self.appState.synced
    }
    
    func disableSyncing() {
        self.appState.synced = true
        persistenceController.save()
    }
}

// MARK: - Manage Daily State
extension AppManager {
    
    func setDailyState() async {
        await self.dailyState = DBWorker.shared.fetchDailyState()
        await self.dailyStates = DBWorker.shared.fetchAllDailyStates()
    }
    
    func recordRepCount() {
        self.dailyState.repCount += 1
        persistenceController.save()
    }
}

// MARK: - Manage Settings
extension AppManager {
    
    func setSettingsState() {
        self.difficulty = appState.difficulty.toInt()
        self.reminderDate = appState.reminderDate ?? Date.now
        self.darkModeIsOn = appState.darkMode
        self.colorScheme = appState.darkMode ? ColorScheme.dark : ColorScheme.light
        self.newCardsPerDaySelection = String(appState.newCardsPerDay)
    }
    
    func updateDifficultySettingTo(_ newDifficulty: Int) {
        self.appState.difficulty = newDifficulty.toInt16()
        persistenceController.save()
        print("Difficulty changed to \(newDifficulty)")
        setSettingsState()
    }
    
    func updateReminderSettingTo(_ newTime: Date) {
        self.appState.reminderDate = newTime
        persistenceController.save()
        print("Reminder Date changed to \(newTime)")
        setSettingsState()
    }
    
    func updateDarkModeSetting() {
        self.appState.darkMode = self.darkModeIsOn
        persistenceController.save()
        print("Dark Mode is on? \(self.darkModeIsOn)")
        setSettingsState()
    }
    
    func updateNewCardPerDaySettingTo(_ newAmount: String) {
        self.appState.newCardsPerDay = newAmount == "∞" ? 2200.toInt16() : Int16(newAmount)!
        persistenceController.save()
        print("Amount of New Cards per Day changed to \(self.newCardsPerDaySelection)")
        setSettingsState()
    }
}
