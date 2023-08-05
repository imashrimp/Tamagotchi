//
//  UserNameChangeViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/05.
//

import UIKit

class UserNameChangeViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Design.shared.backgroundColor

        textfieldConfigure()
    }

    func textfieldConfigure() {
        userNameTextField.placeholder = "사용자 이름을 입력하세요"
        userNameTextField.textColor = .black
        userNameTextField.borderStyle = .none
        userNameTextField.font = .systemFont(ofSize: 15)
    }

    
}
