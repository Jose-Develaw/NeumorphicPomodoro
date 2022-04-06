//
//  NotificationDelegate.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 4/4/22.
//

import SwiftUI

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    @Published var notificationCounter = 0
    @Published var showAlert = false
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //This runs when app is in foreground when notification appears
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Has entered willPresent")
        showAlert = true
        completionHandler([.badge, .banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Has entered didReceive")
        if response.actionIdentifier == "Okay" {
            print("Hello")
            print("counter is " + String(notificationCounter))
            notificationCounter = notificationCounter + 1
            print("counter is now " + String(notificationCounter))
        }
        completionHandler()
    }
    
    func createNotification(notificationData: NotificationData, sound: UNNotificationSound?) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = notificationData.title
        content.subtitle = notificationData.subtitle
        content.sound = sound ?? UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificationData.timeInterval, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
