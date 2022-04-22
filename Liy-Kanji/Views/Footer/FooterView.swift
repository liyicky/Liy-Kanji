//
//  FooterView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 42, weight: .light))
                .foregroundStyle(.red, .black)
                .symbolRenderingMode(.palette)
            
            Spacer()
            
            Image(systemName: "arrow.counterclockwise.circle")
                .font(.system(size: 42, weight: .light))
                .foregroundStyle(.black)
                .symbolRenderingMode(.palette)
            
            Spacer()
            
            Image(systemName: "checkmark.circle")
                .font(.system(size: 42, weight: .light))
                .foregroundStyle(.green, .black)
                .symbolRenderingMode(.palette)
            
        }
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
