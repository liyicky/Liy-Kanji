//
//  MainMenuView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct MainMenuView: View {
    
    // MARK: - PROPERTIES
    
    var body: some View {
        NavigationView {
            VStack {
                MainMenuTabView()
                    .frame(height: UIScreen.main.bounds.width / 1.475) // This will fix the layout rendering priority issue by using the screen's aspect ratio.
                    .padding(.vertical, 20)
                
                Spacer()
                
                VStack {
                    NavigationLink(destination: NewCardsView(), label: {
                        MainMenuButtonView(image: "play.circle", text: "Today's Cards")
                    })
                    
                    NavigationLink(destination: ReviewsView(), label: {
                        MainMenuButtonView(image: "person.2.crop.square.stack.fill", text: "Today's Reviews")
                    })
                    
                    MainMenuButtonView(image: "greetingcard.fill", text: "My Cards")
                }
                .padding()
            }
            .navigationTitle("Main Menu")
        } // NAV VIEW
        .foregroundColor(.black)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
