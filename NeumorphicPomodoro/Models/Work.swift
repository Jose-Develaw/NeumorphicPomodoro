//
//  Pomodoro.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import Foundation

class Work : ObservableObject, Identifiable{
    
    @Published var id = UUID()
    @Published var isWork = true
    @Published var task = ""
    @Published var currentPomodoro = 0
    @Published var currentRest = 0
    @Published var timeRemaining = 0
    
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
    
}
