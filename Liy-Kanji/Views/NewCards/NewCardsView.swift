//
//  NewCardsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct NewCardsView: View {
    
    // MARK: - PROPERTIES
    @State var cardDataModel: CardDataModel = cardDataModels[0]
    @State var mnemonic: String = "Start writing..."
    
    // MARK: - CORE DATA
    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(entity: Card.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Card.id, ascending: true)]) var cards: FetchedResults<Card>
    @FetchRequest(entity: NewCardIndex.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NewCardIndex.index, ascending: true)]) var index: FetchedResults<NewCardIndex>
    
    
    var body: some View {
        
        VStack {
            DisplayCard(cardDataModel: cardDataModel, mnemonic: $mnemonic)
            
            Button(action: {
                withAnimation {
                    incrementIndex()
                    cardDataModel = cardDataModels[currentIndex()]
                    mnemonic = "Start writing..."
                }
            }, label: {
                Text("Save".uppercased())
                    .modifier(ButtonModifier())
            }).onAppear {
                fetchOrCreateIndex()
                cardDataModel = cardDataModels[currentIndex()]
                print("Current Index "+String(currentIndex()))
            }
        }
    }
    
    private func fetchOrCreateIndex() {
        if let i = index.first { // Index exist.
            print("Index exists and is ready")
        } else { // No Index. Create it.
            let newCardIndex = NewCardIndex(context: self.managedObjectContext)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Index couldn't be created \(error)")
            }
        }
    }
    
    private func currentIndex() -> Int {
        if let i = index.first {
            return Int(i.index)
        } else {
            print("Core Data Index couldn't be found")
            fatalError("alskdjfalskdjf")
        }
    }
    
    private func incrementIndex() {
        if let i = index.first {
            let newCardIndex = i
            newCardIndex.index = Int16(currentIndex() + 1)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Index couldn't be saved \(error)")
            }
        }
    }
    
}

struct NewCardsView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardsView()
    }
}
