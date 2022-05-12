//
//  CardBrowserCellView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/12.
//

import SwiftUI

struct CardBrowserCellView: View {
    
    // MARK: - PROPERTIES
    var model: CardDataModel
    var data: Card
    
    var body: some View {
        
        
        HStack {
            Text(model.kanji)
                .font(.system(size: 35))
                .fontWeight(.heavy)
            
            Text
            
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
                        Text(data.dateCreatedString())
                            .font(.footnote)
                            .fontWeight(.light)
                        Text(data.dateDueString())
                            .font(.footnote)
                            .fontWeight(.light)
                        Text(data.dateLastReviewedString())
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
    

    
    func asdf(data: Card) -> String {
        
        return "\(Calendar.current.dateComponents([.month], from: data.dateCreated!).month!)/\(Calendar.current.dateComponents([.day], from: data.dateCreated!).day!)/\(Calendar.current.dateComponents([.year], from: data.dateCreated!).year!)"
    }
}
