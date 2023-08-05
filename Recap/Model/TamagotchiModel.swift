//
//  TamagotchiModel.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import Foundation

// identifier로 열거형의 원시값을 가져다 쓰면 되지 않을까?
enum TamagotchiSpecies {
    case cactus
    case sun
    case star
    
}

struct Tamagotchi {
    // 나중에 다마고치의 레벨별 이미지를 불러내는 조건문을 쓸 때 레벨을 구분하기 위한 switch문 상위에 if문의 조건으로 myTamagotchi(Tamagotchi타입임).type = TamagotchiSpecies.sun이면 그 아래 스위치 문에서 level에 따른 이미지 에셋을 singleton으로 불러올 때 조건의 가독성이 높아짐. 이게단가...?
    // 뭔가 이 type프로퍼티의 열거형으로 싱글톤 접근까지 연결하고 싶음
    // type 프로퍼티를 통해 image를 세팅하려고 하는데 이건 결국 레벨에 따라서 그 index를 정할 수 있는거다 그러면 이미지는 배열 형태로 들어가있는게 좋고 cellForItemAt에서 불리기 위해서는 아이템미지배열.[indexPath]
    var type: TamagotchiSpecies
    var name: String
    var rice: Double
    var water: Double
    var level: Double {
        return (rice / 5) + (water / 2)
    }
}

struct TamagotchiList {
    var tamagochi: [Tamagotchi] = [Tamagotchi(type: .cactus, name: "선인장", rice: 0, water: 0)]
    
    var test = TamagotchiImageSingleton.shared.cactus.eight
}





