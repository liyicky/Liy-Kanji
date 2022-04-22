//
//  MainMenuView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct MainMenuView: View {
    
    // MARK: - PROPERTIES
    @State var showSettingsView: Bool = false
    @State var showInfoView: Bool = false
    
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
            .navigationBarItems(
                leading: Button(action: {
                    showSettingsView.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.green, .black)
                    .symbolRenderingMode(.palette)
            })
            .accentColor(Color.primary)
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            }),
                trailing: Button(action: {
                    self.showSettingsView.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.green, .black)
                        .symbolRenderingMode(.palette)
                })
                .accentColor(Color.primary)
                .sheet(isPresented: $showSettingsView, content: {
                    SettingsView()
                })
                )
        } // NAV VIEW
        .foregroundColor(.black)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    @State static var showSettings: Bool = false
    @State static var showInfo: Bool = false
    static var previews: some View {
        MainMenuView()
    }
}
