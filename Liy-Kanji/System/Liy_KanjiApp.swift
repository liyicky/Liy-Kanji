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
    
    @StateObject var am = AppManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(am)
            
                .task {
                    print("Running async app setup")
                
                    /* Create the AppState in Core Data (Used for settings) */
                    await AppManager.shared.setAppState()
                
                    /*
                     Create the DailyState in Core Data
                     (Used for tracking how many reps the user did per day)
                     */
                    await AppManager.shared.setDailyState()
                
                    /*
                     Sync the Kanji Data Json into Core Data
                     */
                    await AppManager.shared.sync()
                
                    /*
                     Pull today's cards from Core Data.
                     This is used in the ReviewsViewManager
                     */
                    await AppManager.shared.loadReviewCards()
                    
                    /*
                     Pull the settings from Core Data and set them as the published state.
                     */
                    AppManager.shared.setSettingsState()
                    
                
                    /*
                     Pull 2 cards out of the array and set them as Published variables.
                     These are the two cards the user can see on the screen.
                     */
                    AppManager.shared.cycleCards()
                    
                
                    print("Async app setup finished")
                }
            
                .preferredColorScheme(am.colorScheme)
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
