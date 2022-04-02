//
//  ContentView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 1/4/22.
//

import SwiftUI


struct ContentView: View {
    
    @State var isPlaying = false
    var body: some View {
        ZStack{
            Color.offWhite
            VStack{
                Spacer()
                Header()
                Spacer()
                Counter()
                Spacer()
                VStack(alignment: .center, spacing: 5){
                    Text("Name of current task")
                        .font(.title2.bold())
                        .foregroundColor(.black.opacity(0.8))
                    
                    Text("Kind of task")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                Spacer()
                ButtonPad(isPlaying: $isPlaying)
                Spacer()
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
