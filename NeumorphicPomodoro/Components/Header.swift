//
//  Header.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 2/4/22.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 20){
            Text("""
                Neumorphic
                Pomodoro
                """)
                .font(.largeTitle.bold())
                .foregroundColor(.black.opacity(0.8))
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Text("""
                The app
                for you to
                work better
                """)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
