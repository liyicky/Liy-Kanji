//
//  DBWorker.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/24.
//

import CoreData

// MARK: - DATABASE WORKER
@globalActor
actor DBWorker {
    static let shared = DBWorker()
    private var context: NSManagedObjectContext!
    
    enum DBWorkerError: Error {
        case failedToFetch
        case custom(error: Error)
    }
    
    init() {
        context = persistenceController.context
    }
    
    func setMoc(_ moc: NSManagedObjectContext) {
        context = moc
    }
    
    func sync() async {
        for model in cardDataModels {

            // Save Kanji
            let kanjiEntity = Kanji(context: self.context)
            kanjiEntity.kanjiId = Int16(model.id)
            kanjiEntity.character = model.kanji
            kanjiEntity.keyword = model.keyword
            kanjiEntity.onyomi1 = model.onyomi[safe: 0]
            kanjiEntity.onyomi2 = model.onyomi[safe: 1]
            kanjiEntity.kunyomi1 = model.kunyomi[safe: 0]
            kanjiEntity.kunyomi1 = model.kunyomi[safe: 1]
            kanjiEntity.exampleInKanji = model.exampleWords[0]
            kanjiEntity.exampleInKana = model.exampleWords[1]
            kanjiEntity.exampleInEnglish = model.exampleWords[2]

            // Save Radicals & KanjiRadical relationship table
            for radical in model.radicals {
                let radicalEntity = Radical(context: self.context)
                radicalEntity.keyword = radical
                radicalEntity.addToKanji(kanjiEntity)
            }
        }
        print("Kanji Sync Successful")
    }
    
    func fetch(request: NSFetchRequest<NSFetchRequestResult>, predicate: NSPredicate? = nil, sortBy: [NSSortDescriptor]? = nil) -> Any? {
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        if let sortBy = sortBy {
            request.sortDescriptors = sortBy
        }
        
        do {
            let results = try self.context.fetch(request)
            return results
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
}

// MARK: - KANJI ENTITIES
extension DBWorker {
    
    func fetchAllKanji() -> [Kanji] {
        if let kanji = fetch(request: Kanji.fetchRequest(), sortBy: [NSSortDescriptor(key: "kanjiId", ascending: true)]) as? [Kanji] {
            return kanji
        }
        return []
    }
    
    func fetchCurrentIndex() -> String {
        return String(AppManager.shared.appState.currentKanjiIndex)
    }
    
    func fetchCurrentKanji() throws -> Kanji? {
        let results = fetch(request: Kanji.fetchRequest(), predicate: NSPredicate(format: "kanjiId == %@", fetchCurrentIndex())) as? [Kanji]
        if let result = results?.first {
            return result
        }
        
        throw DBWorkerError.failedToFetch
    }
    
    func fetchKanjiWithKeyword(_ keyword: String) -> Kanji? {
        let results = fetch(request: Kanji.fetchRequest(), predicate: NSPredicate(format: "keyword == %@", keyword)) as? [Kanji]
        if let result = results?.first {
            return result
        }
        
        return nil
    }
    
    func fetchKanjiWithCharacter(_ character: String) -> Kanji? {
        let results = fetch(request: Kanji.fetchRequest(), predicate: NSPredicate(format: "character == %@", character)) as? [Kanji]
        if let result = results?.first {
            return result
        }
        
        return nil
    }
}

// MARK: - KANJICARD ENTITIES
extension DBWorker {
    
    func createCard(kanji: Kanji, mnemonic: String) {
        let newCard = KanjiCard(context: self.context)
        newCard.kanji = kanji
        newCard.dateCreated = Date.now
        newCard.mnemonic = mnemonic
        persistenceController.save()
    }
    
    func fetchAllKanjiCards() -> [KanjiCard] {
        if let cards = fetch(request: KanjiCard.fetchRequest()) as? [KanjiCard] {
            return cards
        }
        return []
    }
    
    func fetchDueKanjiCards() -> [KanjiCard] {
        if let cards = fetch(
            request: KanjiCard.fetchRequest(),
            predicate: NSPredicate(format: "dateDue < %@", String(Date().tmrTimestamp())),
            sortBy: [NSSortDescriptor(key: "dateDue", ascending: true)]
        ) as? [KanjiCard] {
            return cards
        }
        return []
    }
    
    func fetchDueTmrKanjiCards() -> [KanjiCard] {
        if let cards = fetch(
            request: KanjiCard.fetchRequest(),
            predicate: NSPredicate(
                format: "dateDue > %@ AND dateDue < %@",
                argumentArray: [
                    String(Date().tmrTimestamp()), // The card is due after "tonight" at 4am
                    String(Date().twoDaysFromNowTimestamp()) // And the card is due before "tomorrow night" at 4am
                ]
            ),
            sortBy: [NSSortDescriptor(key: "dateDue", ascending: true)]
        ) as? [KanjiCard] {
            return cards
        }
        return []
    }
    
    /*
    func fetchCardWithId(_ id: Int) -> KanjiCard? {
        if let results = fetch(request: KanjiCard.fetchRequest(), format: "id == %@", arg: id) as? [KanjiCard] {
            return results.first
        }

        print("Could not fetch card with id: #\(id)")
        return nil
    }
    */
    
}

// MARK: - RADICAL ENTITIES
extension DBWorker {
    
    func fetchRadicalEntityWith(keyword: String) -> Radical? {
        if let results = fetch(request: Radical.fetchRequest(), predicate: NSPredicate(format: "keyword == %@", keyword)) as? [Radical] {
            return results.first
        }
        return nil
    }
}

// MARK: - APPSTATE ENTITIES
extension DBWorker {
    
    func fetchAppState() -> AppState {
        if let results = fetch(request: AppState.fetchRequest()) as? [AppState] {
            if let appState = results.first {
                return appState
            }
        }
        return createAppState()
    }
    
    func createAppState() -> AppState {
        let appState = AppState(context: self.context)
        persistenceController.save()
        return appState
    }
}

// MARK: - DAILYSTATE ENTITIES
extension DBWorker {
    
    func fetchDailyState() -> DailyState {
        if let results = fetch(request: DailyState.fetchRequest(), predicate: NSPredicate(format: "timestamp == %@", String(Date().todaysTimestamp()))) as? [DailyState] {
            if let dailyState = results.first {
                return dailyState
            }
        }
        return createDailyState()
    }
    
    func fetchAllDailyStates() -> [DailyState] {
        if let states = fetch(request: DailyState.fetchRequest()) as? [DailyState] {
            return states
        }
        return []
    }
    
    func createDailyState() -> DailyState {
        let dailyState = DailyState(context: self.context)
        dailyState.appState = AppManager.shared.appState
        dailyState.timestamp = Int32(Date().todaysTimestamp())
        persistenceController.save()
        return dailyState
    }
}
