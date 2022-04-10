//
//  HistoryView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import SwiftUI

struct HistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
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
        .navigationTitle("History")
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

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
