//
//  ReviewsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct ReviewsView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = AppManager.shared
    
    var body: some View {
        VStack {
            CardStackView()
            
            FooterView()
                .padding(.bottom, 30)
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
