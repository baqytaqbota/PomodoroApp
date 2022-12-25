//
//  SettingsViewModel.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 05.12.2022.
//

import Foundation

class SettingsViewModel {
    var settingsList: [Settings] = [
        Settings(periodName: "Focus time", time: UserDefaultsService.getFocusTime()),
        Settings(periodName: "Break time", time: UserDefaultsService.getBreakTime())
    ]
}
