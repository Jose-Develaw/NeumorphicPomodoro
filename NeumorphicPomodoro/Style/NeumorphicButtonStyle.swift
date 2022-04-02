//
//  NeumorphicButtonStyle.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct NeumorphicButtonStyle<Content: InsettableShape>: ButtonStyle {
    
    var width : CGFloat
    var heigth : CGFloat
    var shape : Content
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: width, maxHeight: heigth)
            .contentShape(shape)
            .background(
                Group{
                    if configuration.isPressed{
                        shape
                            .fill(Color.offWhite)
                            .overlay(
                                shape
                                    .stroke(.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask {
                                        shape
                                            .fill(LinearGradient(.black, .clear))
                                    }
                            )
                            .overlay(
                                shape
                                    .stroke(.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask {
                                        shape
                                            .fill(LinearGradient(.clear, .black))
                                    }
                            )
                            
                    } else {
                        shape
                            .fill(Color.offWhite)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                    
                }
            )
    }
}
