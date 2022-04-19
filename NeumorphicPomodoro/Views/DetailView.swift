//
//  DetailView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 18/4/22.
//

import SwiftUI

struct DetailView: View {
    
    var pomodoroSession : PomodoroSession
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var longRestLengthMinutes : Int {
        Int(pomodoroSession.longRestLength / 60)
    }
    
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
           
            Image(systemName: "arrowshape.turn.up.backward")
                .font(.title2)
                .foregroundStyle(LinearGradient(.purple, .pink))
            
        }
    }
    
    var body: some View {
        ZStack{
            Color.offWhite
            VStack(alignment: .leading){
                VStack(alignment: .center, spacing: 5){
                    Text(pomodoroSession.unwrappedTask.capitalizingFirstLetter())
                        .font(.title.bold())
                    Text(pomodoroSession.unwrappedType)
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("\(pomodoroSession.date?.formatted(date: .abbreviated, time: .shortened) ?? " ")".capitalizingFirstLetter())
                }
                .frame(maxWidth: .infinity)
               
                .padding()
                
                
                VStack (alignment: .leading, spacing: 5){
                    Text("Settings info")
                        .font(.title2.bold())
                        .padding(.bottom, 5)
                        
                    Text("Pomodoro length: \(Int(pomodoroSession.pomodoroLength))")
                    Text("Normal rest length: \(Int(pomodoroSession.restLenght))")
                    Text("Long rest length: \(longRestLengthMinutes)")
                    Text("Rest cadence: \(pomodoroSession.restCadence)")
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(ShallowConcaveView(cornerRadius: 10))
                .padding()
                
                
                VStack (alignment: .leading, spacing: 5){
                    Text("Session info")
                        .font(.title2.bold())
                        .padding(.bottom, 5)
                    Text("Number of pomodoros: \(pomodoroSession.numberOfPomodoros)")
                    Text("Number of rests: \(pomodoroSession.numberOfRests)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(ShallowConcaveView(cornerRadius: 10))
                .padding()
               
                Spacer()
            }
            .padding(.vertical)
        }
        .background(Color.offWhite)
        .navigationTitle("Session details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .gesture(DragGesture().updating($dragOffset, body: {(value, state, transaction) in
                if(value.startLocation.x < 30 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                    
        }))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pomodoroSession: PomodoroSession())
    }
}
