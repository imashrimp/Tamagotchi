//
//  MainViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

//TODO: 타이틀 텍스트 컬러 바꾸면 됨.
// 1. 레벨 설정
// 2. 레벨 설정에 따른 이미지 설정

//레벨을 연산프로퍼티로 설정하고, set에서 이미지 설정 메서드 호출하는게 최종 버전일듯? 일단 둘 다 메서드로 구현해보자

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - 이거 UserDefaults에 저장된 객체를 불러와서 대체하면 됨. => 오류처리 필요없음 이 화면은 저장된 객체 없으면 나올 일 없으니까.
    var myTamagotchi: Tamagotchi = Tamagotchi(type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0)
    var myTamgotchiLevel: Int = 0
    
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
        setNavigationBar()
        loadTamagochiData()
        calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
        //이게 좀 이상한 구조이긴함.
        showTamagotchiImage(tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
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
            
            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showTamagotchiImage(tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
            
            return
        }
        
        myTamagotchi.rice += riceToEatInt
        
        Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
        
        myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
        
        tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
        
        calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
        
        showTamagotchiImage(tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
        
    }
    
    @IBAction func drinkWaterButtonTapped(_ sender: UIButton) {
        
        guard let waterToDrink = waterTextField.text else { return }
        
        guard let waterToDrinkInt = Int(waterToDrink) else {
            
            myTamagotchi.water += 1
            
            Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
            
            myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
            // 레벨은 따로 빼서 해보자
            tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
            
            calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
            
            showTamagotchiImage(tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
            
            return
        }
        
        myTamagotchi.water += waterToDrinkInt
        
        Methods.saveTamagotchiStruct(tamagotchi: myTamagotchi, key: "ID")
        
        myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
        // 레벨은 따로 빼서 해보자
        tamagotchiStateLabel.text = "LV • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
        
        calculateLevel(rice: myTamagotchi.rice, water: myTamagotchi.water)
        
        showTamagotchiImage(tamagotchiType: myTamagotchi.type, level: myTamgotchiLevel)
        
    }
    
    func loadTamagochiData() {
        myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
        
        nameLabel.text = myTamagotchi.name
        //MARK: - 이거 형태 더 다듬을 수 있을 듯
        tamagotchiStateLabel.text = "LV\(myTamgotchiLevel) • 밥알  \(myTamagotchi.rice)개 • 물방울  \(myTamagotchi.water)개"
    }
    
    func showUIContents(myTamagotchi: Tamagotchi) {
        imageView.image = UIImage(named: myTamagotchi.type)
        nameLabel.text = myTamagotchi.name
    }
    
    func calculateLevel(rice: Int, water: Int) /*-> Int*/ {
        let level = ((rice / 5) + (water / 2)) / 10
        myTamgotchiLevel = level
        //        return level
    }
    
    func showTamagotchiImage(tamagotchiType: String ,level: Int)  {
        
        if tamagotchiType == TamagotchiSpecies.cactus.rawValue {
            switch level {
            case 0:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 1:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 2:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 3:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 4:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 5:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 6:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 7:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 8:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 9:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[level])
            case 10...:
                return imageView.image = UIImage(named: ImageAsset.cactusImage[10])
            default:
                return imageView.image = UIImage(named: "noImage")
            }
        } else if tamagotchiType == TamagotchiSpecies.sun.rawValue {
            switch level {
            case 0:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 1:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 2:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 3:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 4:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 5:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 6:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 7:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 8:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 9:
                return imageView.image = UIImage(named: ImageAsset.sunImage[level])
            case 10...:
                return imageView.image = UIImage(named: ImageAsset.sunImage[10])
            default:
                return imageView.image = UIImage(named: "noImage")
            }
        } else if tamagotchiType == TamagotchiSpecies.star.rawValue {
            switch level {
            case 0:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 1:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 2:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 3:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 4:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 5:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 6:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 7:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 8:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 9:
                return imageView.image = UIImage(named: ImageAsset.starImage[level])
            case 10...:
                return imageView.image = UIImage(named: ImageAsset.starImage[10])
            default:
                return imageView.image = UIImage(named: "noImage")
            }
        } else {
            
        }
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

//MARK: - 기본 UI Attributes 설정
extension MainViewController {
    //MARK: - 이거는 문구 총 5~6개정도 하고, 원시값(Int)을 갖는 enum의 사용해 연산 프로퍼티로 문구가 나타나게 해보자
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
}
