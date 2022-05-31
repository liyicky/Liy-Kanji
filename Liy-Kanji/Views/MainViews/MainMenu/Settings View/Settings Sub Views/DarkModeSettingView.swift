//
//  DarkModeSettingView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/31.
//

import SwiftUI

struct DarkModeSettingView: View {
    @EnvironmentObject var am: AppManager
    
    var body: some View {
        HStack {
            Text("Dark Mode")
            Spacer()
            Toggle("Dark Mode Setting", isOn: $am.darkModeIsOn)
                .onChange(of: am.darkModeIsOn) { newValue in
                    am.updateDarkModeSetting()
                }
        }
    }
}

struct DarkModeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeSettingView()
    }
}
