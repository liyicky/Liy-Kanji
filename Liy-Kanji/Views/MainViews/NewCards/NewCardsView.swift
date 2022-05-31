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
    @State var mnemonic: String = "Start writing..."
        
    var body: some View {
        
        VStack {
            if let kanji = am.currentKanji {
                DisplayCard(kanji: kanji, mnemonic: $mnemonic)
                Button(action: {
                    withAnimation {
                        Task {
                            await am.createCard(mnemonic: mnemonic)
                        }
                        mnemonic = "Start writing..."
                    }
                }, label: {
                    Text("Save".uppercased())
                        .modifier(ButtonModifier())
                })
            }
        }
        .navigationTitle("Add Cards")
    }
}

//struct NewCardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewCardsView()
//            .padding()
//    }
//}
