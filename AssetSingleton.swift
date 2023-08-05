//
//  AssetSingleton.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class Design {
    static let shared = Design()
    var backgroundColor: UIColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    var fontAndBorderColor: UIColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    
    private init() {}
}

// 아래 이미지 싱글톤 필요없을 듯???
struct TamagotchiImageSingleton {
    static var shared = TamagotchiImageSingleton()
    
    var cactus = TamagotchiCactusImage.cactus
    var sun = TamagotchiSunImage.sun
    var star = TamagotchiStarImage.star
}

struct TamagotchiCactusImage {
    static var cactus = TamagotchiCactusImage()
    
    var one = "1-1"
    var two = "1-2"
    var three = "1-3"
    var four = "1-4"
    var five = "1-5"
    var six = "1-6"
    var seven = "1-7"
    var eight = "1-8"
    var nine = "1-9"
}

struct TamagotchiSunImage {
    
    static var sun = TamagotchiSunImage()
    
    var one = "2-1"
    var two = "2-2"
    var three = "2-3"
    var four = "2-4"
    var five = "2-5"
    var six = "2-6"
    var seven = "2-7"
    var eight = "2-8"
    var nine = "2-9"
}

struct TamagotchiStarImage {
    
    static var star = TamagotchiStarImage()
    
    var one = "3-1"
    var two = "3-2"
    var three = "3-3"
    var four = "3-4"
    var five = "3-5"
    var six = "3-6"
    var seven = "3-7"
    var eight = "3-8"
    var nine = "3-9"
}
