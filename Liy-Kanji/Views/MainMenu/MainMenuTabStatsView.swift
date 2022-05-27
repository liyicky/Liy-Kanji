//
//  MainMenuTabStatsView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/25.
//

import SwiftUI

class MainMenuTabStatsViewModel: ObservableObject {
    
    @Published var repsDoneToday: Int? = nil
    @Published var dueToday: Int? = nil
    @Published var dueTomorrow: Int? = nil
    
    func fetchStats() async {
        if let dailyState = AppManager.shared.dailyState {
            self.repsDoneToday = Int(dailyState.repCount)
        }
        self.dueToday = await KanjiCard.amountDueToday()
        self.dueTomorrow = await KanjiCard.amountDueTomorrow()
    }
    
    func repsDoneTodayString() -> String {
        if let repsDoneToday = self.repsDoneToday {
            return String(repsDoneToday)
        }
        return "?"
    }
    
    func dueTodayString() -> String {
        if let dueToday = self.dueToday {
            return String(dueToday)
        }
        return "?"
    }
    
    func dueTomorrowString() -> String {
        if let dueTomorrow = self.dueTomorrow {
            return String(dueTomorrow)
        }
        return "?"
    }
}

struct MainMenuTabStatsView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = MainMenuTabStatsViewModel()
    
    var body: some View {
        ZStack {
            MainMenuBackView()
            HStack {
                Spacer()
                
                VStack {
                    Text(vm.repsDoneTodayString())
                        .font(.largeTitle)
                    Divider()
                        .padding(.horizontal, 20)
                    Text("reps done")
                        .font(.footnote)
                        .fontWeight(.ultraLight)
                        .foregroundColor(Color.gray)
                }
                
                VStack {
                    
                    Text(vm.dueTodayString())
                        .font(.system(size: 52))
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.top, -8)
                    Text("due today")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .padding(.top, -8)
                    Spacer()
                }
                
                VStack {
                    Text(vm.dueTomorrowString())
                        .font(.largeTitle)
                    Divider()
                        .padding(.horizontal, 20)
                    Text("due tomorrow")
                        .font(.footnote)
                        .fontWeight(.ultraLight)
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
        }
        .modifier(MenuTabSizeModifier())
        .task {
            await vm.fetchStats()
        }
    }
}

struct MainMenuTabStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuTabStatsView()
    }
}
