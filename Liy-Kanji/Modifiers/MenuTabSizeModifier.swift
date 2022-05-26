//
//  MenuTabSizeModifier.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/25.
//

import SwiftUI

struct MenuTabSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 2)
            
    }
}
