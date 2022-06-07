//
//  CardView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct CardView: View, Identifiable {
    
    // MARK: - PROPERTIES
    var id = UUID()
    var kanjiCard: KanjiCard
    
    // MARK: - Card Flip Properties
    @State var degree: Double = 0
    @State var isFlipped = true
    private let durationAndDelay: CGFloat = 0.3
    @State var fopacityAmount = 1.0
    @State var bopacityAmount = 0.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .modifier(CardSizeModifier())
            FrontView(keyword: kanjiCard.keyword())
                .modifier(CardSizeModifier())
                .opacity(fopacityAmount)
                .animation(.easeInOut(duration: durationAndDelay/2), value: fopacityAmount)
            BackView(kanjiCard: kanjiCard)
                .modifier(CardSizeModifier())
                .rotation3DEffect(Angle(degrees: -180), axis: (x: 0, y: 1, z: 0))
                .opacity(bopacityAmount)
                .animation(.easeInOut(duration: durationAndDelay/2), value: bopacityAmount)

        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: durationAndDelay), value: fopacityAmount)
        .onTapGesture {
            self.flipCard()
        }
    }
    
    private func flipCard() {
        print("Flipping Card")
        isFlipped.toggle()
        if isFlipped {
            fopacityAmount = 1.0
            bopacityAmount = 0.0
        } else {
            fopacityAmount = 0.0
            bopacityAmount = 1.0
        }
        
        degree += 180
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(, card: <#FetchedResults<Card>.Element#>)
//    }
//}
