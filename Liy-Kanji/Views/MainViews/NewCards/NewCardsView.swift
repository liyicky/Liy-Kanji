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
    @FetchRequest(entity: NewCardIndex.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NewCardIndex.index, ascending: true)]) var index: FetchedResults<NewCardIndex>
    
    
    var body: some View {
        
        VStack {
            DisplayCard(cardDataModel: cardDataModel, mnemonic: $mnemonic)
            
            Button(action: {
                withAnimation {
                    createCard()
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
            }
        }
    }
    
    // MARK: - Index Logic: Creating, Getting, Saving
    
    private func fetchOrCreateIndex() {
        if let i = index.first { // Index exist.
            print("Index is \(i.index) and exists and is ready")
        } else { // No Index. Create it.
            let newCardIndex = NewCardIndex(context: self.managedObjectContext)
            // Start at index 0 to match the ids in the Kanji Data Json
            newCardIndex.index = 0
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Index couldn't be created \(error)")
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
    
    // MARK: - Card Logic: Creating
    
    private func createCard() {
        let newCard = Card(context: self.managedObjectContext)
        newCard.id = Int16(cardDataModel.id)
        newCard.dateCreated = Date.now
        newCard.mnemonic = mnemonic
        newCard.repCount = 0
        newCard.successfulReps = 0
        do {
            try self.managedObjectContext.save()
        } catch {
            print("New Card couldn't be created \(error)")
        }
    }
    
}

struct NewCardsView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardsView()
            .padding()
    }
}
