//
//  ContentView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    var body: some View {
        VStack {
            MainMenuView()
                .background(Color("Background"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
