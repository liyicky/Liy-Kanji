//
//  BackView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

struct BackView: View {
    
    // TODO: This state does nothing
    @State var kanjiRadicalViews: [RadicalView] = []
    var kanjiCard: KanjiCard
    
    var body: some View {
        CardInfoView(radicalViews: $kanjiRadicalViews, kanji: kanjiCard.kanji!)
    }
}

//struct BackView_Previews: PreviewProvider {
//    static var previews: some View {
//        BackView(cardDataModel: cardDataModels[13])
//    }
//}
