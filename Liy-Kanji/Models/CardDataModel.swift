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
    let hints: [[String:String]]
    let onyomi: [String]
    let kunyomi: [String]
    let radicals: [String]
}


extension CardDataModel {
    static var canned: [CardDataModel] {
        let url = Bundle.main.url(forResource: "cardDataModels", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode([CardDataModel].self, from: data)
    }
}
