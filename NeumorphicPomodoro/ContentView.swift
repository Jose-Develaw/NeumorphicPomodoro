//
//  ContentView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 1/4/22.
//

import Combine
import SwiftUI

enum PomodoroState {
    case Empty, Playing, Paused
}

struct ContentView: View {
    @StateObject var delegate = NotificationDelegate()
    
    @Environment(\.scenePhase) var scenePhase
    @State var savedDate : Date = Date.now
    
    @State var pomodoroState = PomodoroState.Empty
    
    @State var isCreationPresented : Bool = false
    
    @StateObject var work = Work()
    
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var alertConfirmAction : () -> Void = {}
    
    //Timer
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    
    var body: some View {
        ZStack{
            Color.offWhite
            VStack{
                Spacer()
                HStack{
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.title)
                            .foregroundStyle(LinearGradient(.purple, .pink))
                    }
                    Spacer()
                    Button{
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundStyle(LinearGradient(.purple, .pink))
                    }
                    
                }
                Group{
                    Spacer()
                    Header()
                    Spacer()
                    Counter(pomodoroState: $pomodoroState, work: work)
                    Spacer()
                }
                
                VStack(alignment: .center, spacing: 5){
                    if(pomodoroState == .Empty){
                        Text("Gotta do some work?")
                            .font(.title2.bold())
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("Press plus button when you are ready")
                            .font(.title3)
                            .foregroundColor(.gray)
                    } else {
                        Text(work.task)
                            .font(.title2.bold())
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text(work.type)
                            .font(.title3)
                        .foregroundColor(.gray)
                    }
                }
                Spacer()
                ButtonPad(pomodoroState: $pomodoroState, showCreation: {isCreationPresented = true}, showCancelAlert: showCancelAlert, changeRound: changeRound)
                Spacer()
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isCreationPresented){
            CreateWorkView(pomodoroState: $pomodoroState, work: work)
        }
        .alert(alertTitle, isPresented: $showAlert){
            Button("Confirm", role: .none, action: alertConfirmAction)
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text(alertMessage)
        }
        .onAppear{
            delegate.requestAuthorization()
        }
        .onReceive(timer){ _ in
            if(pomodoroState == .Playing && work.timeRemaining > 0){
                work.timeRemaining -= 1
            } else {
                pomodoroState = .Paused
                changeRound()
            }
        }
        .onChange(of: pomodoroState) { _ in
            if (pomodoroState == .Paused || pomodoroState == .Empty) {
                cancelTimer()
            } else {
                instantiateTimer()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if(pomodoroState == .Playing)
                {
                    let interval = Date.now.timeIntervalSinceReferenceDate - savedDate.timeIntervalSinceReferenceDate
                    work.timeRemaining -= Int(interval)
                    if (work.timeRemaining > 0){
                        instantiateTimer()
                    }
                }
            } else if newPhase == .background {
                savedDate = Date.now
            }
        }
    }
    
    func showCancelAlert() {
        alertMessage = "Do you want to finish the current task?"
        alertTitle = "Stop task"
        alertConfirmAction = {
            pomodoroState = .Empty
            withAnimation{
                work.isWork = true
                work.timeRemaining = 0
                work.task = ""
                work.currentPomodoro = 0
                work.currentRest = 0
                work.currentPomodoroLength = 0
                work.currentType = .pomodoro
                work.totalPomodoros = 5
            }
        }
        
        showAlert = true
    }
    
    func instantiateTimer() {
        if(work.timeRemaining > 0){
            let notificationData = NotificationData(title: "Well done!", subtitle: "Time to rest", timeInterval: Double(work.timeRemaining))
            delegate.createNotification(notificationData: notificationData)
        }
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        return
    }
        
    func cancelTimer() {
        delegate.cancelNotification()
        self.connectedTimer?.cancel()
        return
    }
    
    func changeRound() {
        work.changeRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(savedDate: Date.now)
    }
}


