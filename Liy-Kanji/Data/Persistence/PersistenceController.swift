//
//  PersistenceController.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import CoreData


struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Stash")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                completion(error)
            }
        }
    }
}

let persistenceController: PersistenceController = PersistenceController.shared


@globalActor
actor DBWorker {
    static let shared = DBWorker()
    private var context:NSManagedObjectContext!
    init(){
        
    }
    func setMoc(_ moc:NSManagedObjectContext){
        context = moc
    }
    func sync() async {
        // load json + store cards in db
    }
}
