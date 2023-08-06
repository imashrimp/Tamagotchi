//
//  MainViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

//TODO: 타이틀 텍스트 컬러 바꾸면 됨.

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - 이거 UserDefaults에 저장된 객체를 불러와서 대체하면 됨. => 오류처리 필요없음 이 화면은 저장된 객체 없으면 나올 일 없으니까.
    var myTamagotchi: Tamagotchi = Tamagotchi(type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0)
    
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
        
        self.view.backgroundColor = Design.backgroundColor
        
        setNavigationBar()
        
        configurebubbleTextField()
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
        //설정화면을 통해 전활되기 때문에 사용될 거임.
        
        setNavigationBar()
        loadTamagochiData()
    }
    
    //밥이랑 물 버튼 action이 사용하는 UItextField만 다르지 나머지는 반복임. 더 간단하게 쓸 수 있지 않을까?
    @IBAction func eatRiceButtonTapped(_ sender: UIButton) {
        
        guard let riceToEat = riceTextField.text else { return }
        
        guard let riceToEatInt = Int(riceToEat) else {
            myTamagotchi.rice += 1
            
            //이 저장과 불러와서 최신화 하는 걸 담당하는 메서드가 있으면 더 깔끔할 듯. 다만, key값 설정에 주의해야함.
            //키 값 바궈야함 객체 고유의 ID로
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
            // 레벨은 따로 빼서 해보자
            tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
            
            return
        }
        
        myTamagotchi.rice += riceToEatInt
        
        Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
        
        myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
        
        tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"

    }
    
    @IBAction func drinkWaterButtonTapped(_ sender: UIButton) {
        
        guard let waterToDrink = waterTextField.text else { return }
        
        guard let waterToDrinkInt = Int(waterToDrink) else {
            
            myTamagotchi.water += 1
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
            // 레벨은 따로 빼서 해보자
            tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
            
            return
        }
        
        myTamagotchi.water += waterToDrinkInt
        
        Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
        
        myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
        // 레벨은 따로 빼서 해보자
        tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
        
    }
    
    // 이거는 문구 총 5~6개정도 하고, 원시값(Int)을 갖는 enum의 사용해 연산 프로퍼티로 문구가 나타나게 해보자
    func configurebubbleTextField() {
        bubbleTextField.borderStyle = .none
        bubbleTextField.background = UIImage(named: "bubble")
        bubbleTextField.isEnabled = false
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
    
    func configureFeedTextField(textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.backgroundColor = Design.backgroundColor
        textField.textColor = Design.fontAndBorderColor
        textField.textAlignment = .center
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
    
    func loadTamagochiData() {
        myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
        
        nameLabel.text = myTamagotchi.name
        tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
    }
    
    func showUIContents(myTamagotchi: Tamagotchi) {
        imageView.image = UIImage(named: myTamagotchi.type)
        nameLabel.text = myTamagotchi.name
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
        
        self.navigationItem.title = userName
    }
    
    @objc func settingButtonTapped() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
