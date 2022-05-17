//
//  CardBrowserCellView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//

import SwiftUI

struct CardBrowserCellView: View, Identifiable {
    
    var id = UUID()
    
    
    // MARK: - PROPERTIES
    var kanjiCard: KanjiCard
    
    var body: some View {
        
        HStack {
            VStack(alignment: .center, spacing: 0) {
                Text(kanjiCard.kanji?.character ?? "error")
                    .font(.system(size: 35))
                    .fontWeight(.heavy)
                Text(kanjiCard.kanji?.keyword ?? "error")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Color.black.opacity(0.8))
            }
            
            Spacer()
            
            Text("\(kanjiCard.repsSuccessful) / \(kanjiCard.repCount)")
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 1) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Created:")
                            .font(.footnote)
                            .fontWeight(.ultraLight)
                            .foregroundColor(Color.gray.opacity(0.9))
                        Text("Due:")
                            .font(.footnote)
                            .fontWeight(.ultraLight)
                            .foregroundColor(Color.gray.opacity(0.9))
                        Text("Reviewed on:")
                            .font(.footnote)
                            .fontWeight(.ultraLight)
                            .foregroundColor(Color.gray.opacity(0.9))
                    }
                    
                    VStack(alignment: .trailing) {
                        Text(kanjiCard.dateCreatedString())
                            .font(.footnote)
                            .fontWeight(.light)
                        Text(kanjiCard.dateDueString())
                            .font(.footnote)
                            .fontWeight(.light)
                        Text(kanjiCard.dateLastReviewedString())
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 0)
        .padding(.horizontal, 5)
    }
}
