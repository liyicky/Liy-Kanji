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
    
    @Published var topCard: KanjiCard? = nil
    @Published var nextCard: KanjiCard? = nil
}

// ReviewView
extension AppManager {
    
    func leftSwipe() {
        print("Swipped Left")
        print("TopCard is \(topCard!.keyword())")
        print("NextCard is \(nextCard!.keyword())")
        print("Review Cards:")
        for (index, object) in reviewCards.enumerated() {
            print("Item at \(index): \(object.keyword())")
        }
        reviewCards.append(topCard!)
        topCard = nextCard
        nextCard = reviewCards.removeFirst()
        
        print("Swipped Left Results")
        print("TopCard became \(topCard!.keyword())")
        print("NextCard became \(nextCard!.keyword())")
        print("Review Cards became:")
        for (index, object) in reviewCards.enumerated() {
            print("Item at \(index): \(object.keyword())")
        }
    }
    
    func rightSwipe() {
        topCard = nextCard
        nextCard = reviewCards.removeFirst()
    }
}

// Handle Kanji Card Reviews
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
