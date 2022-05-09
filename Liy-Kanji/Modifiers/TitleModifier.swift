//
//  TitleModifier.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/09.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.black)
    }
}

