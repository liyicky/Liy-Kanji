//
//  KanjiView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/10.
//

import SwiftUI

struct KanjiView: View {
    
    // MARK: - CORE DATA
    // TODO: POPULATE WITH KANJI FROM CORE DATA
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Kanji.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Kanji.id, ascending: true)]) var kanji: FetchedResults<Kanji>

    
    // MARK: - PROPERTIES
    var rows: [GridItem]
    
    
    var body: some View {
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
        
                
                LazyHGrid(rows: rows) {
                    ForEach(kanji, id: \.id) { kanji in
                        Text(kanji.character!) //TODO: THIS SHOULDNT BE OPTIONAL
                            .font(.body)
                            .fontWeight(.light)
//                            .foregroundColor(kanji.id ? Color.green : Color.black)
                    }
                }.onAppear {
                    withAnimation(.spring()) {
                        // TODO: FIX HOW THIS SCROLLS
                        proxy.scrollTo(1, anchor: .center)
                    }
                }
            }
        }
    }
}

struct KanjiView_Previews: PreviewProvider {
    static var previews: some View {
        KanjiView(rows: Array(repeating: .init(.adaptive(minimum: 20)), count: 2))
    }
}
