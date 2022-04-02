//
//  ContentView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 1/4/22.
//

import SwiftUI

struct CardModifier : ViewModifier {
    func body(content: Content) -> some View {
            content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.offWhite)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
             )
        }
}

extension View {
    func applyCardStyle() -> some View {
        return self.modifier(CardModifier())
    }
}

extension Color {
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
}

extension LinearGradient {
    init(_ colors: Color...){
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct NeumorphicButtonStyle<Content: InsettableShape>: ButtonStyle {
    
    var width : CGFloat
    var heigth : CGFloat
    var shape : Content
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: width, maxHeight: heigth)
            .contentShape(shape)
            .background(
                Group{
                    if configuration.isPressed{
                        shape
                            .fill(Color.offWhite)
                            .overlay(
                                shape
                                    .stroke(.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask {
                                        shape
                                            .fill(LinearGradient(.black, .clear))
                                    }
                            )
                            .overlay(
                                shape
                                    .stroke(.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask {
                                        shape
                                            .fill(LinearGradient(.clear, .black))
                                    }
                            )
                            
                    } else {
                        shape
                            .fill(Color.offWhite)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                    
                }
            )
    }
}

struct ContentView: View {
    
    @State var isPlaying = false
    var body: some View {
        ZStack{
            Color.offWhite
            VStack{
                Spacer()
                HStack(alignment: .lastTextBaseline, spacing: 20){
                    Text("""
                        Neumorphic
                        Pomodoro
                        """)
                        .font(.largeTitle.bold())
                        .foregroundColor(.black.opacity(0.8))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    Text("""
                        The app
                        for you to
                        work better
                        """)
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                Spacer()
                ZStack{
                    VStack(spacing: 10){
                        Text("Time left")
                            .font(.title3)
                            .foregroundColor(.gray)
                        Text("20:00")
                            .font(.largeTitle.bold())
                            .foregroundColor(.black.opacity(0.8))
                        Text("P1")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    Arc(startAngle: .degrees(0), tickingAmount: 240, clockwise: true)
                        .strokeBorder(LinearGradient(.purple, .pink), style: StrokeStyle(lineWidth: 12.5, lineCap: .round, lineJoin: .round))
                        .frame(maxWidth: 285, maxHeight: 285)
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
                }
             
              
                Spacer()
                VStack(alignment: .center, spacing: 5){
                    Text("Name of current task")
                        .font(.title2.bold())
                        .foregroundColor(.black.opacity(0.8))
                    
                    Text("Kind of task")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack(spacing: 5){
                    Button{
                        isPlaying = false
                    }label: {
                        Image(systemName: "stop")
                            .font(.title)
                            .foregroundStyle(LinearGradient(.purple, .pink))
                    }
                    .buttonStyle(NeumorphicButtonStyle(width: 70, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
                    .padding(10)
                 
                    Button{
                        print("Button pressed")
                        isPlaying.toggle()
                    }label: {
                        Image(systemName: isPlaying ? "pause": "play")
                            .font(.largeTitle)
                            .foregroundStyle(LinearGradient(.purple, .pink))
                    }
                    .buttonStyle(NeumorphicButtonStyle(width: 100, heigth: 100, shape: Circle()))
                    .padding(10)
            
                    Button{
                        print("Button pressed")
                    }label: {
                        Image(systemName: "forward.end.alt")
                            .font(.title)
                            .foregroundStyle(LinearGradient(.purple, .pink))
                    }
                    .buttonStyle(NeumorphicButtonStyle(width: 70, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
                    .padding(10)
                   
                }
                .frame(maxWidth: 350, maxHeight: 150)
                .applyCardStyle()
                Spacer()
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
