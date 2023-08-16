//
//  AlertSingleton.swift
//  Recap
//
//  Created by 권현석 on 2023/08/16.
//

import UIKit

class AlertTest {
    
    static let shared = AlertTest()
    
    private init() { }
    
    func oneButtonAlert(title: String, alertMessage: String, actionTitle: String, actionStyle: UIAlertAction.Style, test: (UIViewController) -> () ) {
        
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: actionStyle)
        
        alert.addAction(action)
        
        test(alert)
    }
}
