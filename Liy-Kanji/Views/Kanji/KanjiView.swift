//
//  KanjiView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/10.
//

import SwiftUI

class KanjiViewModel: ObservableObject {
    
    @Published var kanji: [Kanji] = []
    
    func updateKanji() async {
        self.kanji = await dbWorker.fetchAllKanji()
    }
    
}

struct KanjiView: View {
        
    // MARK: - PROPERTIES
    @StateObject var vm = KanjiViewModel()
    var rows: [GridItem]
    
    var body: some View {
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
        
                
                LazyHGrid(rows: rows) {
                    ForEach(vm.kanji, id: \.id) { kanji in
                        Text(kanji.character!) //TODO: THIS SHOULDNT BE OPTIONAL
                            .font(.body)
                            .fontWeight(.light)
//                            .foregroundColor(kanji.id ? Color.green : Color.black)
                    }
                }.task {
                    await vm.updateKanji()
                }
                .onAppear {
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
