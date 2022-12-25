//
//  HistoryModel.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 12.12.2022.
//

import Foundation

struct History {
    let date: String
    let period: [Period]
}

struct Period {
    let periodName: String
    let periodDuration: String
}
