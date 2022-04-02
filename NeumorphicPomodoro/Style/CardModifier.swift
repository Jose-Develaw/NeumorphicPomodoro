//
//  CardModifier.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct CardModifier : ViewModifier {
    func body(content: Content) -> some View {
            content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.offWhite)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
             )
        }
}

extension View {
    func applyCardStyle() -> some View {
        return self.modifier(CardModifier())
    }
}
