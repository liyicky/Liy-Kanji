//
//  MenuViewComponent.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/09.
//

import SwiftUI

struct MenuViewComponent: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Capsule()
                .frame(width: 120, height: 6)
                .foregroundColor(Color.secondary)
                .opacity(0.2)
            
            Image("Icon-Transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .padding(.vertical, -70)
        }
    }
}

struct MenuViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        MenuViewComponent()
            .previewLayout(.fixed(width: 375, height: 128))
    }
}
