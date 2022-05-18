//
//  CardBrowserView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/11.
//

import SwiftUI

class CardBrowersViewModel: ObservableObject {
    
    @Published var cells: [CardBrowserCellView] = []
    
    func updateCells() async {
        let kanjiCards = await dbWorker.fetchAllKanjiCards()
        for card in kanjiCards {
            self.cells.append(CardBrowserCellView(kanjiCard: card))
        }
    }
}

struct CardBrowserView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = CardBrowersViewModel()
    
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
                        ForEach(vm.cells) { cell in
                            cell
                        }
                    }
            }
        }
        .padding()
        .task {
            await vm.updateCells()
        }
    }
}

struct CardBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        CardBrowserView()
    }
}
