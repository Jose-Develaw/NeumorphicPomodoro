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

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

class ChangingWidth : ObservableObject {
    @Published var width : CGFloat = .zero
}

struct ContentView: View {
    
    @EnvironmentObject var settings: SettingsWrapper
    @StateObject var viewModel = ViewModel()
    
    @Environment(\.scenePhase) var scenePhase
    @State var savedDate : Date = Date.now
    @State var savedRemaining : Int = 0
    @State var pomodoroState = PomodoroState.Empty
    @State var isCreationPresented : Bool = false
    
    @State var scrollText: Bool = false
    @ObservedObject var textWidth = ChangingWidth()
    @State var otherProp: CGFloat = .zero
    @State var offsetX: CGFloat = .zero
    let titleWidth: CGFloat = 350
    
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
                            Text("Gotta do some work?")
                                .font(.title2.bold())
                                .foregroundColor(.black.opacity(0.8))
                            Text("Press plus button when you are ready")
                                .font(.title3)
                                .foregroundColor(.gray)
                        } else {
//                            HStack{
//                                ScrollView(.horizontal)
//                                {
//
//                                    Text(viewModel.currentSession.taskName)
//                                        .font(.title2.bold())
//                                        .foregroundColor(.black.opacity(0.8))
//                                        .background(ViewGeometry())
//                                        .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: scrollText)
//                                        .onAppear {
//                                            print("On appear")
//                                        }
//                                        .offset(x: offsetX, y: 0)
//                                        .onPreferenceChange(ViewSizeKey.self) {
//
//                                            if (titleWidth < $0.width) {
//                                                print("Es menor title, text: ", titleWidth, $0.width)
//                                                self.scrollText = true
//                                            }
//
//                                            offsetX = titleWidth < $0.width ? scrollText ? ($0.width * -1) - (titleWidth / 2) : titleWidth : 0
//
//                                            print("Offset x: ", offsetX)
//
//                                        }
//
//
//                                }
//                            }
//                            .frame(maxWidth: titleWidth, alignment: .center)
//
//                            HStack
//                               {
//                                   ScrollView(.horizontal)
//                                   {
//                                       Text("13. This is my very long text title for a tv show")
//                                           .frame(minWidth: titleWidth, alignment: .center)
//                                           .offset(x: (titleWidth < 500) ? (scrollText ? (500 * -1) - (titleWidth / 2) : titleWidth ) : 0, y: 0)
//                                           .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: scrollText)
//                                           .onAppear {
//
//                                           }
//                                   }
//                               }
//                               .frame(maxWidth: titleWidth, alignment: .center)
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
                    ButtonPad(pomodoroState: $pomodoroState, showCreation: {isCreationPresented = true}, showCancelAlert: showCancelAlert, changeRound: callChangeRound)
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
                    viewModel.changeRound(settings)
                }
            }
            .onChange(of: pomodoroState) { _ in
                if (pomodoroState == .Paused || pomodoroState == .Empty) {
                    viewModel.cancelTimer()
                } else {
                    viewModel.instantiateTimer(settings)
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("active")
                    if(pomodoroState == .Playing)
                    {
                        let interval = Date.now.timeIntervalSinceReferenceDate - savedDate.timeIntervalSinceReferenceDate
                        
                        print("Interval", interval)
                        if(Int(interval) > savedRemaining) {
                            viewModel.currentSession.timeRemaining = 0
                        } else {
                            viewModel.currentSession.timeRemaining -= Int(interval)
                            viewModel.instantiateTimer(settings)
                        }
                       
                    }
                } else if newPhase == .background {
                    print("Background")
                    savedDate = Date.now
                    savedRemaining = viewModel.currentSession.timeRemaining
                } else if newPhase == .inactive {
                    print("Inactive")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink{
                        HistoryView()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.title2)
                            .foregroundStyle(pomodoroState == .Empty ? LinearGradient(.purple, .pink) : LinearGradient(.gray) )
                    }
                    .disabled(pomodoroState != .Empty)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        SettingsView()
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
        .preferredColorScheme(.light)
    }
    
    func callChangeRound() {
        viewModel.changeRound(settings)
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


