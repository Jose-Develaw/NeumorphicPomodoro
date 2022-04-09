//
//  Settings.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import SwiftUI

class SettingsWrapper : ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case settings
    }
    
    @Published var settings = Settings() {
        didSet {
            SettingsManager.saveSettings(self)
        }
    }
    
    init(){}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(settings, forKey: .settings)
    }
    
    required init(from decoder: Decoder) throws {
        let containder = try decoder.container(keyedBy: CodingKeys.self)
        settings = try containder.decode(Settings.self, forKey: .settings)
    }
}

struct Settings : Codable {
    var basicRestLength = 5
    var basicPomodoroLength = 25
    var longRestCadence = 4
    var longRestLength = 15
    
    var basicRestLengthSeconds : Double {
        Double(basicRestLength) * 60
    }
    var basicPomodoroLengthSeconds : Double {
        Double(basicPomodoroLength) * 60
    }
    var longRestLengthSeconds : Double {
        Double(longRestLength) * 60
    }
}
