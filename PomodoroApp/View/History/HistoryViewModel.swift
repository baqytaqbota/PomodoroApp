//
//  HistoryViewModel.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 12.12.2022.
//

import Foundation

final class HistoryViewModel {
    var historyList: [History] = [History(date: "01.01.21", period: [Period(periodName: "Focus time", periodDuration: "11:00"),
                                                                     Period(periodName: "Break time", periodDuration: "11:00")]),
                                  History(date: "02.01.21", period: [Period(periodName: "Focus time", periodDuration: "22:00"),
                                                                     Period(periodName: "Break time", periodDuration: "22:00")]),
                                  History(date: "03.01.21", period: [Period(periodName: "Focus time", periodDuration: "33:00"),
                                                                     Period(periodName: "Break time", periodDuration: "33:00")])]
}
