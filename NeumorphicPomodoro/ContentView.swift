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
    
    @StateObject var viewModel = ViewModel()
    
    @Environment(\.scenePhase) var scenePhase
    @State var savedDate : Date = Date.now
    @State var pomodoroState = PomodoroState.Empty
    @State var isCreationPresented : Bool = false
    
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var alertConfirmAction : () -> Void = {}
    
    
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
                    Counter(pomodoroState: $pomodoroState, viewModel: viewModel)
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
                        Text(viewModel.currentSession.taskName)
                            .font(.title2.bold())
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text(viewModel.currentSession.taskType.rawValue)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                ButtonPad(pomodoroState: $pomodoroState, showCreation: {isCreationPresented = true}, showCancelAlert: showCancelAlert, changeRound: viewModel.changeRound)
                Spacer()
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isCreationPresented){
            CreateWorkView(pomodoroState: $pomodoroState, viewModel: viewModel)
        }
        .alert(alertTitle, isPresented: $showAlert){
            Button("Confirm", role: .none, action: alertConfirmAction)
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text(alertMessage)
        }
        .onAppear{
            viewModel.delegate.requestAuthorization()
        }
        .onReceive(viewModel.timer){ _ in
            print("onReceiveTimer")
            if(pomodoroState == .Playing && viewModel.currentSession.timeRemaining > 0){
                viewModel.currentSession.timeRemaining -= 1
            } else {
                pomodoroState = .Paused
                viewModel.changeRound()
            }
        }
        .onChange(of: pomodoroState) { _ in
            if (pomodoroState == .Paused || pomodoroState == .Empty) {
                viewModel.cancelTimer()
            } else {
                print("Receive play")
                viewModel.instantiateTimer()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if(pomodoroState == .Playing)
                {
                    let interval = Date.now.timeIntervalSinceReferenceDate - savedDate.timeIntervalSinceReferenceDate
                    viewModel.currentSession.timeRemaining -= Int(interval)
                    if (viewModel.currentSession.timeRemaining > 0){
                        viewModel.instantiateTimer()
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
                viewModel.currentSession = Session()
            }
        }
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(savedDate: Date.now)
    }
}


