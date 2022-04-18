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
            Text(pomodoroSession.unwrappedTask)
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
