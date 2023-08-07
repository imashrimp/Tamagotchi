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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        
        loadTamagochiData()
        
        let id = UserDefaults.standard.integer(forKey: "ID")
        updateTamagotchi(id: id)
    }

    @IBAction func eatRiceButtonTapped(_ sender: UIButton) {
        
        guard let riceToEat = riceTextField.text else { return }
        
        guard let riceToEatInt = Int(riceToEat) else {
            
            myTamagotchi.rice += 1
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
           
            updateTamagotchi(id: myTamagotchi.id)
            
            return
        }
        
        if riceToEatInt >= 100 {
            
            let alert = UIAlertController(title: "알림", message: "밥은 한 번에 99개 까지 줄 수 있습니다.", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okay)
            
            present(alert, animated: true)
            
            riceTextField.text = ""
            
        } else {
            
            myTamagotchi.rice += riceToEatInt
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: myTamagotchi.id)

            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showMyTamagotchiStatement()
            
            Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
            
            riceTextField.text = ""
        }
    }
    
    @IBAction func drinkWaterButtonTapped(_ sender: UIButton) {
        
        guard let waterToDrink = waterTextField.text else { return }
        
        guard let waterToDrinkInt = Int(waterToDrink) else {
            
            myTamagotchi.water += 1
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: myTamagotchi.id)

            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showMyTamagotchiStatement()
            
            Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)

            return
        }
        
        if waterToDrinkInt >= 50 {
            let alert = UIAlertController(title: "알림", message: "물은 한 번에 49개 까지 줄 수 있습니다.", preferredStyle: .alert)
            
            
            let okay = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okay)
            
            present(alert, animated: true)
            
            waterTextField.text = ""
            
        } else {
            
            myTamagotchi.water += waterToDrinkInt
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi)
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: myTamagotchi.id)

            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)

            showMyTamagotchiStatement()
            
            Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
                        
            waterTextField.text = ""
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
            
            let savedID = UserDefaults.standard.integer(forKey: "ID")
            
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
    
    func calculateLevel(rice: Int, water: Int) {
        let level = ((rice / 5) + (water / 2)) / 10
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let _ = Int(string) else {
            let alert = UIAlertController(title: "알림", message: "숫자만 입력해주세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(ok)
            present(alert, animated: true)
            textField.text = ""
            return false
        }
        return true
    }
}

//MARK: - 네비게이션바 설정
extension MainViewController {
    
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Design.fontAndBorderColor
        
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {
            return self.navigationItem.title = "대장님의 다마고치"
        }
        
        self.navigationItem.title = "\(userName)님의 다마고치"
    }
    
    @objc func settingButtonTapped() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - 기본 UI Attributes 설정
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
