//
//  DisplayCard.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/21.
//

import SwiftUI

struct DisplayCard: View {
    
    // MARK: - PROPERTIES
    
    let kanji: Kanji
    @Binding var mnemonic: String
    @Binding var radicalViews: [RadicalView]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                CardInfoView(radicalViews: $radicalViews, kanji: kanji)
                
                
                HStack {
                    
                    Text("Mnemonic")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                    Spacer()
                }.padding(.leading, 20)
                
                Divider().padding(.horizontal, 20)
                
                ZStack {
                    
                    TextEditor(text: $mnemonic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .colorMultiply(Color.secondary)
                        .cornerRadius(5)
                        .foregroundColor(Color.primary)
                        .padding()
                    Text(mnemonic).opacity(0).padding(.all, 0)
                }
                
                Divider().padding(.horizontal, 20)
                
            }
        }
    }
}

//struct DisplayCard_Previews: PreviewProvider {
//    @State static var mnemonic: String = "Start writing..."
//    static var previews: some View {
//        DisplayCard(kanji: cardDataModels[15], mnemonic: $mnemonic)
//            .previewLayout(.fixed(width: 375, height: 600))
//    }
//}
