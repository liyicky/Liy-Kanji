//
//  MainMenuImageView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct MainMenuImageView: View {
    
    let mainMenuImage: MainMenuImage
    
    var body: some View {
        Image(mainMenuImage.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct MainMenuImageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuImageView(mainMenuImage: testImages[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
