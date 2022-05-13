//
//  Liy_KanjiApp.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

@main
struct Liy_KanjiApp: App {
    
    
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).task {
                    print("run async op")
                    // call DB worker
                    await DBWorker.shared.setMoc(persistenceController.container.viewContext)
                    await DBWorker.shared.sync()
                    print("finished")
                }
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
                persistenceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                print("Scene is active")
            @unknown default:
                print("Apple must of changed something")
            }
        }
    }
}
