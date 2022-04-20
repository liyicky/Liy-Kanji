//
//  CardDataModel.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct CardDataModel: Codable {
    let id: Int
    let keyword: String
    let kanji: String
    let exampleWord: String
    let radicles: [String]
//    var coreDataCardObject: FetchedResults<Card>.Element? = nil
}
