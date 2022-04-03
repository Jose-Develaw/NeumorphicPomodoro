//
//  ShallowConcaveView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import SwiftUI

struct ShallowConcaveView : View  {
    let cornerRadius : CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.offWhite)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: 2)
                .blur(radius: 0.5)
                .offset(x: 1, y: 0.5)
                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color.gray, Color.clear], startPoint: .top, endPoint: .bottom)))
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.white, lineWidth: 2)
                .blur(radius: 0.5)
                .offset(x: -1, y: -1.5)
                .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom)))
        }
    }
}