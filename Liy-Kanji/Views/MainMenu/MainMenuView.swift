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
    @State var selectedIndex = 0
    
    var body: some View {
        
        VStack {
            NavigationView {
                
                ZStack{
                    switch selectedIndex {
                    case 0:
                        KanjiView(rows: Array(repeating: .init(.adaptive(minimum: 15)), count: 1))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 20)
                            .navigationTitle("Kanji")
                    case 1:
                        NewCardsView()
                            .navigationTitle("New")
                    case 2:
                        ReviewsView()
                            .navigationTitle("Review")
                    case 3:
                        CardBrowserView()
                            .navigationTitle("Browse")
                    default:
                        Text("Default")
                    }
                }
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
            }
            .foregroundColor(.black)
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            
            Spacer()
            
            Rectangle().fill(Color.gray.opacity(0.8))
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 1)
                .offset(y: -22)
                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 0, y: -1)
            
            HStack(spacing: 0) {
                Spacer()
                Button {
                    selectedIndex = 0
                } label: {
                    Image(systemName: "house")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 0 ? Color(.black) : .gray)
                }
                Spacer()
                
                Button {
                        selectedIndex = 1
                } label: {
                    Image(systemName: "play.circle")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 1 ? Color(.black) : Color.gray.opacity(0.8))
                        
                }
                Spacer()
                
                Button {
                    selectedIndex = 2
                } label: {
                    Image(systemName: "person.2.crop.square.stack.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 2 ? Color(.black) : .gray)
                }
                Spacer()
                
                Button {
                    selectedIndex = 3
                } label: {
                    Image(systemName: "greetingcard.fill")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == 3 ? Color(.black) : .gray)
                }
                Spacer()
            }
            .padding()
        }
        
        
        /*
        NavigationView {
            
            
            TabView {
                
                //                Image("wallpaper")
                //                    .resizable()
                //                    .scaledToFill()
                //                    .ignoresSafeArea()
                
                KanjiView(rows: Array(repeating: .init(.adaptive(minimum: 15)), count: 1))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                NewCardsView()
                    .tabItem {
                        Image(systemName: "play.circle")
                        Text("New")
                    }
                
                ReviewsView()
                    .tabItem {
                        Image(systemName: "person.2.crop.square.stack.fill")
                        Text("Review")
                    }
                
                CardBrowserView()
                    .tabItem {
                        Image(systemName: "greetingcard.fill")
                        Text("Cards")
                    }
                
                
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
        }
        .foregroundColor(.black)
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
        
        
        */
       /* NavigationView {
            VStack {
                //MARK: - Tab View -------------------------------------------
                MainMenuTabView()
                    .frame(height: UIScreen.main.bounds.width / 1.475) // This will fix the layout rendering priority issue by using the screen's aspect ratio.
                    .padding(.bottom, 20)
                
                //MARK: - Kanji View -------------------------------------------
                KanjiView(rows: Array(repeating: .init(.adaptive(minimum: 15)), count: 1))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                
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
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height) */
    }
}

struct MainMenuView_Previews: PreviewProvider {
    @State static var showSettings: Bool = false
    @State static var showInfo: Bool = false
    static var previews: some View {
        MainMenuView()
    }
}
