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
    var appState: AppState!
    
    @Published var topCard: KanjiCard? = nil
    @Published var nextCard: KanjiCard? = nil
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
        topCard = reviewCards.removeFirst()
        nextCard = reviewCards.removeFirst()
    }
}

// Manage App State
extension AppManager {
    
    func synced() -> Bool {
        return appState.synced
    }
    
    func disableSyncing() {
        AppManager.shared.appState.synced = true
        persistenceController.save()
    }
}
