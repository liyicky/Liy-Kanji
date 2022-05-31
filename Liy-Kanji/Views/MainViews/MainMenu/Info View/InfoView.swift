//
//  InfoView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                MenuViewComponent()
                
                Spacer(minLength: 10)
                
                Text("App Info")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                AppInfoView()
                
                Text("Credits")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                CreditsView()
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 10)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }
    }
}


struct AppInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            InfoRowView(itemOne: "Application", itemTwo: "Kanji Aid")
            InfoRowView(itemOne: "Compatibility", itemTwo: "iPhone / iPad")
            InfoRowView(itemOne: "Developer", itemTwo: "Jason Cheladyn")
            InfoRowView(itemOne: "Website", itemTwo: "liyicky.com")
            InfoRowView(itemOne: "Version", itemTwo: "1.0.0")
        }
    }
}

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Adopted from the book")
                .foregroundColor(Color.secondary)
                .font(.footnote)
                .fontWeight(.light)
            Text("Remembering the Kanji")
                .foregroundColor(Color.primary)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Text("writen by")
                    .foregroundColor(Color.secondary)
                    .font(.footnote)
                Text("James W. Heisig")
                    .foregroundColor(Color.primary)
                    .font(.callout)
                    .fontWeight(.heavy)
            }
            
        }
        Text("If you are really serious about learning all 2200 kanji, buy the book. Heisig's book is invaluable.")
                        .fontWeight(.light)
                        .foregroundColor(Color.secondary)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
        
        Divider()
        
        VStack(alignment: .leading, spacing: 5) {
            Text("Special thanks")
                .foregroundColor(Color.secondary)
            
            Text("People to thank here")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
