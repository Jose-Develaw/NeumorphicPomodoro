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
            Double(currentSession.timeRemaining) / Double(currentSession.currentRoundInterval) * 360
        }
        
        func createSession() {
            currentSession.currentRound += 1
            currentSession.longRestCadence = 2
            currentSession.longRestLength = 9
            currentSession.timeRemaining = 15
            currentSession.currentRoundInterval = 15
        }
        
        func changeRound () {
            if(currentSession.currentIntervalType == .pomodoro){
                currentSession.currentIntervalType = .rest
                
            } else {
                currentSession.currentIntervalType = .pomodoro
                currentSession.currentRound += 1
            }
            
            currentSession.currentRoundInterval = getInterval()
            currentSession.timeRemaining = Int(getInterval())
        }
        
        func changeTaskType() {
            currentSession.taskType = currentSession.taskType == .work ? .personal : .work
        }
         
        func instantiateTimer() {
             
             if(currentSession.timeRemaining > 0){
                 delegate.createNotification(notificationData: buildNotification())
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
         
         func buildNotification() -> NotificationData {
             let title = currentSession.currentIntervalType == .pomodoro ? "Pomodoro \(currentSession.currentRound) completed" : "Rest \(currentSession.currentRound) is over"
             let message = currentSession.currentIntervalType == .pomodoro ? "It's time for you to rest" : "Let's do some work!"
             
             let interval = getInterval()
             
             return NotificationData(title: title, subtitle: message, timeInterval: interval)
         }
         
         func getInterval() -> Double {
             return currentSession.currentIntervalType == .pomodoro ? 15 : currentSession.currentRound == currentSession.longRestCadence ? currentSession.longRestLength : 3
         }
    }
}
