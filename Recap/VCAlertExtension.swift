//
//  VCAlertExtension.swift
//  Recap
//
//  Created by 권현석 on 2023/08/13.
//

import UIKit

//MARK: - Alert 타입 메서드가 UIAlertVC를 반환하면 되는거 아님?

//매개변수에 클로저를 사용해봐라. 클로저를 사용하면 버튼 하나를 여러가지로 변경하게 할 수 있음.
// 스트링 타입의 매개변수(버튼 이름 또는 버튼 스타일)을 받아서 UIAlertAction을 반환하는 클로저?
//아니면 present를 매개변수로 받아서 사용할 가능성도 있음.
//이렇게 내부 메서드를 사용한 외부 메서드를 상수 또는 변수에 할당하면 클로저는 참조타입이라, 해당 상수 또는 변수를 호출할 때마다 참조타입으로  사용가능
extension UIViewController {
    
    func okayOnlyAlert(alertTitle: String, alertMessage: String/*, action: (여기에 파라미터로 버튼의 타이틀과 스타일이 각각 들어갈 수 있겠네?) -> UIAlertAction*/ ) { //이 메서드가 호출하면 어떤 형태가 되는지 생각해보거나 호출해보면서 해당 메서드 정의를 해보자
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okay)
        
        present(alert, animated: true)
        
    }
    
//    익스텐션에 기능 추가할 때 뭐가 빠졌나?
    
    
    static func oneButtonAlert(title: String,
                               alertMessage: String,
                               actionTitle: String,
                               actionStyle: UIAlertAction.Style,
                               test: (UIViewController) -> () ) {
        
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: actionStyle)
        
        alert.addAction(action)
        
        func showAlert(alertVC: UIAlertController, behavior: UIAlertAction) {
            
        }
        
        test(alert)
    }
    
}

