//
//  MainMenuTabView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct MainMenuTabView: View {
    var body: some View {
        TabView {
            ForEach(testImages) { image in
                MainMenuImageView(mainMenuImage: image)
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct MainMenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuTabView()
    }
}
