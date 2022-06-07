//
//  FrontView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/22.
//

import SwiftUI

struct FrontView: View {
    
    // MARK: - PROPERTIES
    var keyword: String
    
    var body: some View {
        ZStack {
            Text(keyword)
                .font(.title)
                .fontWeight(.heavy)
        }
    }
}

struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView(keyword: "Mountain")
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
