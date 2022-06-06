//
//  KanjiExtensions.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/14.
//

import SwiftUI

extension Kanji {
    
    public func rads() -> [Radical] {
        if let radicals = radicals?.allObjects as? [Radical] {
            return radicals
        }
        return []
    }
    
    func radicalViews() async -> [RadicalView] {
        var views: [RadicalView] = []
        let kanjiRadicals = await kanjiRadicals()
        for kanji in kanjiRadicals {
            print(kanji)
            views.append(RadicalView(kanjiChar: kanji.key, keywords: kanji.value))
        }
        
        return views
    }
    
    private func addToKanjiRadicals(kanjiRadicals: [String: [String]], kanjiChar: String, keyword: String) -> [String: [String]] {
        var kanjiRadicals = kanjiRadicals
        
        if kanjiRadicals[kanjiChar] != nil { // If in the dict already.
            kanjiRadicals[kanjiChar]!.append(keyword)
        } else { // Add it to the dict with an empty array.
            kanjiRadicals[kanjiChar] = []
            kanjiRadicals[kanjiChar]!.append(keyword)
        }
        return kanjiRadicals
    }
    
    
    private func kanjiRadicals() async -> [String: [String]] {
        var kanjiRadicals: [String: [String]] = [:]
        for radical in rads() {
            
            // Skip is this radical is the same as this kanji.
            if radical.keyword == keyword { continue }
            
            // Try to find a kanji that belongs to the radical.
            if let kanji = await DBWorker.shared.fetchKanjiWithKeyword(radical.keyword!) {
                kanjiRadicals = addToKanjiRadicals(kanjiRadicals: kanjiRadicals, kanjiChar: kanji.character!, keyword: radical.keyword!)
                continue
            }
            
            // Search Radicals.Pure for the pure radical and add it to the dictionary.
            if let pureRadical = Radical.Pure[radical.keyword!] {
                kanjiRadicals = addToKanjiRadicals(kanjiRadicals: kanjiRadicals, kanjiChar: pureRadical, keyword: radical.keyword!)
                continue
            }
            
            // Find the first kanji with this keyword as one of it's radicals.
            let allKanji = await DBWorker.shared.fetchAllKanji()
            outerLoop: for kanji in allKanji {
                for subradical in kanji.rads() { // Look at EVERY radical in the DB and stop at the first one
                    if subradical.keyword! == radical.keyword! { // If a kanji is found, put/append it in the dict and break.
                        kanjiRadicals = addToKanjiRadicals(kanjiRadicals: kanjiRadicals, kanjiChar: kanji.character!, keyword: radical.keyword!)
                        break outerLoop
                    }
                }
            }
        }
        return kanjiRadicals
    }
    
    func allHints() async -> [Hint] {
        return await DBWorker.shared.fetchHintsForKanji(kanji: self)
    }
    
    
}

struct RadicalView: View, Identifiable {
    
    var id = UUID()
    
    var kanjiChar: String
    var keywords: [String]
    @State private var kanji: Kanji?
    @State private var showingSheet = false
    @State private var kanjiRadicalsForTheSheet: [RadicalView] = []
    
    var body: some View {
        VStack(spacing: 1) {
            if let kanji = kanji {
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
        .task {
            self.kanji = await DBWorker.shared.fetchKanjiWithCharacter(kanjiChar)
            if let kanji = self.kanji {
                self.kanjiRadicalsForTheSheet = await kanji.radicalViews()
            }
        }
        .sheet(isPresented: $showingSheet) {
            if let kanji = self.kanji {
                CardInfoView(radicalViews: $kanjiRadicalsForTheSheet, kanji: kanji)
                
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

