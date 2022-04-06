//
//  Pomodoro.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import Foundation

class Work : ObservableObject {
    
    enum TimeType {
        case pomodoro, rest
    }
    
    enum TaskType : String{
        case work = "Work",
        personal = "Personal"
    }
    
    @Published var isWork = true
    @Published var task = ""
    @Published var currentPomodoro = 0
    @Published var totalPomodoros = 5
    @Published var currentRest = 0
    @Published var timeRemaining = 0
    @Published var currentPomodoroLength = 0
    @Published var currentType = TimeType.pomodoro
    
    var type : String {
        isWork ? "Work" : "Personal"
    }
    
    var remainingClock : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(timeRemaining))!
    }
    
    var tickingAmount : Double {
        Double(timeRemaining) / Double(currentPomodoroLength) * 360
    }
    
    func createSession() {
        currentPomodoro += 1
        timeRemaining = 10
        currentPomodoroLength = 10
    }
    
    func changeRound () {
        if(currentType == .pomodoro){
            currentType = .rest
            currentRest += 1
        } else {
            currentType = .pomodoro
            currentPomodoro += 1
        }
        timeRemaining = 10
        currentPomodoroLength = 10
    }
}
