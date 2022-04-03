//
//  ButtonPad.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct ButtonPad: View {
    
    @Binding var isPlaying : Bool
    @Binding var pomodoroState : PomodoroState
    var showCreation : () -> Void
    var disabled : Bool {
        pomodoroState == .Empty
    }
    
    var body: some View {
        HStack(spacing: 5){
           
            Button{
                isPlaying = false
                pomodoroState = .Empty
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
                    pomodoroState = .Paused
                    showCreation()
                } else {
                    isPlaying.toggle()
                }
                
            }label: {
                if(!disabled){
                    Image(systemName: isPlaying ? "pause": "play")
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
                print("Button pressed")
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
        ButtonPad(isPlaying: .constant(false), pomodoroState: .constant(.Empty), showCreation: {})
    }
}
