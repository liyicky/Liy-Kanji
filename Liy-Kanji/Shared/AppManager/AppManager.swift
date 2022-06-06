//
//  AppManager.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/19.
//

import SwiftUI

class AppManager: ObservableObject {
    
    static let shared = AppManager()
    
    // MARK: - Kanji Properties
    @Published var kanji: [Kanji] = []
    @Published var currentKanji: Kanji?
    @Published var currentKanjiRadicalViews: [RadicalView] = []
    @Published var currentKanjiHints: [Hint] = []
    var reviewCards: [KanjiCard] = []
    @Published var topCard: KanjiCard? = nil
    @Published var nextCard: KanjiCard? = nil
    
    // MARK: - App State / Daily State for settings and daily progress respectively
    @Published var appState: AppState!
    @Published var dailyState: DailyState!
    @Published var dailyStates: [DailyState] = []
    
    // MARK: - Settings Properties
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
    
    func setupApp() async {
        /* Create the AppState in Core Data (Used for settings) */
        await self.setAppState()
    
        /*
         Create the DailyState in Core Data
         (Used for tracking how many reps the user did per day)
        */
        await self.setDailyState()
    
        /*
         Sync the Kanji Data Json into Core Data
        */
        await self.sync()
    
        /*
         Pull today's cards from Core Data.
         This is used in the ReviewsViewManager
        */
        await self.loadReviewCards()
        
        /*
         Pull the settings from Core Data and set them as the published state.
        */
        self.setSettingsState()
        
        /*
         Pull 2 cards out of the array and set them as Published variables.
         These are the two cards the user can see on the screen.
         */
        self.cycleCards()
        
        await self.updateCurrentKanji()
        
        /*
         Pull all Kanji from Core Data into an appwide available list.
        */
        await self.setKanjiState()
        
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
        DispatchQueue.main.async {
            switch self.reviewCards.count {
            case 0:
                self.topCard = nil
                self.nextCard = nil
            case 1:
                self.topCard = self.reviewCards.removeFirst()
                self.nextCard = nil
            default:
                self.topCard = self.reviewCards.removeFirst()
                self.nextCard = self.reviewCards.removeFirst()
            }
        }
    }
}

// MARK: - Manage Kanji for creating new cards
extension AppManager {
    
    func setKanjiState() async {
        let fetchedKanji = await DBWorker.shared.fetchAllKanji()
        for kanji in fetchedKanji {

            try? await Task.sleep(nanoseconds: 5_000_000)
            DispatchQueue.main.async {
                self.kanji.append(kanji)
            }
        }
    }
    
    func updateCurrentKanji() async {
        do {
            let nextKanji = try await DBWorker.shared.fetchCurrentKanji()
            if let nextKanji = nextKanji {
                withAnimation {
                    self.currentKanji = nextKanji
                    self.currentKanjiHints = []
                }
                self.currentKanjiRadicalViews = await nextKanji.radicalViews()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addHint() async {
        
        if let hints = await currentKanji?.allHints() {
            if currentKanjiHints.count < 5 {
                withAnimation {
                    currentKanjiHints.append(hints[currentKanjiHints.count])
                }
            }
        }
    }
    
    func createCard(mnemonic: String) async {
        if let currentKanji = self.currentKanji {
            await DBWorker.shared.createCard(kanji: currentKanji, mnemonic: mnemonic)
            recordIndex()
            await updateCurrentKanji()
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
    
    func recordIndex() {
        self.appState.currentKanjiIndex += 1
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
        DispatchQueue.main.async {
            self.difficulty = self.appState.difficulty.toInt()
            self.reminderDate = self.appState.reminderDate ?? Date.now
            self.darkModeIsOn = self.appState.darkMode
            self.colorScheme = self.appState.darkMode ? ColorScheme.dark : ColorScheme.light
            self.newCardsPerDaySelection = String(self.appState.newCardsPerDay)
        }
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
