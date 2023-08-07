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
        userNameTextField.delegate = self

        setNavBar()
        textfieldConfigure()
    }
    
    func textfieldConfigure() {
        userNameTextField.placeholder = "사용자 이름을 입력하세요"
        userNameTextField.textColor = .black
        userNameTextField.borderStyle = .none
        userNameTextField.font = .systemFont(ofSize: 15)
        
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            userNameTextField.text = userName
        } else {
            userNameTextField.text = "사용자 이름"
        }
    }

    func setNavBar() {
        navigationController?.navigationBar.tintColor = Design.fontAndBorderColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveUserName))
    }
    
    // 팝업창 띄워서 확인 누르면 저장되고 취소 누르면 저장 안 되도록
    @objc func saveUserName() {
        guard let userName = userNameTextField.text else { return }
        
        if userName == "" {
            let alert = UIAlertController(title: "알림", message: "사용자 이름을 입력하세요.", preferredStyle: .alert)
            let okay = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okay)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "\"\(userName)\"(으)로 사용자 이름을 설정하겠습니까?", message: #""확인"을 누르면 설정이 완료됩니다."#, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let okay = UIAlertAction(title: "확인", style: .default) { okay in
                UserDefaults.standard.set(userName, forKey: "userName")
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancel)
            alert.addAction(okay)
            present(alert, animated: true)
        }
    }
}

extension ChangeUserNameViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
