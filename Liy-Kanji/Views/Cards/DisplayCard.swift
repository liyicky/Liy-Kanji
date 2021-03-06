//
//  DisplayCard.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/21.
//

import SwiftUI

struct DisplayCard: View {
    
    // MARK: - PROPERTIES
    
    @EnvironmentObject var am: AppManager
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
                    
                    Button {
                        Task {
                            await am.addHint()
                        }
                    } label: {
                        Text("Show hint?")
                            .font(.callout)
                            .foregroundColor(Color.gray)
                    }

                }.padding(.horizontal, 20)
                
                VStack {
                    ForEach(am.currentKanjiHints) { hint in
                        HintView(hint: hint)
                    }
                }.padding(5)
                
                Divider().padding(.horizontal, 20)
                
                ZStack {
                    TextEditor(text: $mnemonic)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Color.primary.opacity(1))
                        .cornerRadius(5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .onTapGesture {
                            if mnemonic == mnemonicDefaultText {
                                mnemonic = ""
                            }
                        }
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
