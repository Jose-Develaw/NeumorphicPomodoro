//
//  SettingsManager.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import Foundation

class SettingsManager {

    static func getSettings() -> SettingsWrapper {
        print("Settings called")
        guard let stringifySettings = UserDefaults.standard.data(forKey: "settings") else {
            return SettingsWrapper()
        }
        let decoder = JSONDecoder()
        
        guard let decoded = try? decoder.decode(SettingsWrapper.self, from: stringifySettings) else {
            fatalError("Failed to decode data from UserDefaults")
        }
        
        print("Settings loaded", decoded)
        return decoded
        
    }

    static func saveSettings(_ settings: SettingsWrapper) {
        
        let encoder = JSONEncoder()
        
        guard let encoded = try? encoder.encode(settings) else {
            fatalError("Failed to decode data from UserDefaults")
        }
        
        UserDefaults.standard.set(encoded, forKey: "settings")
        
    }
}
