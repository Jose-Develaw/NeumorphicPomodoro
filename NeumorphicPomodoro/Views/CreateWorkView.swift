//
//  CreatePomodoroView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import SwiftUI

struct CreateWorkView: View {
    
    @ObservedObject var work : Work
    var pickerOptions = ["Work", "Personal"]
    var body: some View {
        ZStack{
            Color.offWhite
            VStack{
                VStack{
                    Text("Create new task")
                        .font(.title2.bold())
                        .foregroundColor(.black.opacity(0.8))
                    
                    Text("Introduce task information")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                VStack{
                    HStack {
                        TextField("Short description", text: $work.task)
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.8))
                      }
                      .padding()
                      .background(ZStack{
                          RoundedRectangle(cornerRadius: 20)
                              .fill(Color.offWhite)
                                      RoundedRectangle(cornerRadius: 20)
                              .stroke(Color.gray, lineWidth: 4)
                                          .blur(radius: 4)
                                          .offset(x: 1, y: 0.5)
                                          .mask(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(colors: [Color.gray, Color.clear], startPoint: .top, endPoint: .bottom)))
                                      RoundedRectangle(cornerRadius: 20)
                              .stroke(Color.white, lineWidth: 8)
                                          .blur(radius: 4)
                                          .offset(x: -1, y: -1.5)
                                          .mask(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom)))
                      })
                    
                    HStack {
                        Button{
                            work.type = "Work"
                        }label: {
                            Text("Work")
                                .foregroundStyle(work.type == "Personal" ? LinearGradient(.gray) : LinearGradient(.purple, .pink))
                        }
                        .buttonStyle(NeumorphicButtonStyle(width: 100, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
                        .padding(10)
                        
                        Button{
                            work.type = "Personal"
                        }label: {
                            Text("Personal")
                                .foregroundStyle(work.type == "Work" ? LinearGradient(.gray) : LinearGradient(.purple, .pink))
                        }
                        .buttonStyle(NeumorphicButtonStyle(width: 100, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
                        .padding(10)
                    }
                }
                .padding()
                
                Spacer()
                
                
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
    }
}

struct CreateWorkView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkView(work: Work())
    }
}
