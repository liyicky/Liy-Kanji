//
//  SettingsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                MenuViewComponent()
                
                Spacer(minLength: 10)
                
                Text("Settings")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                DifficultiesView()
                Divider()
                NotificationSettingView()
                Divider()
                DarkModeSettingView()
                Divider()
                NewCardsPerDaySettingView()
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 10)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
