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
            Form {
                Section {
                    Stepper("Pomodoro length: \(settings.settings.basicPomodoroLength)", value: $settings.settings.basicPomodoroLength, in: 20...60)
                    Stepper("Basic rest length: \(settings.settings.basicRestLength)", value: $settings.settings.basicRestLength, in: 5...20)
                    Stepper("Long rest cadence: \(settings.settings.longRestCadence)", value: $settings.settings.longRestCadence, in: 2...10)
                    Stepper("Long rest length: \(settings.settings.longRestLength)", value: $settings.settings.longRestLength, in: 15...35)
                }
            }
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
