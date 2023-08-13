//
//  PopUpViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/07.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var selectedTamago: Tamagotchi = Tamagotchi(id: 0, type: "", name: "", rice: 0, water: 0)
    
    var mode: SelectTamagochiMode = .firstChoice
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var introduceTextView: UITextView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var okayButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 120/255)

        configureUIView()
        showImage()
        setLabelContents()
        setButtonContents()
        uiConfigure()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func okayButtonTapped(_ sender: UIButton) {
        
        Methods.saveTamagotchiStruct(tamagotchi: selectedTamago)
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        UserDefaults.standard.set(true, forKey: "launched")
        
        let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCName.main.rawValue) as! MainViewController
        let nav = UINavigationController(rootViewController: vc)

        UserDefaults.standard.set(selectedTamago.id, forKey: TamagoID.shared.id)
        vc.myTamagotchiID = selectedTamago.id
        vc.myTamagotchi = selectedTamago
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    func configureUIView() {
        popUpView.backgroundColor = Design.backgroundColor
    }
    
    func uiConfigure() {
        nameLabel.textColor = Design.fontAndBorderColor
        nameLabel.textAlignment = .center

        introduceTextView.backgroundColor = Design.backgroundColor
        introduceTextView.textColor = Design.fontAndBorderColor
        introduceTextView.textAlignment = .center
        introduceTextView.isEditable = false
        introduceTextView.isSelectable = false
        
        cancelButton.setTitleColor(Design.fontAndBorderColor, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 13)
        cancelButton.layer.borderColor = Design.fontAndBorderColor.cgColor
        cancelButton.layer.borderWidth = 2
        
        okayButton.setTitleColor(Design.fontAndBorderColor, for: .normal)
        okayButton.titleLabel?.font = .systemFont(ofSize: 13)
        okayButton.layer.borderColor = Design.fontAndBorderColor.cgColor
        okayButton.layer.borderWidth = 2
        
    }
    
    func showImage() {
        let level = ((selectedTamago.rice / 5) + (selectedTamago.water / 2)) / 10
        
        let levelInInt = Int(level)
        
        Methods.showTamagotchiImage(imageView: imageView, tamagotchiType: selectedTamago.type, level: levelInInt)
    }
    
    func setLabelContents() {
        let level = ((selectedTamago.rice / 5) + (selectedTamago.water / 2)) / 10
        
        nameLabel.text = selectedTamago.name
        introduceTextView.text = "레벨: \(level), 밥 먹은 양:\(selectedTamago.rice), 물 마신양: \(selectedTamago.water)인 다마고치를 고르시겠습니까?"
    }
    
    func setButtonContents() {
        cancelButton.setTitle("취소", for: .normal)
        
        if mode == .firstChoice {
            okayButton.setTitle("선택하기", for: .normal)
        } else {
            okayButton.setTitle("변경하기", for: .normal)
        }
        
    }
}
