//
//  NewCardsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

class NewCardsViewModel: ObservableObject {
    
    @Published var currentKanji: Kanji? = nil
    
    func updateCurrentKanji() async {
        do {
            self.currentKanji = try await dbWorker.fetchCurrentKanji()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct NewCardsView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = NewCardsViewModel()
    @State var mnemonic: String = "Start writing..."
        
    var body: some View {
        
        VStack {
            if let kanji = vm.currentKanji {
                DisplayCard(kanji: kanji, mnemonic: $mnemonic)
                Button(action: {
                    withAnimation {
                        Task {
                            await dbWorker.createCard(kanji: kanji, mnemonic: mnemonic)
                            await vm.updateCurrentKanji()
                        }
                        mnemonic = "Start writing..."
                    }
                }, label: {
                    Text("Save".uppercased())
                        .modifier(ButtonModifier())
                })
            }
        }.task {
            await vm.updateCurrentKanji()
        }
    }
}

//struct NewCardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewCardsView()
//            .padding()
//    }
//}
