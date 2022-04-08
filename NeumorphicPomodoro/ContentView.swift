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
    
    @State var scrollText: Bool = false
    let textWidth: CGFloat = 460
    let titleWidth: CGFloat = 350
    let titleHeight: CGFloat = 70.0
    
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var alertConfirmAction : () -> Void = {}
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.offWhite
                VStack{
                    Header()
                    Counter(pomodoroState: $pomodoroState, viewModel: viewModel)
                    Spacer()
                    Spacer()
                    VStack(alignment: .center, spacing: 5){
                        if(pomodoroState == .Empty){
                            HStack{
                                ScrollView(.horizontal)
                                {
                                    Text("Gotta do some work?")
                                        .font(.title2.bold())
                                        .foregroundColor(.black.opacity(0.8))
                                        .frame(minWidth: titleWidth, minHeight: titleHeight, alignment: .center)
                                        .offset(x: (titleWidth < textWidth) ? (scrollText ? (textWidth * -1) - (titleWidth / 2) : titleWidth ) : 0, y: 0)
                                        .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: scrollText)
                                        .onAppear {
                                            self.scrollText.toggle()
                                        }
                                }
                            }
                            .frame(maxWidth: titleWidth, alignment: .center)
                            
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
                    Spacer()
                    ButtonPad(pomodoroState: $pomodoroState, showCreation: {isCreationPresented = true}, showCancelAlert: showCancelAlert, changeRound: viewModel.changeRound)
                    Spacer()
                }
                .padding()
                .transition(.slide)
            }
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
                if(pomodoroState == .Playing && viewModel.currentSession.timeRemaining > 0){
                    withAnimation{
                        viewModel.currentSession.timeRemaining -= 1
                    }
                } else {
                    pomodoroState = .Paused
                    viewModel.changeRound()
                }
            }
            .onChange(of: pomodoroState) { _ in
                if (pomodoroState == .Paused || pomodoroState == .Empty) {
                    viewModel.cancelTimer()
                } else {
                    viewModel.instantiateTimer()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    if(pomodoroState == .Playing)
                    {
                        let interval = Date.now.timeIntervalSinceReferenceDate - savedDate.timeIntervalSinceReferenceDate
                        if(Double(interval) > viewModel.currentSession.currentRoundInterval) {
                            viewModel.instantiateTimer()
                        } else {
                            viewModel.currentSession.timeRemaining -= Int(interval)
                        }
                       
                    }
                } else if newPhase == .background {
                    savedDate = Date.now
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink{
                        Text("History")
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.title2)
                            .foregroundStyle(pomodoroState == .Empty ? LinearGradient(.purple, .pink) : LinearGradient(.gray) )
                    }
                    .disabled(pomodoroState != .Empty)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        Text("Settings")
                    } label: {
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundStyle(pomodoroState == .Empty ? LinearGradient(.purple, .pink) : LinearGradient(.gray) )
                    }
                    .disabled(pomodoroState != .Empty)
                }
            }
            .background(Color.offWhite)
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


