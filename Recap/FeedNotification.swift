//
//  FeedNotification.swift
//  Recap
//
//  Created by 권현석 on 2023/08/20.
//

import UIKit

class FeedNotification {
    
    static let shared = FeedNotification()

    private init() { }
    
    func notifyToFeed() {
        let content = UNMutableNotificationContent()
        content.title = "다마고치를 깜빡하셨나요?"
        content.body = "다마고치에게 밥과 물을 주세요."
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
        let request = UNNotificationRequest(identifier: "Feed", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
}
