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
        let fetchedKanji = await dbWorker.fetchAllKanji()
        for kanji in fetchedKanji {

            try? await Task.sleep(nanoseconds: 5_000_000)
            DispatchQueue.main.async {
                self.kanji.append(kanji)
            }
        }
    }
}

struct KanjiView: View {
        
    // MARK: - PROPERTIES
    @StateObject var vm = KanjiViewModel()
    var columns = [GridItem(.adaptive(minimum: 20))]
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyVGrid(columns: columns) {
                    ForEach(vm.kanji, id: \.id) { kanji in
                        KanjiText(kanji.character!) //TODO: THIS SHOULDNT BE OPTIONAL
//                            .foregroundColor(kanji.id ? Color.green : Color.black)
                    }
                }.task {
                    await vm.updateKanji()
                }
//                .onAppear {
//                    withAnimation(.spring()) {
//                        // TODO: FIX HOW THIS SCROLLS
//                        proxy.scrollTo(1, anchor: .center)
//                    }
//                }
            }
        }
    }
}

struct KanjiView_Previews: PreviewProvider {
    static var previews: some View {
        KanjiView(columns: Array(repeating: .init(.adaptive(minimum: 20)), count: 2))
    }
}
