//
//  NewCardsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct NewCardsView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var am: AppManager
    @State var mnemonic = mnemonicDefaultText
        
    var body: some View {
        
        VStack {
            DisplayCard(kanji: am.currentKanji!, mnemonic: $mnemonic)

            SaveButtonView(onCompletion: saveCard)
        }
        .navigationTitle("Add Cards")
    }
    
    func saveCard() {
        Task {
            await am.createCard(mnemonic: mnemonic)
            mnemonic = mnemonicDefaultText
        }
    }
}
