//
//  CardBrowserView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/11.
//

import SwiftUI

struct CardBrowserView: View {
    
    // MARK: - CORE DATA
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(entity: KanjiCard.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \KanjiCard.id, ascending: true)]) var kanjiCards: FetchedResults<KanjiCard>
    
    @State var cells: [CardBrowserCellView] = []
    
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
                        ForEach(cells) { cell in
                            cell
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
//        for card in kanjiCards {
//            cells.append(CardBrowserCellView(kanjiCard: card))
//        }
    }
}

struct CardBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        CardBrowserView()
    }
}
