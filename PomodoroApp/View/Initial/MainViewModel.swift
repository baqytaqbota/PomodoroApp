//
//  MainViewModel.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 04.12.2022.
//

import Foundation

enum TimerState {
    case focus
    case rest
    case focusCount
    case restCount
}

final class MainViewModel {
    private var timer = Timer()
    private var isTimerRunning = false
    private var focusPeriod = true
    var isChangeButtonImageIfNeeded = false
    var updateViewIfNeeded: ((TimerState) -> ())?
    lazy var breakTime = getTimeFromSettings()
    lazy var focusTime = getTimeFromSettings()
    
    func getTimeLabelFromSettings() {
        if !isTimerRunning {
            if focusPeriod {
                focusTime = getTimeFromSettings()
                updateViewIfNeeded?(TimerState.focus)
            } else {
                breakTime = getTimeFromSettings()
                updateViewIfNeeded?(TimerState.rest)
            }
        } else {
            if focusPeriod {
                updateViewIfNeeded?(TimerState.focusCount)
            } else {
                updateViewIfNeeded?(TimerState.restCount)
            }
        }
    }
    
    func startTimer() {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            isChangeButtonImageIfNeeded = true
        } else {
            timer.invalidate()
            isTimerRunning = false
            isChangeButtonImageIfNeeded = false
        }
    }
    
    @objc
    fileprivate func updateTimer() {
        if focusPeriod {
            if focusTime < 1 {
                timer.invalidate()
                isTimerRunning = false
                focusPeriod = false
                focusTime = getTimeFromSettings()
                updateViewIfNeeded?(TimerState.rest)
            } else {
                focusTime -= 1
                updateViewIfNeeded?(TimerState.focusCount)
            }
        } else {
            if breakTime < 1 {
                timer.invalidate()
                isTimerRunning = false
                focusPeriod = true
                breakTime = getTimeFromSettings()
                updateViewIfNeeded?(TimerState.focus)
            } else {
                breakTime -= 1
                updateViewIfNeeded?(TimerState.restCount)
            }
        }
    }
    
    func stopTimer() {
        timer.invalidate()
        isTimerRunning = false
        isChangeButtonImageIfNeeded = false 
        if focusPeriod {
            focusTime = getTimeFromSettings()
            updateViewIfNeeded?(TimerState.focus)
        } else {
            breakTime = getTimeFromSettings()
            updateViewIfNeeded?(TimerState.rest)
        }
    }
    
    func getTimeFromSettings() -> Int {
        if focusPeriod {
            let focusTimeString =  UserDefaultsService.getFocusTime()
            let fullTime = focusTimeString.components(separatedBy: ":")
            let minutesString = fullTime[0]
            let minutes = Int(minutesString)
            let secondsString = fullTime[1]
            let seconds = Int(secondsString)
            if let focusMinutes = minutes, let focusSeconds = seconds {
                focusTime = (focusMinutes*60)+focusSeconds
            }
            return focusTime
        } else {
            let breakTimeString = UserDefaultsService.getBreakTime()
            let fullTime = breakTimeString.components(separatedBy: ":")
            let minutesString = fullTime[0]
            let minutes = Int(minutesString)
            let secondsString = fullTime[1]
            let seconds = Int(secondsString)
            if let breakMinutes = minutes, let breakSeconds = seconds {
                breakTime = (breakMinutes*60)+breakSeconds
            }
            return breakTime
        }
    }
    
}
