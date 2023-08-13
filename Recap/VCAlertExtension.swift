//
//  VCAlertExtension.swift
//  Recap
//
//  Created by 권현석 on 2023/08/13.
//

import UIKit

extension UIViewController {
    
    func okayOnlyAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okay)
        
        present(alert, animated: true)
        
    }
    
}
