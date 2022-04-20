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
    var body: some View {
        VStack {
            HeaderView(showSettingsView: $showSettings, showInfoView: $showInfo)
            
            Spacer()
            
            MainMenuTabView()
                .frame(height: UIScreen.main.bounds.width / 1.475) // This will fix the layout rendering priority issue by using the screen's aspect ratio.
                .padding(.vertical, 20)
                
            
            Spacer()
            
            VStack {
                MainMenuButtonView(image: "play.circle", text: "Today's Cards", action: {
                    print("Pushed 'Today's Cards' Button")
                }())
                MainMenuButtonView(image: "person.2.crop.square.stack.fill", text: "Today's Reviews", action: {}())
                MainMenuButtonView(image: "greetingcard.fill", text: "My Cards", action: {}())
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
