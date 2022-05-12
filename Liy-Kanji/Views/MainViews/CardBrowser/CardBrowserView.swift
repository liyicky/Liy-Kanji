//
//  CardBrowserView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/11.
//

import SwiftUI

struct CardBrowserView: View {
    
    // MARK: - CORE DATA
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Card.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Card.id, ascending: true)]) var cards: FetchedResults<Card>

    // MARK: - PROPERTIES
    @State var cardDataModels: [CardDataModel] = []
    
    // MARK: - CONSTANTS
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 6, alignment: nil)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 6,
                pinnedViews: [.sectionHeaders]) {
                
                    Section(header:
                                Text("Search Bar Here")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .background(Color.white)
//                                    .padding()
                    ) {
                        ForEach(cardDataModels) { model in
                            CardBrowserCellView(model: model, data: cards[model.id])
                        }
                    }
            }
        }
        .padding()
        .onAppear {
            populate()
        }
    }
    
    
    func populate() {
        cardDataModels = CardDataModel.fetchCardsFromCoreDataWith(cards)
    }
}

struct CardBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        CardBrowserView()
    }
}
