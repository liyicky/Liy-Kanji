//
//  ContentView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct ContentView: View {
    @State var showSettings: Bool = false
    @State var showInfo: Bool = false
    @State  var showTodays: Bool = false
    @State  var showReviews: Bool = false
    @State  var showCards: Bool = false
    var body: some View {
        VStack {
            HeaderView(showSettingsView: $showSettings, showInfoView: $showInfo)
            
            Spacer()
            
            // Mark: - Show Main Menu
            if (!showReviews) {
                MainMenuTabView()
                    .frame(height: UIScreen.main.bounds.width / 1.475) // This will fix the layout rendering priority issue by using the screen's aspect ratio.
                    .padding(.vertical, 20)
                
                Spacer()
                
                VStack {
                    MainMenuButtonView(showView: $showTodays, image: "play.circle", text: "Today's Cards")
                    MainMenuButtonView(showView: $showReviews, image: "person.2.crop.square.stack.fill", text: "Today's Reviews")
                    MainMenuButtonView(showView: $showCards, image: "greetingcard.fill", text: "My Cards")
                }
                .padding()
                
            } else {
                // Mark: - Show ReviewView
                ReviewsView()
            }
            
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
