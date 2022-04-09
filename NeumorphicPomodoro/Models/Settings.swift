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
    
    @Published var settings : Settings
    
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
    var basicRestLength = 0.0
    var basicPomodoroLength = 0.0
    var longRestCadence = 0
    var longRestLength = 0.0
}
