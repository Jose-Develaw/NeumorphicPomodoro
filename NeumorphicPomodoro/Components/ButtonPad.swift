//
//  ButtonPad.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct ButtonPad: View {
    
    @Binding var pomodoroState : PomodoroState
    var showCreation : () -> Void
    var showCancelAlert : () -> Void
    var instantiateTimer : () -> Void
    var cancelTimer : () -> Void
    var changeRound : () -> Void
    var disabled : Bool {
        pomodoroState == .Empty
    }
    
    var body: some View {
        HStack(spacing: 5){
           
            Button{
                showCancelAlert()
            }label: {
                Image(systemName: "stop")
                    .font(.title)
                    .foregroundStyle(disabled ? LinearGradient(.gray) : LinearGradient(.purple, .pink))
            }
            .buttonStyle(NeumorphicButtonStyle(width: 70, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
            .padding(10)
            .disabled(disabled)
            
            Button{
                if(disabled){
                    showCreation()
                } else {
                    if (pomodoroState == .Paused){
                        pomodoroState = .Playing
                        instantiateTimer()
                    } else {
                        pomodoroState = .Paused
                        cancelTimer()
                    }   
                }
                
            }label: {
                if(!disabled){
                    Image(systemName: pomodoroState == .Playing ? "pause": "play")
                        .font(.largeTitle)
                        .foregroundStyle(LinearGradient(.purple, .pink))
                } else {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundStyle(LinearGradient(.purple, .pink))
                }
            }
            .buttonStyle(NeumorphicButtonStyle(width: 100, heigth: 100, shape: Circle()))
            .padding(10)
    
           
            Button{
                cancelTimer()
                pomodoroState = .Paused
                changeRound()
            }label: {
                Image(systemName: "forward.end.alt")
                    .font(.title)
                    .foregroundStyle(disabled ? LinearGradient(.gray) : LinearGradient(.purple, .pink))
                
            }
            .buttonStyle(NeumorphicButtonStyle(width: 70, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
            .padding(10)
            .disabled(disabled)
            
           
        }
        .frame(maxWidth: 350, maxHeight: 150)
        .applyCardStyle()
        

    }
}

struct ButtonPad_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPad(pomodoroState: .constant(.Empty), showCreation: {}, showCancelAlert: {}, instantiateTimer: {}, cancelTimer: {}, changeRound: {})
    }
}
