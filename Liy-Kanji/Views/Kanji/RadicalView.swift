//
//  RadicalView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/06/06.
//

import SwiftUI

struct RadicalView: View, Identifiable {
    
    var id = UUID()
    
    var kanjiChar: String
    var keywords: [String]
    @State private var kanji: Kanji?
    @State private var showingSheet = false
    @State private var kanjiRadicalsForTheSheet: [RadicalView] = []
    
    var body: some View {
        VStack(spacing: 1) {
            if kanji != nil {
                Button {
                    showingSheet.toggle()
                } label: {
                    VStack {
                        Text(kanjiChar)
                        Divider()
                            .frame(width: 20)
                    }
                }
            } else {
                Text(kanjiChar)
            }
        }
        .padding()
        .onAppear {
            kanji = DBWorker.shared.fetchKanjiWithCharacter(kanjiChar)
            if let kanji = kanji {
                self.kanjiRadicalsForTheSheet = kanji.radicalViews()
            }
        }
        .sheet(isPresented: $showingSheet) {
            if let kanji = self.kanji {
                CardInfoView(kanji: kanji)
                
                Text("Keywords")
                    .font(.largeTitle)
                HStack {
                    ForEach(keywords, id: \.self) { keyword in
                        Text(keyword)
                    }
                }
            }
        }
    }
}

struct RadicalView_Previews: PreviewProvider {
    static var previews: some View {
        RadicalView(kanjiChar: "言", keywords: ["say", "words", "keitai"])
            .previewLayout(.sizeThatFits)
    }
}

