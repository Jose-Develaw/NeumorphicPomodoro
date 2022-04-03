//
//  Pomodoro.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 3/4/22.
//

import Foundation

class Work : ObservableObject, Identifiable{
    
    @Published var id = UUID()
    @Published var type = "Work"
    @Published var task = ""
    @Published var currentPomodoro = 0
    @Published var currentRest = 0
    
}
