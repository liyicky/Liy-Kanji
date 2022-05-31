//
//  NotificationSettingView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/30.
//

import SwiftUI

struct NotificationSettingView: View {
    @EnvironmentObject var am: AppManager
    
    var body: some View {
        DatePicker("Please enter a date", selection: $am.reminderDate, displayedComponents: .hourAndMinute)
            .onChange(of: am.reminderDate) { newValue in
                am.updateReminderSettingTo(newValue)
            }
    }
}

struct NotificationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingView()
    }
}
