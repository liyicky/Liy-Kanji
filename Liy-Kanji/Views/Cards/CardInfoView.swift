//
//  CardInfoView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

struct CardInfoView: View {
    
    // MARK: - PROPERTIES
    @State private var selectedRadicle: CardDataModel? = nil
    
    let cardDataModel: CardDataModel
    
    var body: some View {
        VStack {
            HStack {
                Text("#"+String(cardDataModel.id))
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 5)
            
            HStack {
                Text(cardDataModel.kanji)
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                Spacer()
                
                Text(cardDataModel.keyword)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            }
            .padding(.horizontal, 10)
            
            Divider()
            
            HStack(alignment: .top, spacing: 20){
                Spacer()
                Group {
                    
                    ForEach(cardDataModel.allRadicles()) {
                        radicle in
                        
                        Button(radicle.keyword) {
                            selectedRadicle = radicle
                        }
                    }
                }
            }
            .padding()
            .sheet(item: $selectedRadicle, content: {
                CardInfoView(cardDataModel: $0)
            })
            
            Text(cardDataModel.description)
                .multilineTextAlignment(.leading)
                .font(.body)
                .padding()
            
        }
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(cardDataModel: cardDataModels[13])
    }
}
