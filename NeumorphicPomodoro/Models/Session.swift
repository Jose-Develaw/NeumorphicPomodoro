//
//  Session.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 6/4/22.
//

import Foundation

enum TimeType {
    case pomodoro, rest
}

enum TaskType : String {
    case work = "Work"
    case personal = "Personal"
}
struct Session {
    
    var taskType = TaskType.work
    var taskName = ""
    var totalPomodoros = 0
    var longRest = 0.0
    
    var currentPomodoro = 0
    var timeRemaining = 0
    var currentPomodoroLength = 0.0
    var currentType = TimeType.pomodoro
}
