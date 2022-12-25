//
//  UserDefaults.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 06.12.2022.
//

import Foundation

enum UserdefaultsKeys: String {
    case focusTime
    case breakTime
    case historyDate
}

//Userdefaults service
//enum class or struct
//get set static
//or singleton

class UserDefaultsService {
    static func setFocusTime(value: String) {
        UserDefaults.standard.setValue(value, forKey: UserdefaultsKeys.focusTime.rawValue)
    }
    static func getFocusTime() -> String {
        UserDefaults.standard.string(forKey: UserdefaultsKeys.focusTime.rawValue) ?? "25:00"
    }
    static func setBreakTime(value: String) {
        UserDefaults.standard.setValue(value, forKey: UserdefaultsKeys.breakTime.rawValue)
    }
    static func getBreakTime() -> String {
        UserDefaults.standard.string(forKey: UserdefaultsKeys.breakTime.rawValue) ?? "05:00"
    }
}
