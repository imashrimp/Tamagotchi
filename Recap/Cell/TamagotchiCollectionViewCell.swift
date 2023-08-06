//
//  TamagotchiCollectionViewCell.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

//프로토콜 만들어서 셀 내부 UI의 컨텐츠 설정하는 메서드 선언하고 여기서 채택하자

import UIKit

class TamagotchiCollectionViewCell: UICollectionViewCell, CollectionCellContentsConfigure {
    

    @IBOutlet var tamagotchiImage: UIImageView!
    @IBOutlet var tamagotchiNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tamagotchiImage.layer.cornerRadius = 15
        
        tamagotchiNameLabel.font = .systemFont(ofSize: 13)
        tamagotchiNameLabel.textColor = Design.fontAndBorderColor
        tamagotchiNameLabel.clipsToBounds = true
        tamagotchiNameLabel.layer.cornerRadius = 5
        tamagotchiNameLabel.layer.borderWidth = 3
        tamagotchiNameLabel.layer.borderColor = Design.fontAndBorderColor.cgColor
        tamagotchiNameLabel.numberOfLines = 0
        tamagotchiNameLabel.backgroundColor = Design.backgroundColor
        tamagotchiNameLabel.textAlignment = .center
        
    }

    // 레벨을 밖에서 따로 빼서 할거라 이 메서드 수정해야함 그리고 이미지 이름도 이렇게 하면 못쓰고 열거형으로 써야함
    // tamagotchiImage.image = UIImage(named: TamagotchiSpecies.cactus.imageAsset[0]) 이 코드가 이미지를 가져올 수 있는 코드임 이 사용법을 보고 이미지 설정 메서드 다시 짜보자

//    func setTamagotchiImage(data: Tamagotchi) {
//
//        // 이거 cellForItemAt 마다 도는게 좀 무거울거 같음.
//        if data.type == TamagotchiSpecies.cactus.rawValue {
//            switch data.level {
//            case 0..<1:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.one)
//            case 1..<2:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.one)
//            case 2..<3:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.two)
//            case 3..<4:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.three)
//            case 4..<5:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.four)
//            case 5..<6:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.five)
//            case 6..<7:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.six)
//            case 7..<8:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.seven)
//            case 8..<9:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.eight)
//            case 9..<10:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.nine)
//            case 10...:
//                return tamagotchiImage.image = UIImage(named: TamagotchiCactusImage.cactus.nine)
//            default:
//                return tamagotchiImage.image = UIImage(named: "noImage")
//            }
//        } else if data.type == TamagotchiSpecies.sun.rawValue {
//            switch data.level {
//            case 0..<1:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.one)
//            case 1..<2:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.one)
//            case 2..<3:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.two)
//            case 3..<4:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.three)
//            case 4..<5:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.four)
//            case 5..<6:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.five)
//            case 6..<7:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.six)
//            case 7..<8:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.seven)
//            case 8..<9:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.eight)
//            case 9..<10:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.nine)
//            case 10...:
//                return tamagotchiImage.image = UIImage(named: TamagotchiSunImage.sun.nine)
//            default:
//                return tamagotchiImage.image = UIImage(named: "noImage")
//            }
//        } else if data.type == TamagotchiSpecies.star.rawValue {
//            switch data.level {
//            case 0..<1:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.one)
//            case 1..<2:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.one)
//            case 2..<3:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.two)
//            case 3..<4:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.three)
//            case 4..<5:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.four)
//            case 5..<6:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.five)
//            case 6..<7:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.six)
//            case 7..<8:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.seven)
//            case 8..<9:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.eight)
//            case 9..<10:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.nine)
//            case 10...:
//                return tamagotchiImage.image = UIImage(named: TamagotchiStarImage.star.nine)
//            default:
//                return tamagotchiImage.image = UIImage(named: "noImage")
//            }
//        } else {
//            tamagotchiImage.image = UIImage(named: "noImage")
//        }
//    }
    
    func labelSetting(data: Tamagotchi) {
        if data.type == TamagotchiSpecies.none.rawValue {
            tamagotchiNameLabel.text = "준비중이에요."
        
        } else {
            tamagotchiNameLabel.text = data.name
        }
    }
}
