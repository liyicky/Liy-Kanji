//
//  NewCardsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct NewCardsView: View {
    
    // MARK: - PROPERTIES
//    @State var kanji: Kanji
    @State var mnemonic: String = "Start writing..."
        
    var body: some View {
        
        VStack {
//            DisplayCard(kanji: kanji, mnemonic: $mnemonic)
            
            Button(action: {
                withAnimation {
//                    createCard(kanji)
                    mnemonic = "Start writing..."
                }
            }, label: {
                Text("Save".uppercased())
                    .modifier(ButtonModifier())
            }).onAppear {

            }
        }
    }

    
}

//struct NewCardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewCardsView()
//            .padding()
//    }
//}
