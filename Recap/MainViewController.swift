//
//  MainViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class MainViewController: UIViewController {
    
    var myTamagotchiID: Int?
    var myTamagotchi: Tamagotchi = Tamagotchi(id: 0,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0)
    var myTamgotchiLevel: Int = 0 {
        didSet {
            bubbleTextField.text = sentenceArray.randomElement()
        }
    }
    
    let sentenceArray: [String] = ["아... 배고픔.", "밥 들어오나?", "좀 먹은거 같네.", "아 배부르다.", "고만 먹을란다."]
    var notifiedUserName: String?
    
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
        
        riceTextField.delegate = self
        waterTextField.delegate = self
        
        configurebubbleTextField()
        configureNameLabelView()
        configureTamagotchiNameLabel()
        configureStatementLabel()
        configureFeedTextField(textField: riceTextField, placeholder: "밥줘", tag: 0)
        configureFeedTextField(textField: waterTextField, placeholder: "물줘", tag: 1)
        configureButton(button: eatRiceButton, buttonImage: "leaf.circle", buttonTitle: "밥 먹기")
        configureButton(button: drinkWaterButton, buttonImage: "drop.circle", buttonTitle: "물 먹기")
        
        NotificationCenter.default.addObserver(self, selector: #selector(showUserNameByNotifiaction), name: NSNotification.Name("UserName"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        setNavTitle(userName: notifiedUserName)
        loadTamagochiData()
        
        let id = UserDefaults.standard.integer(forKey: TamagoID.shared.id)
        updateTamagotchi(id: id)
    }
    
    @objc func showUserNameByNotifiaction(notification: NSNotification) {
        if let newUserName = notification.userInfo?["userName"] as? String {
            notifiedUserName = newUserName
            setNavTitle(userName: notifiedUserName)
        }
    }
    

    //MARK: - 보류 조건 넣기가 빡셈
//    func checkRiceCount(text: String) throws {
//
//        guard text.isEmpty != nil else {
//            print("텍스트필드가 비었으니 밥양을 1만 올려라")
//            throw RiceCountError.oneMoreRice
//        }
//
//        guard let count = Int(text) else { return }
//
//        guard count < 100 else {
//            print("밥은 한 번에 최대 99개 까지만")
//            throw RiceCountError.tooMuchRice
//        }
//
//    }
    
    @IBAction func eatRiceButtonTapped(_ sender: UIButton) {
        
        guard let riceToEatString = riceTextField.text, let riceToEat = Int(riceToEatString) else {
            
            
            myTamagotchi.rice += 1
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            updateTamagotchi(id: myTamagotchi.id)
            
            print("밥양: \(myTamagotchi.rice)")
            
            return
        }
        
        if riceToEat >= 100 {
            
            okayOnlyAlert(alertTitle: "알림", alertMessage: "밥은 한 번에 99개 까지 줄 수 있습니다.", buttonTitle: "확인")
            
            riceTextField.text = ""
            
        } else {
            
            myTamagotchi.rice += riceToEat
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: myTamagotchi.id)
            
            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showMyTamagotchiStatement()
            
            Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
            
            riceTextField.text = ""
            
            print("밥양: \(myTamagotchi.rice)")
            
        }
    }
    
    @IBAction func drinkWaterButtonTapped(_ sender: UIButton) {
        
        guard let waterToDrinkString = waterTextField.text, let waterToDrink = Int(waterToDrinkString) else {
            // 여기를 텍스트 필드의 값이 없을때만 타는가 아니면 타입캐스팅에 실패했을 때도 타는가?
            myTamagotchi.water += 1
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: myTamagotchi.id)
            
            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showMyTamagotchiStatement()
            
            Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
            
            print("물양: \(myTamagotchi.water)")
            
            return
        }
        
        if waterToDrink >= 50 {
            
            okayOnlyAlert(alertTitle: "알림", alertMessage: "물은 한 번에 49개 까지 줄 수 있습니다.", buttonTitle: "확인")
            
            waterTextField.text = ""
            
        } else {
            
            myTamagotchi.water += waterToDrink
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: myTamagotchi.id)
            
            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showMyTamagotchiStatement()
            
            Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
            
            waterTextField.text = ""
            
            print("물양: \(myTamagotchi.water)")
        }
    }
    
    func updateTamagotchi(id: Int) {
        
        myTamagotchi = Methods.loadTamagotchiStruct(key: id)
        
        showMyTamagotchiName()
        
        calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
        
        showMyTamagotchiStatement()
        
        Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
        
    }
    
    func loadTamagochiData() {
        
        guard let _ = myTamagotchiID else {
            
            let savedID = UserDefaults.standard.integer(forKey: TamagoID.shared.id)
            
            updateTamagotchi(id: savedID)
            
            return
        }
        Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
    }
    
    func showMyTamagotchiName() {
        
        nameLabel.text = myTamagotchi.name
    }
    
    func showMyTamagotchiStatement() {
        
        tamagotchiStateLabel.text = "LV\(myTamgotchiLevel) • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
    }
    
    func showUIContents(myTamagotchi: Tamagotchi) {
        
        imageView.image = UIImage(named: myTamagotchi.type)
        
        nameLabel.text = myTamagotchi.name
    }
    
    //MARK: - 이것도 위치를 옮겨보자 타입 메서드로 만들어서
    func calculateLevel(rice: Int, water: Int) {
        
        let riceDouble = Double(rice)
        let waterDouble = Double(water)
        
        let levelDouble = ((riceDouble / 5) + (waterDouble / 2)) / 10
        let level = Int(levelDouble)
        if level < 1 {
            myTamgotchiLevel = 1
        } else if level >= 10 {
            myTamgotchiLevel = 10
        } else {
            myTamgotchiLevel = level
        }
    }
}
extension MainViewController: UITextFieldDelegate {
    
    func checkTextType(text: String) throws {
        guard Int(text) != nil else {
            print("숫자로 바꿀 수 없는 형태")
            throw TypeCastingError.noIntType
        }
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        do {
            try checkTextType(text: string)
            return true
        } catch {
            okayOnlyAlert(alertTitle: "알림", alertMessage: "숫자만 입력해주세요.", buttonTitle: "확인")
            textField.text = ""
            return false
        }
    }
}

//MARK: - 네비게이션바 설정
extension MainViewController {
    
    //MARK: - 여기서 옵저버 추가하면 됨 그리고 분기처리 해야함. 데이터 전달 받는게 없으면 "대장님"으로 되도록
    func setNavTitle(userName: String?) {
    
        if let name = userName {
            
            self.navigationItem.title = "\(name)님의 다마고치"
            
        } else {
            guard let userName = UserDefaults.standard.string(forKey: "userName") else {
                return self.navigationItem.title = "대장님의 다마고치"
            }
            
            self.navigationItem.title = "\(userName)님의 다마고치"

        }
        
    }
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Design.fontAndBorderColor
    }
    
    
    @objc func settingButtonTapped() {
        transition(vc: SettingViewController.self, storyBoard: StoryboardName.setting.rawValue, transitionStyle: .push)
    }
}

//MARK: - 기본 UI Attributes 설정 => 이거 extension UIViecontroller를 만들어서 해보자
extension MainViewController {
    
    func configurebubbleTextField() {
        bubbleTextField.borderStyle = .none
        bubbleTextField.background = UIImage(named: "bubble")
        bubbleTextField.isEnabled = false
        bubbleTextField.textAlignment = .center
        bubbleTextField.font = .systemFont(ofSize: 15)
        bubbleTextField.textColor = Design.fontAndBorderColor
    }
    
    func configureNameLabelView() {
        nameLabelView.layer.cornerRadius = 5
        nameLabelView.layer.borderColor = Design.fontAndBorderColor.cgColor
        nameLabelView.layer.borderWidth = 3
        nameLabelView.backgroundColor = Design.backgroundColor
    }
    
    func configureTamagotchiNameLabel() {
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textColor = Design.fontAndBorderColor
    }
    
    func configureStatementLabel() {
        tamagotchiStateLabel.textAlignment = .center
        tamagotchiStateLabel.font = .systemFont(ofSize: 15)
        tamagotchiStateLabel.textColor = Design.fontAndBorderColor
    }
    
    func configureFeedTextField(textField: UITextField, placeholder: String, tag: Int) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.backgroundColor = Design.backgroundColor
        textField.textColor = Design.fontAndBorderColor
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.tag = tag
    }
    
    func configureButton(button: UIButton, buttonImage: String, buttonTitle: String) {
        button.setImage(UIImage(systemName: buttonImage), for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.tintColor = Design.fontAndBorderColor
        button.setTitleColor(Design.fontAndBorderColor, for: .normal)
        button.layer.borderColor = Design.fontAndBorderColor.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
    }
}
