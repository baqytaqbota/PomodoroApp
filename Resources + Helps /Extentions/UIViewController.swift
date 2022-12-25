//
//  UIViewController .swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 05.12.2022.
//

import UIKit

extension UIViewController {
    func formatTimer(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
