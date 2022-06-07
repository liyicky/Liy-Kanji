//
//  CardSizeModifier.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/06/06.
//

import SwiftUI

struct CardSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height * 0.60)
    }
}



