//
//  BackView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

class BackViewManager: ObservableObject {
    @State var kanjiRadicalViews: [RadicalView] = []
    
    func fetchRadicals(kanji: Kanji) {
        self.kanjiRadicalViews = kanji.radicalViews()
    }
}

struct BackView: View {
    
    // TODO: This state does nothing
    @StateObject var vm = BackViewManager()
    var kanjiCard: KanjiCard
    
    var body: some View {
        CardInfoView(kanji: kanjiCard.kanji!)
            .onAppear {
                vm.fetchRadicals(kanji: kanjiCard.kanji!)
            }
    }
}

//struct BackView_Previews: PreviewProvider {
//    static var previews: some View {
//        BackView(cardDataModel: cardDataModels[13])
//    }
//}
