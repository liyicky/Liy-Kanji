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
    var card: FetchedResults<Card>.Element
    var data: CardDataModel
    
    // MARK: - Card Flip Properties
    @State var degree: Double = 0
    @State var isFlipped = true
    private let durationAndDelay: CGFloat = 0.3
    
    var body: some View {
        ZStack {
            FrontView(keyword: data.keyword)
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
                .animation(.linear(duration: 0.3))
                .zIndex(isFlipped ? 1 : 0)
            BackView(cardDataModel: data)
                .rotation3DEffect(Angle(degrees: degree+180), axis: (x: 0, y: 1, z: 0))
                .animation(.linear(duration: 0.3))
                .zIndex(isFlipped ? 0 : 1)
        }
        .onTapGesture {
            self.flipCard()
        }
    }
    
    private func flipCard() {
        print("Flipping Card")
        
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                degree += 180
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                degree += 180
            }
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(, card: <#FetchedResults<Card>.Element#>)
//    }
//}
