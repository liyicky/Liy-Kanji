//
//  DifficultiesView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/30.
//

import SwiftUI

struct DifficultiesView: View {
    
    @EnvironmentObject var am: AppManager
    
    var body: some View {
        HStack {
            Text("Difficulty")
            Spacer()
            Picker("Choose a difficulty", selection: $am.difficulty) {
                ForEach(am.difficulties, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 120)
            .onChange(of: am.difficulty) { newValue in
                am.updateDifficultySettingTo(newValue)
            }
        }
    }
}



struct DifficultiesView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultiesView()
    }
}
