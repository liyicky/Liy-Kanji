//
//  KanjiText.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/24.
//

import SwiftUI

struct KanjiText: View {
    
    // MARK: - PROPERTIES
    @State var isAnimating = false
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 20))
            .fontWeight(.regular)
            .opacity(isAnimating ? 1.0 : 0.0)
            .animation(.easeIn(duration: 0.5), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

struct KanjiText_Previews: PreviewProvider {
    static var previews: some View {
        KanjiText("先")
    }
}
