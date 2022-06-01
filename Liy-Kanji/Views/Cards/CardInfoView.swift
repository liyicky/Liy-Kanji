//
//  CardInfoView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

class CardInfoViewModel: ObservableObject {
    @Published var radicalViews: [RadicalView] = []
    @State private var selectedRadical: CardDataModel? = nil
    
    
    func fetchRadicalViewsFor(_ kanji: Kanji) async {
        self.radicalViews = await kanji.radicalViews()
    }
}

struct CardInfoView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = CardInfoViewModel()
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
                    
                    Text(kanji.keyword!)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            
                Text(kanji.character!)
                    .font(Font.custom("KanjiStrokeOrders", size: 180))
                    .fontWeight(.bold)
            }
            
            
            Divider()
            
            // MARK: - KANJI RADICAL BUTTONS
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                Group {
                    ForEach(vm.radicalViews) { radicalView in
                        
                        radicalView

//                        Button(action: {
//                            selectedRadical = radical
//                        }) {
//                            VStack {
//                                Text(radical.kanji)
//                                    .font(.footnote)
//                                    .fontWeight(.light)
//                                    .foregroundColor(Color.primary)
//                                Text(radical.keyword)
//                                    .font(.callout)
//                                    .fontWeight(.light)
//                                    .foregroundColor(Color.primary)
//                            }
//                        }
                    }
                }
                Spacer()
            }
            .task {
                await vm.fetchRadicalViewsFor(kanji)
            }
            .padding()
//            .sheet(item: $selectedRadical, content: {_ in
//                CardInfoView(kanji: kanji)
//            })
            
            Spacer()
        }
    }
}

//struct CardInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardInfoView(cardDataModel: cardDataModels[15])
//    }
//}
