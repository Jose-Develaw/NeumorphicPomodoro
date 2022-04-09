//
//  NeumorphicPomodoroApp.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 1/4/22.
//

import SwiftUI

@main
struct NeumorphicPomodoroApp: App {
    @StateObject var settings = SettingsManager.getSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
