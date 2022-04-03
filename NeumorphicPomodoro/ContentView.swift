//
//  ContentView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 1/4/22.
//

import SwiftUI

enum PomodoroState {
    case Empty, Playing, Paused
}

struct ContentView: View {
    
    @State var pomodoroState = PomodoroState.Empty
    @State var isPlaying = false
    @State var isCreationPresented : Bool = false
    @StateObject var work = Work()
    
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
                ButtonPad(pomodoroState: $pomodoroState, showCreation: {isCreationPresented = true}, showCancelAlert: showCancelAlert)
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
    }
    
    func showCancelAlert() {
        alertMessage = "Do you want to finish the current task?"
        alertTitle = "Stop task"
        alertConfirmAction = {
            withAnimation{
                work.isWork = true
                work.timeRemaining = 0
                work.task = ""
                work.currentPomodoro = 0
                work.currentRest = 0
                work.currentPomodoroLength = 0
                pomodoroState = .Empty
            }
            
        }
        
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
