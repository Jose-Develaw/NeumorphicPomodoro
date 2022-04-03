//
//  CustomToggle.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import SwiftUI

struct CustomToggle : View  {
    let width : CGFloat
    let height : CGFloat
    let toggleWidthOffset : CGFloat
    let cornerRadius : CGFloat
    let padding : CGFloat
    
    var toggleAction : () -> Void
    
    @State var isToggled = false
    @State var switchWidth : CGFloat = 0.0
    
    var body: some View {
        ZStack {
            
            ShallowConcaveView(cornerRadius: cornerRadius)
                .frame(width: width, height: height)
            
            HStack {
                Text("Personal")
                    .bold()
                    .foregroundStyle(LinearGradient(.purple, .pink))
                
                Spacer()
                
                Text("Work")
                    .bold()
                    .foregroundStyle(LinearGradient(.purple, .pink))
                
            }
            .padding()
            .frame(width: width, height: height)
            
            HStack {
                if isToggled {
                    Spacer()
                }
                
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .padding(padding)
                    .frame(width: switchWidth + toggleWidthOffset, height: height)
                    .animation(.spring(response: 0.5), value: isToggled)
                    .foregroundColor(Color.offWhite)
                    .shadow(color: Color.white, radius: 2, x: -3, y: -3)
                    .shadow(color: Color.gray, radius: 3, x: 3, y: 3)
                
                
                if !isToggled {
                    Spacer()
                    
                }
            }
            
        }
        .frame(width: width, height: height)
        .onTapGesture {
            isToggled = !isToggled
            toggleAction()
            withAnimation(.easeInOut(duration: 0.2)) {
                switchWidth = width
            }
            withAnimation(.easeInOut(duration: 0.4)) {
                switchWidth = height
            }
        }
        .onAppear {
            switchWidth = height
        }
        
    }
}
