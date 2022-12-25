//
//  FocusCategoryViewModel.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 02.12.2022.
//

import Foundation


class FocusCategoryViewModel {
    var themeList: [Theme] = []
    
    func fetchTheme(completion: (() -> ())?) {
        themeList = [
            Theme(themeName: "Work", themeImage: "work"),
            Theme(themeName: "Study", themeImage: "study"),
            Theme(themeName: "Workout", themeImage: "workout"),
            Theme(themeName: "Reading", themeImage: "reading"),
            Theme(themeName: "Meditation", themeImage: "meditation"),
            Theme(themeName: "Others", themeImage: "others")
        ]
        completion?()
    }
}
