//
//  Arc.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct Arc : InsettableShape {
    var startAngle: Angle
    var tickingAmount : Double
    var clockwise : Bool
    var insetAmount = 0.0
    
    var animatableData: Double {
        get { tickingAmount }
        set { tickingAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        let rotationAdjustment = Angle(degrees: 90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = .degrees(tickingAmount) - rotationAdjustment
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midX, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
   
}
