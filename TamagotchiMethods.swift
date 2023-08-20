//
//  Test.swift
//  Recap
//
//  Created by 권현석 on 2023/08/06.
//

import UIKit

struct Methods {
    
    static func saveTamagotchiStruct(tamagotchi: Tamagotchi) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(tamagotchi) {
            UserDefaults.standard.set(encoded, forKey: "\(tamagotchi.id)")
        }
    }
    
    static func loadTamagotchiStruct(key: Int) -> Tamagotchi {
        
        guard let savedTamagotchiData = UserDefaults.standard.object(forKey: "\(key)") as? Data else {
            print("다마고치를 Data 타입으로 불러오는데 실패했습니다!")
            return Tamagotchi(id: 0 ,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0)
        }
        
        let decorder = JSONDecoder()
        
        guard let savedTamagotchi = try? decorder.decode(Tamagotchi.self, from: savedTamagotchiData) else {
            print(#function)
            print("다마고치 Data 타입을 Tamagotchi타입으로 변경하는데 실패했습니다.")
            return Tamagotchi(id: 0 ,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0)
        }
        return savedTamagotchi
    }
    
    static func showTamagotchiImage(imageView: UIImageView, tamagotchiType: String ,level: Int)  {
        //MARK: - 여기에 있는 switch문을 메서드로 바꾸고 해당 메서드가 UIImageName의 값을 전달인자로 받는 형태로 만들어보자
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
            imageView.image = UIImage(named: "noImage")
        }
    }
}



