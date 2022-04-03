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
                ButtonPad(isPlaying: $isPlaying, pomodoroState: $pomodoroState, showCreation: {isCreationPresented = true})
                Spacer()
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isCreationPresented){
            CreateWorkView(work: work)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
