//
//  VCAlertExtension.swift
//  Recap
//
//  Created by 권현석 on 2023/08/13.
//

import UIKit

//MARK: - Alert 타입 메서드가 UIAlertVC를 반환하면 되는거 아님?

extension UIViewController {
    
    func okayOnlyAlert(alertTitle: String, alertMessage: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okay)
        
        present(alert, animated: true)
        
    }
    
}

class Alert {
    

//    func okayOnlyAlert(alertTitle: String, alertMessage: String) {
//        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
//        
//        let okay = UIAlertAction(title: "확인", style: .default)
//        
//        alert.addAction(okay)
//        
//        present(alert, animated: true)
//        
//    }

//    func okayOnlyAlert(alertTitle: String, alertMessage: String) {
//        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
//
//        let okay = UIAlertAction(title: "확인", style: .default)
//
//        alert.addAction(okay)
//
//        present(alert, animated: true)
//
//    }

//    func resetDataAlert() {
//        let alert = UIAlertController(title: "데이터 초기화", message: #""확인"버튼을 누르면 데이터가 초기화 됩니다."#, preferredStyle: .alert)
//
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//
//        let okay = UIAlertAction(title: "확인", style: .default) { okay in
//
//            UserDefaults.standard.set(false, forKey: "launched")
//
//            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//
//            let sceneDelegate = windowScene?.delegate as? SceneDelegate
//
//            let sb = UIStoryboard(name: StoryboardName.selectTamagotchi.rawValue , bundle: nil)
//
//            guard let vc = sb.instantiateViewController(withIdentifier: VCName.selectTamagotchi.rawValue) as? SelectTamagotchiViewController else { return }
//
//            let nav = UINavigationController(rootViewController: vc)
//
//            for tamago in self.tamagoList {
//                Methods.saveTamagotchiStruct(tamagotchi: tamago)
//            }
//
//            sceneDelegate?.window?.rootViewController = nav
//            sceneDelegate?.window?.makeKeyAndVisible()
//        }
//        alert.addAction(cancel)
//        alert.addAction(okay)
//
//        present(alert, animated: true)
//    }
}
