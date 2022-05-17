//
//  BackView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

struct BackView: View {
    
    var kanjiCard: KanjiCard
    
    var body: some View {
        CardInfoView(kanji: kanjiCard.kanji!)
    }
}

//struct BackView_Previews: PreviewProvider {
//    static var previews: some View {
//        BackView(cardDataModel: cardDataModels[13])
//    }
//}
