//
//  Transition+Extension.swift
//  Recap
//
//  Created by 권현석 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    func transition<T: UIViewController>(vc: T.Type, storyBoard: String, transitionStyle: TransitionStyle) {
        
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: vc)) as? T else { return }
        
        switch transitionStyle {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalTransitionStyle = .coverVertical
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
