//
//  CardDataModel.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct CardDataModel: Codable, Identifiable {
    let id: Int
    let keyword: String
    let kanji: String
    let exampleWords: [String]
    let radicals: [String]
//    let description: String
//    var coreDataCardObject: FetchedResults<Card>.Element? = nil
    
    func radical() -> String? {
        return radicals.first
    }
    
    func allRadicals() -> [CardDataModel] {
        var allRads: [CardDataModel] = []
        
        // Search all 2200 kanji
        for model in cardDataModels {
            // If that kanji has a radical
            if let modelRad = model.radical() {
                // If SELF/this model uses that model's radical && that model isn't this model
                if (radicals.contains(modelRad) && radicals.first != modelRad) {
                    // Return it
                    allRads.append(model)
                }
            }
        }
        return allRads
    }
    
    // MARK: - STATIC FUNCTIONS
    
    static func fetchCardsFromCoreDataWith(_ cards: FetchedResults<Card>) -> [CardDataModel] {
        var models: [CardDataModel] = []
        for coreDataObject in cards {
            let cardDataModel = cardDataModels[Int(coreDataObject.id)]
            models.append(cardDataModel)
        }
        return models
    }
    
//    private func fetchRadicle(radicle: String) -> [CardDataModel] {
//
//    }
}
