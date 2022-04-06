//
//  Session.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 6/4/22.
//

import Foundation

enum IntervalType {
    case pomodoro, rest
}

enum TaskType : String {
    case work = "Work"
    case personal = "Personal"
}
struct Session {
    
    //Task specifics
    var taskType = TaskType.work
    var taskName = ""
    
    //Settings
    var basicRestLength = 0.0
    var basicPomodoroLength = 0.0
    var longRestCadence = 0
    var longRestLength = 0.0
    
    //Interval Information
    var currentRound = 0
    var timeRemaining = 0
    var currentRoundInterval = 0.0
    var currentIntervalType = IntervalType.pomodoro
}
