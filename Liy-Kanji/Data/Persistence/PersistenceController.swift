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
