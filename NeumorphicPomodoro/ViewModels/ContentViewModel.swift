//
//  ContentViewModel.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 6/4/22.
//

import Combine
import SwiftUI

extension ContentView {
    
     class ViewModel: ObservableObject {
        
        @Published var currentSession = Session()
        @Published var isTimerWorking = false
        var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
        var connectedTimer: Cancellable? = nil
        let delegate = NotificationDelegate()
        
        var remainingClock : String {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            return formatter.string(from: TimeInterval(currentSession.timeRemaining))!
        }
        
        var tickingAmount : Double {
            Double(currentSession.timeRemaining) / Double(currentSession.currentPomodoroLength) * 360
        }
        
        func createSession() {
            currentSession.currentPomodoro += 1
            currentSession.timeRemaining = 10
            currentSession.currentPomodoroLength = 10
        }
        
        func changeRound () {
            if(currentSession.currentType == .pomodoro){
                currentSession.currentType = .rest
                
            } else {
                currentSession.currentType = .pomodoro
                currentSession.currentPomodoro += 1
            }
            currentSession.timeRemaining = 10
            currentSession.currentPomodoroLength = 10
        }
        
        func changeTaskType() {
            currentSession.taskType = currentSession.taskType == .work ? .personal : .work
        }
         
         func instantiateTimer() {
             print("instantiateTimer")
             if(currentSession.timeRemaining > 0){
                 let notificationData = NotificationData(title: "Well done!", subtitle: "Time to rest", timeInterval: Double(currentSession.timeRemaining))
                 delegate.createNotification(notificationData: notificationData)
             }
             self.timer = Timer.publish(every: 1, on: .main, in: .common)
             self.connectedTimer = self.timer.connect()
             isTimerWorking = true
             return
         }
             
         func cancelTimer() {
             delegate.cancelNotification()
             self.connectedTimer?.cancel()
             isTimerWorking = false
             return
         }
    }
}
