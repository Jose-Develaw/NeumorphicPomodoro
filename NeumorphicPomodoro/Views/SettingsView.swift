//
//  SettingsView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @EnvironmentObject var settings: SettingsWrapper
    
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
            VStack (spacing: 10){
                CustomStepper(value: $settings.settings.basicPomodoroLength, textColor: .black, text: "Pomodoro length", from: 1, to: 40)
                
                CustomStepper(value: $settings.settings.basicRestLength, textColor: .black, text: "Basic rest length", from: 1, to: 10)
                    
                CustomStepper(value: $settings.settings.longRestCadence, textColor: .black, text: "Long rest cadence", from: 1, to: 8)
                  
                CustomStepper(value: $settings.settings.longRestLength, textColor: .black, text: "Long rest length", from: 1, to: 30)
                    
                Spacer()
            }
            .padding()
            
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .toolbar{
            
        }
        .background(Color.offWhite)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                
                    if(value.startLocation.x < 30 && value.translation.width > 100) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
