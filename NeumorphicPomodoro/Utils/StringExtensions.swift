//
//  StringExtensions.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 19/4/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
