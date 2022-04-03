//
//  Counter.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct Counter : View {
    
    @Binding var pomodoroState : PomodoroState
    @ObservedObject var work : Work
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text("Time left")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text("00:00")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black.opacity(0.8))
                Text("P\(work.currentPomodoro)")
                    .font(.title)
                    .foregroundColor(.gray)
            }
           
            Circle()
                .stroke(lineWidth: 8)
                .fill(Color.offWhite)
                .overlay(
                    Circle()
                        .stroke(.gray, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask {
                            Circle()
                                .fill(LinearGradient(.black, .clear))
                        }
                )
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 8)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask {
                            Circle()
                                .fill(LinearGradient(.clear, .black))
                        }
                )
                .frame(maxWidth: 300, maxHeight: 300)
            Circle()
                .stroke(lineWidth: 8)
                .fill(Color.offWhite)
                .overlay(
                    Circle()
                        .stroke(.gray, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask {
                            Circle()
                                .fill(LinearGradient(.clear, .black))
                        }
                )
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 8)
                        .blur(radius: 4)
                        .offset(x: -2, y: -2)
                        .mask {
                            Circle()
                                .fill(LinearGradient(.black, .clear))
                        }
                )
                .frame(maxWidth: 270, maxHeight: 270)
            if(pomodoroState != .Empty){
                Arc(startAngle: .degrees(0), tickingAmount: 240, clockwise: true)
                    .strokeBorder(LinearGradient(.purple, .pink), style: StrokeStyle(lineWidth: 12.5, lineCap: .round, lineJoin: .round))
                    .frame(maxWidth: 285, maxHeight: 285)
            }
        }
    }
}
