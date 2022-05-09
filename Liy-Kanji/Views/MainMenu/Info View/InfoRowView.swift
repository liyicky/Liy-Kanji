//
//  InfoRowView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/09.
//

import SwiftUI

struct InfoRowView: View {
    
    // MARK: - PROPERTIES
    var itemOne: String
    var itemTwo: String
    
    var body: some View {
        VStack {
            HStack {
                Text(itemOne).foregroundColor(Color.gray)
                Spacer()
                Text(itemTwo)
            }
            Divider()
        }
    }
}

struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(itemOne: "Application", itemTwo: "Kanji Aid")
    }
}
