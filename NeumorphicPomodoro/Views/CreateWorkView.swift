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
                        TextField("Task name", text: $work.task)
                            .foregroundColor(.black)
                      }
                      .padding()
                      .background(
                         RoundedRectangle(cornerRadius: 20)
                            .fill(Color.offWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 1, y: 2)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LinearGradient(colors: [.black, .clear], startPoint: UnitPoint(x: 0.495, y: 0), endPoint: UnitPoint(x: 0.505, y: 1)))
                                    }
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -1)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LinearGradient(colors: [.clear, .black], startPoint: UnitPoint(x: 0.495, y: 0), endPoint: UnitPoint(x: 0.505, y: 1)))
                                    }
                            )
                       )
                    Picker("Type", selection: $work.type){
                        ForEach(pickerOptions, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .colorMultiply(.offWhite)
                }
                .padding()
                .applyCardStyle()
                
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
