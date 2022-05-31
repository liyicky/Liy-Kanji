//
//  NewCardsPerDaySettingView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/31.
//

import SwiftUI

struct NewCardsPerDaySettingView: View {
    @EnvironmentObject var am: AppManager
    
    var body: some View {
        HStack {
            Text("New cards per day")
            Spacer()
            Picker("", selection: $am.newCardsPerDaySelection) {
                Text("1").tag("1")
                Text("5").tag("5")
                Text("10").tag("10")
                Text("25").tag("25")
                Text("50").tag("50")
                Text("100").tag("100")
                Text("∞").tag("2200")
            }
            .onChange(of: am.newCardsPerDaySelection) { newValue in
                am.updateNewCardPerDaySettingTo(newValue)
            }
        }
    }
}

struct NewCardsPerDaySettingView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardsPerDaySettingView()
    }
}
