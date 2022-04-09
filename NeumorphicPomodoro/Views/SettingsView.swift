//
//  SettingsView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
