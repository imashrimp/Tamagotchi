//
//  TamagotchiCollectionViewCell.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

//프로토콜 만들어서 셀 내부 UI의 컨텐츠 설정하는 메서드 선언하고 여기서 채택하자

import UIKit

class TamagotchiCollectionViewCell: UICollectionViewCell, CollectionCellContentsConfigure {
    

    @IBOutlet var tamagochiImage: UIImageView!
    @IBOutlet var tamagochiNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tamagochiImage.layer.cornerRadius = 15 // 변경 가능함
        
        // image corner radius, 레이블 폰트 사이즈, 배경색, 테두리, numberOflines 같은걸 이미지 띄운 후에 설정해보자
        tamagochiNameLabel.font = .systemFont(ofSize: 13)
        tamagochiNameLabel.textColor = Design.shared.fontAndBorderColor
        tamagochiNameLabel.clipsToBounds = true
        tamagochiNameLabel.layer.cornerRadius = 5 // 변경 가능함
        tamagochiNameLabel.layer.borderWidth = 3 // 변경 가능함
        tamagochiNameLabel.layer.borderColor = Design.shared.fontAndBorderColor.cgColor
        tamagochiNameLabel.numberOfLines = 0
        tamagochiNameLabel.backgroundColor = Design.shared.backgroundColor
        tamagochiNameLabel.textAlignment = .center
    }

    func contentsConfigure(data: Tamagotchi) {
        // 여기서 받아올 객체가 필요함.
        tamagochiImage.image = UIImage(named: TamagotchiImageSingleton.shared.cactus.one)
        tamagochiNameLabel.text = data.name
//        tamagochiNameLabel.text =
    }
}
