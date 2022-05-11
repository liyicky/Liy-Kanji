//
//  KanjiView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/10.
//

import SwiftUI

struct KanjiView: View {
    
    // MARK: - CORE DATA
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: NewCardIndex.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NewCardIndex.index, ascending: true)]) var index: FetchedResults<NewCardIndex>
    
    
    // MARK: - PROPERTIES
    var kanjiList = cardDataModels
    var rows: [GridItem]
    
    
    var body: some View {
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
        
                
                LazyHGrid(rows: rows) {
                    ForEach(kanjiList, id: \.id) { kanji in
                        Text(kanji.kanji)
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(kanji.id < currentIndex()+1 ? Color.green : Color.black)
                    }
                }.onAppear {
                    withAnimation(.spring()) {
                        proxy.scrollTo(currentIndex()+1, anchor: .center)
                    }
                }
            }
        }
    }
    
    private func currentIndex() -> Int {
        if let i = index.first {
            print("Current Index "+String(i.index))
            return Int(i.index)
        } else {
            print("Core Data Index couldn't be found")
            return 13 // TODO: Everything will break if the code goes here.
        }
    }
}

struct KanjiView_Previews: PreviewProvider {
    static var previews: some View {
        KanjiView(rows: Array(repeating: .init(.adaptive(minimum: 20)), count: 2))
    }
}
