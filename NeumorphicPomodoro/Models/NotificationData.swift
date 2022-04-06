//
//  NotificationContent.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 6/4/22.
//

import Foundation

class NotificationData {
    var title : String
    var subtitle : String
    var timeInterval : Double
    
    init(title: String, subtitle: String, timeInterval: Double){
        self.title = title
        self.subtitle = subtitle
        self.timeInterval = timeInterval
    }
}
