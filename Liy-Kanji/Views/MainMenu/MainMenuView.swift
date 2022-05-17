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
                //MARK: - Tab View -------------------------------------------
                MainMenuTabView()
                    .frame(height: UIScreen.main.bounds.width / 1.475) // This will fix the layout rendering priority issue by using the screen's aspect ratio.
                    .padding(.bottom, 20)
                
                //MARK: - Kanji View -------------------------------------------
//                KanjiView(rows: Array(repeating: .init(.adaptive(minimum: 15)), count: 1))
//                    .padding(.horizontal, 10)
//                    .padding(.bottom, 20)
                
                //MARK: - Main Views -------------------------------------------
                VStack {
                    NavigationLink(destination: NewCardsView(), label: {
                        MainMenuButtonView(image: "play.circle", text: "New Cards")
                    })
                    
                    NavigationLink(destination: ReviewsView(), label: {
                        MainMenuButtonView(image: "person.2.crop.square.stack.fill", text: "Reviews")
                    })
                    
                    NavigationLink(destination: CardBrowserView()) {
                        MainMenuButtonView(image: "greetingcard.fill", text: "Card Browser")
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
                // -------------------------------------------
            }
            .navigationTitle("Main Menu")
            .navigationBarTitleDisplayMode(.inline)
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
                    showInfoView.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.green, .black)
                        .symbolRenderingMode(.palette)
                })
                .accentColor(Color.primary)
                .sheet(isPresented: $showInfoView, content: {
                    InfoView()
                })
            )
        } // NAV VIEW
        .foregroundColor(.black)
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    @State static var showSettings: Bool = false
    @State static var showInfo: Bool = false
    static var previews: some View {
        MainMenuView()
    }
}
