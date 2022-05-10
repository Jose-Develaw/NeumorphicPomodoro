//
//  CreatePomodoroView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import SwiftUI

struct CreateWorkView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: SettingsWrapper
    @Binding var pomodoroState : PomodoroState
    @ObservedObject var viewModel: ContentView.ViewModel
    var disabled : Bool {
        viewModel.currentSession.taskName.isEmpty
    }
    
    var btnClose : some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.title3)
                .foregroundStyle(LinearGradient(.purple, .pink))
        }
    }
    
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
                        TextField("Short description", text: $viewModel.currentSession.taskName)
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.8))
                            .accentColor(.pink)
                      }
                    .padding()
                    .background(ShallowConcaveView(cornerRadius: 10))
                    .frame(maxWidth: 350)
                    
                    CustomToggle(width: 350, height: 60, toggleWidthOffset: 50, cornerRadius: 10, padding: 10, toggleAction: toggleType)
                    
                    Button{
                        viewModel.createSession(settings)
                        pomodoroState = .Paused
                        dismiss()
                    }label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundStyle(disabled ? LinearGradient(.gray) : LinearGradient(.purple, .pink))
                        
                    }
                    .buttonStyle(NeumorphicButtonStyle(width: 70, heigth: 70, shape: RoundedRectangle(cornerRadius: 20)))
                    .disabled(disabled)
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .navigationBarItems(leading: btnClose)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
    }
    
    func toggleType(){
        viewModel.changeTaskType()
    }
}

struct CreateWorkView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkView(pomodoroState: .constant(.Empty), viewModel: ContentView.ViewModel())
    }
}
