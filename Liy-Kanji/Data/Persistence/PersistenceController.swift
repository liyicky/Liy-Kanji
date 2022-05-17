//
//  PersistenceController.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import CoreData
import SwiftUI

// MARK: - GLOBAL SINGLETONS
let persistenceController: PersistenceController = PersistenceController.shared
let dbWorker: DBWorker = DBWorker.shared


// MARK: - CORE DATA MANAGER, aka PERSISTENCE CONTROLLER
struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Stash")
        context = container.viewContext
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.loadPersistentStores { (description, error) in
            
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        if context.hasChanges {
            do {
                try context.save()
                print("Core Data saved!")
            } catch {
                completion(error)
            }
        }
    }
}

// MARK: - DATABASE WORKER
@globalActor
actor DBWorker: ObservableObject {
    static let shared = DBWorker()
    private var context: NSManagedObjectContext!
    
    @Published var kanjiCards: [KanjiCard] = []
    
    init() {
        context = persistenceController.context
    }
    
    func setMoc(_ moc: NSManagedObjectContext) {
        context = moc
    }
    
    func sync() async {
        for model in cardDataModels {
            print("Saving \(model.kanji)")

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
            
//          Save Radicals & KanjiRadical relationship table
            for radical in model.radicals {
                let radicalEntity = Radical(context: self.context)
                radicalEntity.keyword = radical
                radicalEntity.addToKanji(kanjiEntity)
            }
        }
        persistenceController.save()
    }
    
    func fetch(request: NSFetchRequest<NSFetchRequestResult>, predicate: NSPredicate) -> Any? {
        request.predicate = predicate
        
        do {
            let results = try self.context.fetch(request)
            return results
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func fetchRadicalEntityWith(keyword: String) -> Radical? {
        if let results = fetch(request: Radical.fetchRequest(), predicate: NSPredicate(format: "keyword == %@", keyword)) as? [Radical] {
            return results.first
        }
        return nil
    }
    
    func fetchAllKanjiCards() {
        let request = KanjiCard.fetchRequest()
        
        do {
            kanjiCards = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
//    func fetchCardWithId(_ id: Int) -> KanjiCard? {
//        if let results = fetch(request: KanjiCard.fetchRequest(), format: "id == %@", arg: id) as? [KanjiCard] {
//            return results.first
//        }
//
//        print("Could not fetch card with id: #\(id)")
//        return nil
//    }
    
    // MARK: - Card Logic: Creating
    
    func createCard(kanji: Kanji, mnemonic: String) {
        let newCard = KanjiCard(context: self.context)
        newCard.kanji = kanji
        newCard.dateCreated = Date.now
        newCard.interval = 0
        newCard.mnemonic = mnemonic
        newCard.repCount = 0
        newCard.repsSuccessful = 0
//        newCard.dateLastReviewed = Date.now
        
        do {
            try self.context.save()
        } catch {
            print("New Card couldn't be created \(error)")
        }
    }

}
