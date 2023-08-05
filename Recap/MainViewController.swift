//
//  MainViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - 이거 UserDefaults에 저장된 객체를 불러와서 대체하면 됨. => 오류처리 필요없음 이 화면은 저장된 객체 없으면 나올 일 없으니까.
    var myTamagotchi: Tamagotchi = Tamagotchi(type: .none, name: "", rice: 0, water: 0)

    let settingButton: UIBarButtonItem = UIBarButtonItem()
    
    @IBOutlet var bubbleTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tamagotchiStateLabel: UILabel!
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var eatRiceButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var drinkWaterButton: UIButton!
    @IBOutlet var nameLabelView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Design.shared.backgroundColor

        setNavigationBar()
    
        configurebubbleTextField()
        configureTamagotchiImage()
        configureNameLabelView()
        configureTamagotchiNameLabel()
        configureStatementLabel()
        configureFeedTextField(textField: riceTextField, placeholder: "밥줘")
        configureFeedTextField(textField: waterTextField, placeholder: "물줘")
        configureButton(button: eatRiceButton, buttonImage: "leaf.circle", buttonTitle: "밥 먹기")
        configureButton(button: drinkWaterButton, buttonImage: "drop.circle", buttonTitle: "물 먹기")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //설정화면 때문에 전환될 거임.
        setNavigationBar()
        // 여기서 myTamagotchi에 변경된 객체 할당하는 코드 작성하면 됨.
    }
    
    // 이거는 문구 총 5~6개정도 하고, 원시값(Int)을 갖는 enum의 사용해 연산 프로퍼티로 문구가 나타나게 해보자
    func configurebubbleTextField() {
        bubbleTextField.borderStyle = .none
        bubbleTextField.background = UIImage(named: "bubble")
        bubbleTextField.isEnabled = false
    }
    
    func configureTamagotchiImage() {
        imageView.image = UIImage(named: myTamagotchi.type.imageAsset[myTamagotchi.level])
    }
    
    func configureNameLabelView() {
        nameLabelView.layer.cornerRadius = 5
        nameLabelView.layer.borderColor = Design.shared.fontAndBorderColor.cgColor
        nameLabelView.layer.borderWidth = 3
        nameLabelView.backgroundColor = Design.shared.backgroundColor
    }
    
    func configureTamagotchiNameLabel() {
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.text = myTamagotchi.name
    }
    
    func configureStatementLabel() {
        tamagotchiStateLabel.textAlignment = .center
        tamagotchiStateLabel.font = .systemFont(ofSize: 15)
        tamagotchiStateLabel.text = "LV\(myTamagotchi.level)• 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
    }
    
    func configureFeedTextField(textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.backgroundColor = Design.shared.backgroundColor
        textField.textAlignment = .center
    }
    
    func configureButton(button: UIButton, buttonImage: String, buttonTitle: String) {
        button.setImage(UIImage(systemName: buttonImage), for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.tintColor = Design.shared.fontAndBorderColor
        button.setTitleColor(Design.shared.fontAndBorderColor, for: .normal)
        button.layer.borderColor = Design.shared.fontAndBorderColor.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
    }
}

//MARK: - 네비게이션바 설정
extension MainViewController {
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Design.shared.fontAndBorderColor
        
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {
            return self.navigationItem.title = "대장님의 다마고치"
        }
        
        self.navigationItem.title = userName
    }
    
    @objc func settingButtonTapped() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
