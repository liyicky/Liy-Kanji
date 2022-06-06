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
    @Binding var radicalViews: [RadicalView]
    
    let kanji: Kanji
    
    var body: some View {
        VStack {
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
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
            
                Text(kanji.character!)
                    .font(Font.custom("KanjiStrokeOrders", size: 180))
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
            }
            
            
            Divider()
            
            // MARK: - KANJI RADICAL BUTTONS
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(radicalViews) { radicalView in
                        radicalView
                    }
                }
                .padding()
            }
            .frame(height: 30)
        }
    }
}
