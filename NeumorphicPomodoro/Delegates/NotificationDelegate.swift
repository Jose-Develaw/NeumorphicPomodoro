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
    
    func createNotification(_ work : Work) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Well done"
        content.subtitle = "It is time to rest"
        content.sound = UNNotificationSound.default

        // show this notification when this pomodoro or rest time is over
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(work.timeRemaining), repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        
        
        //notification actions
        let next = UNNotificationAction(identifier: "Next", title: "Next", options: [])
        let okay = UNNotificationAction(identifier: "Okay", title: "Okay", options: [])
        let category = UNNotificationCategory(identifier: "Actions", actions: [next, okay], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [.customDismissAction])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().add(request)
        
        
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
