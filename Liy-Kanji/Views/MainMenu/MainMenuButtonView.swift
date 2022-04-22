//
//  MainMenuButtonView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct MainMenuButtonView: View {
    
    let image: String
    let text: String
    
    var body: some View {
        HStack {
                Image(systemName: image)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.green, .black)
                    .symbolRenderingMode(.palette)
                Spacer()
                Text(text)
                    .font(.title2)
                    .fontWeight(.heavy)
                Spacer()
        }
        .modifier(ButtonModifier())
    }
}

struct MainMenuButtonView_Previews: PreviewProvider {
    @State static var showView: Bool = false
    static var previews: some View {
        MainMenuButtonView(image: "seal", text: "Today's Cards")
    }
}
