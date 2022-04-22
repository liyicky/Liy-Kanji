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
    let exampleWord: String
    let radicles: [Int]
    let description: String
//    var coreDataCardObject: FetchedResults<Card>.Element? = nil
    
    func allRadicles() -> [CardDataModel] {
        var allRads: [CardDataModel] = []
        for cardDataModel in cardDataModels {
            if (radicles.contains(cardDataModel.id)) {
                allRads.append(cardDataModel)
            }
        }
        return allRads
    }
}
