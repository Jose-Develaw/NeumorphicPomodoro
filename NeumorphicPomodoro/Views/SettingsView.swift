//
//  SettingsView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settings: SettingsWrapper
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
               
                Image(systemName: "arrowshape.turn.up.backward")
                    .font(.title2)// set image here
                    .foregroundStyle(LinearGradient(.purple, .pink))
                
            }
        }
    
    var body: some View {
        ZStack{
            Color.offWhite
            VStack (spacing: 10){
                CustomStepper(value: $settings.settings.basicPomodoroLength, textColor: .black, text: "Pomodoro length")
                
                CustomStepper(value: $settings.settings.basicRestLength, textColor: .black, text: "Basic rest length")
                    
                CustomStepper(value: $settings.settings.longRestCadence, textColor: .black, text: "Long rest cadence")
                  
                CustomStepper(value: $settings.settings.longRestLength, textColor: .black, text: "Long rest length")
                    
                Spacer()
            }
            .padding()
            
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .toolbar{
            
        }.background(Color.offWhite)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
