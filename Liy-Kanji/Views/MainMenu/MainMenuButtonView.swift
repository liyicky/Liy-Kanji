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
    let action: ()
    
    var body: some View {
        HStack {
            Button(action: {
                action
            }, label: {
                Image(systemName: image)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.green, .black)
                    .symbolRenderingMode(.palette)
                Spacer()
                Text(text)
                    .font(.title2)
                    .fontWeight(.heavy)
                Spacer()
            })
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
        }
    }
}

struct MainMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuButtonView(image: "seal", text: "Today's Cards", action: {}())
    }
}
