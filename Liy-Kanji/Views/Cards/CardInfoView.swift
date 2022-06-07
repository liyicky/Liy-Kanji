//
//  CardInfoView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

struct CardInfoView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var am: AppManager
    let kanji: Kanji
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
            HStack {
                Text("#"+String(kanji.kanjiId))
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 5)
            
            HStack {
                VStack {
                    Text(kanji.character!)
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                        .padding(.horizontal, 15)

                    Text(kanji.keyword!)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .padding(.horizontal, 15)
                }

            
                Text(kanji.character!)
                    .font(Font.custom("KanjiStrokeOrders", size: 180))
                    .fontWeight(.bold)

            } // HStack that holds the Kanji, Keyword, and Stroke Order
            
            
            Divider()

            
            // MARK: - KANJI RADICAL BUTTONS
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(kanji.radicalViews()) { radicalView in
                        radicalView
                    }
                    
                }
                
            }
            .frame(height: 30)
        } // VStack
    }
}
