//
//  MainMenuCalendarView.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/26.
//

import SwiftUI
import SwiftUICalendar

struct MainMenuTabCalendarView: View {
    var body: some View {
        ZStack {
            MainMenuBackView()
            StreakCalendarView()
                .padding()
        }
        .modifier(MenuTabSizeModifier())
    }
}

struct MainMenuTabCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuTabCalendarView()
    }
}

struct StreakCalendarView: View {
    private var am = AppManager.shared
    @ObservedObject var controller: CalendarController = CalendarController(orientation: .vertical).self
    
    var streakDays = [YearMonthDay: String]()
    
    init() {
        for state in am.dailyStates {
            if let date = state.yearMonthDay() {
                streakDays[date] = String(state.repCount)
            }
        }
    }
    
    var body: some View {
        
        GeometryReader { reader in
            VStack(alignment: .center, spacing: 0) {
                Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                    .font(.title)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<7, id: \.self) { i in
                        Text(DateFormatter().shortWeekdaySymbols[i])
                            .font(.headline)
                            .frame(width: reader.size.width / 7)
                    }
                }
                CalendarView(controller) { date in
                    GeometryReader { geometry in
                        ZStack(alignment: .center) {

                            if date.isToday {
                                Circle()
                                    .padding(4)
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .foregroundColor(.orange)
                                Text("\(date.day)")
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            } else {
                                Text("\(date.day)")
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                    .font(.system(size: 10, weight: .light, design: .default))
//                                    .foregroundColor(getColor(date))
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            }
                            if let streak = streakDays[date] {
                                Text(streak)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .font(.system(size: 8, weight: .bold, design: .default))
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                    .frame(width: geometry.size.width/2, alignment: .center)
                                    .background(Color.green)
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension YearMonthDay: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.year)
        hasher.combine(self.month)
        hasher.combine(self.day)
    }
}
