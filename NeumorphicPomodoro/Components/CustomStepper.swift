//
//  CustomStepper.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//
import SwiftUI

struct CustomStepper : View {
    @Binding var value: Int
    var textColor: Color
    var text: String
    var step = 1

    var body: some View {
            HStack {
                Button(action: {
                    self.value -= self.step
                }, label: {
                    Image(systemName: "minus")
                        .foregroundStyle(LinearGradient(.purple, .pink))
                })
                .buttonStyle(NeumorphicButtonStyle(width: 40, heigth: 40, shape: RoundedRectangle(cornerRadius: 5)))
                .padding(10)
                Spacer()
                Text(text + ": \(value)").font(.system(.title3, design: .rounded))
                    .foregroundColor(textColor)
                Spacer()
                Button(action: {
                    self.value += self.step
                }, label: {
                    Image(systemName: "plus")
                        .foregroundStyle(LinearGradient(.purple, .pink))
                })
                    .buttonStyle(NeumorphicButtonStyle(width: 40, heigth: 40, shape: RoundedRectangle(cornerRadius: 5)))
                .padding(10)
        }
        .background(ShallowConcaveView(cornerRadius: 10))
        .frame(maxHeight: 70)
    }

    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
