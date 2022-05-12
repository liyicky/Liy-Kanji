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
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 60, x: 0, y: 0)
    }
}
