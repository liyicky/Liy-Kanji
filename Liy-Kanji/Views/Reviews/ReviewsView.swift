//
//  ReviewsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct ReviewsView: View {
    
    // MARK: - PROPERTIES
    

    var body: some View {
        VStack {
            
            CardStackView(cardViews: [])
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
