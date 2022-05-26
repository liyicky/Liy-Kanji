//
//  MainMenuBackView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/25.
//

import SwiftUI

struct MainMenuBackView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color.white)
            .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 5)
    }
}

struct MainMenuBackView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuBackView()
            .modifier(MenuTabSizeModifier())
    }
}
