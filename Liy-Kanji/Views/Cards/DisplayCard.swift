//
//  DisplayCard.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/21.
//

import SwiftUI

struct DisplayCard: View {
    
    // MARK: - PROPERTIES
    
    let cardDataModel: CardDataModel
    @Binding var mnemonic: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                CardInfoView(cardDataModel: cardDataModel)
                
                Spacer()
                
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
                        .padding()
                    Text(mnemonic).opacity(0).padding(.all, 0)
                }
                
                Divider().padding(.horizontal, 20)
            }
        }
    }
}

struct DisplayCard_Previews: PreviewProvider {
    @State static var mnemonic: String = "Start writing..."
    static var previews: some View {
        DisplayCard(cardDataModel: cardDataModels[13], mnemonic: $mnemonic)
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
