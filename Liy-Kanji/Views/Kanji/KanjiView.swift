//
//  KanjiView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/10.
//

import SwiftUI

struct KanjiView: View {
        
    // MARK: - PROPERTIES
    @EnvironmentObject var am: AppManager
    var columns = [GridItem(.adaptive(minimum: 20))]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyVGrid(columns: columns) {
                    ForEach(am.kanji, id: \.id) { kanji in
                        KanjiText(kanji.character!) //TODO: THIS SHOULDNT BE OPTIONAL
//                            .foregroundColor(kanji.id ? Color.green : Color.black)
                    }
                }
//                .onAppear {
//                    withAnimation(.spring()) {
//                        // TODO: FIX HOW THIS SCROLLS
//                        proxy.scrollTo(1, anchor: .center)
//                    }
//                }
            } // ScrollViewReader
        } // ScrollView
    }
}

struct KanjiView_Previews: PreviewProvider {
    static var previews: some View {
        KanjiView(columns: Array(repeating: .init(.adaptive(minimum: 20)), count: 2))
    }
}
