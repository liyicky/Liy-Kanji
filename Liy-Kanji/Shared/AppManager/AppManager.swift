//
//  AppManager.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/19.
//

import Foundation

class AppManager: ObservableObject {
    
    static let shared = AppManager()
    var reviewCards: [KanjiCard] = []
    
    @Published var repsDoneToday: Int? = nil
    
    @Published var appState: AppState!
    @Published var dailyState: DailyState!
    
    @Published var topCard: KanjiCard? = nil
    @Published var nextCard: KanjiCard? = nil
    
    
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
        self.repsDoneToday = Int(self.dailyState.repCount)
    }
}
