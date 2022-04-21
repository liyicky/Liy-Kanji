//
//  ContentView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State var goBack: Bool = false
    
    @State var showSettings: Bool = false
    @State var showInfo: Bool = false
    @State var showNewCards: Bool = false
    @State var showReviews: Bool = false
    @State var showCards: Bool = false
    
    var body: some View {
        VStack {
            HeaderView(showSettingsView: $showSettings, showInfoView: $showInfo, goBack: $goBack)
            
            Spacer()
            
            MainMenuView()

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
