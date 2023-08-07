//
//  Test.swift
//  Recap
//
//  Created by 권현석 on 2023/08/06.
//

import UIKit
//TODO: 파일 이름 바꿔야하는데 뭐라고 바꾸지?

// 클래스가 아니라 구조체를 쓴 이유
//1. 만약에 UI요소를 이런식으로 만드는 거였으면 해당 UI 요소를 클래스에서 상속을 받아야 사용하기 편할 듯, 하지만 메서드의 타입을 클래스가 상속받을 수 없으니까?
//2. 값타입 참조타입에 의해서 객체의 값이 바뀌는 차이가 있을 수 있을거 같은데 이거는 타입 메서드로 썼을 때는 상관없는거 같은데...?
struct Methods {
    static func saveTamagotchiStruct(tamagotchi: Tamagotchi) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(tamagotchi) {
            UserDefaults.standard.set(encoded, forKey: "\(tamagotchi.id)")
            print(Methods.loadTamagotchiStruct(key: tamagotchi.id))
        }
    }
    
    static func loadTamagotchiStruct(key: Int) -> Tamagotchi {
        
        guard let savedTamagotchiData = UserDefaults.standard.object(forKey: "\(key)") as? Data else {
            print(#function)
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



