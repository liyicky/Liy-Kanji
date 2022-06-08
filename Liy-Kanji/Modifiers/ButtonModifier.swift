//
//  ButtonModifier.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/21.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}
