//
//  TamagotchiModel.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import Foundation

//각 케이스가 이미지로 연결 다리의 역할을 할 수 있으면 좋겠음. => 아니면 아래의 열거형 타입의 연산프로퍼티나 메서드를 만들어서 반환값으로 이미지 파일 이름을 뱉으면 안되나?
// 이 열거형의 이미지 연산프로퍼티가 String 배열 타입이고, 배열의 index를 사용해 level과 연관지어 할 수 있을 듯?
enum TamagotchiSpecies: String {
    case cactus
    case sun
    case star
    case none
}

// 아마 다마고치가 id을 갖고 있어야 할 듯. 그래야 저장하고 불러올 수 있을 듯
struct Tamagotchi: Codable {
    let id: Int
    var type: String
    var name: String
    var rice: Int
    var water: Int
}

struct TamagotchiList {
    var tamagotchi: [Tamagotchi] =
[Tamagotchi(id: 0,type: TamagotchiSpecies.cactus.rawValue, name: "선인장", rice: 0, water: 0),
 Tamagotchi(id: 1,type: TamagotchiSpecies.sun.rawValue, name: "태양", rice: 0, water: 0),
 Tamagotchi(id: 2,type: TamagotchiSpecies.star.rawValue, name: "별", rice: 0, water: 0),
 Tamagotchi(id: 3,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 4,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 5,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 6,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 7,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 8,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 9,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 10,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 11,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 12,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 13,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 14,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 15,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 16,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 17,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 18,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0),
 Tamagotchi(id: 19,type: TamagotchiSpecies.none.rawValue, name: "", rice: 0, water: 0)]
}



