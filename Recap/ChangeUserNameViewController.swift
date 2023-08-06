//
//  UserNameChangeViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/05.
//

import UIKit

class ChangeUserNameViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Design.backgroundColor

        setNavBar()
        textfieldConfigure()
    }

    func textfieldConfigure() {
        userNameTextField.placeholder = "사용자 이름을 입력하세요"
        userNameTextField.textColor = .black
        userNameTextField.borderStyle = .none
        userNameTextField.font = .systemFont(ofSize: 15)
    }

    func setNavBar() {
        navigationController?.navigationBar.tintColor = Design.fontAndBorderColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveUserName))
    }
    
    // 팝업창 띄워야하나?
    @objc func saveUserName() {
        guard let userName = userNameTextField.text else {
            UserDefaults.standard.set("대장님", forKey: "userName")
            return
        }
        UserDefaults.standard.set(userName, forKey: "userName")
    }
}
