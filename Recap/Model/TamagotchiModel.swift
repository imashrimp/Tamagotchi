//
//  TamagotchiModel.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import Foundation

//각 케이스가 이미지로 연결 다리의 역할을 할 수 있으면 좋겠음.
// 이 열거형의 이미지 연산프로퍼티가 String 배열 타입이고, 배열의 index를 사용해 level과 연관지어 할 수 있을 듯?
enum TamagotchiSpecies {
    case cactus
    case sun
    case star
    case none //이 경우에는 흑백 이미지 뱉으면 됨.
    
    // 이거는 이미지를 스위치문 돌 때 컬렉션뷰 셀의 index랑 아래 배열의 index랑 비교해서 쓸 거임.
    var imageAsset: [String] {
        switch self {
        case .cactus:
            return ["1-1",
                    "1-1",
                    "1-2",
                    "1-3",
                    "1-4",
                    "1-5",
                    "1-6",
                    "1-7",
                    "1-8",
                    "1-9",
                    "1-9"]
        case .sun:
            return ["2-1",
                    "2-1",
                    "2-2",
                    "2-3",
                    "2-4",
                    "2-5",
                    "2-6",
                    "2-7",
                    "2-8",
                    "2-9",
                    "2-9"]
        case .star:
            return ["3-1",
                    "3-1",
                    "3-2",
                    "3-3",
                    "3-4",
                    "3-5",
                    "3-6",
                    "3-7",
                    "3-8",
                    "3-9",
                    "3-9"]
        case .none:
            return ["noImage"]
        }
    }
}

struct Tamagotchi {
    var type: TamagotchiSpecies
    var name: String
    var rice: Int
    var water: Int
    var level: Int {
        return (rice / 5) + (water / 2) / 10
    }
}

struct TamagotchiList {
    var tamagotchi: [Tamagotchi] = [Tamagotchi(type: .cactus, name: "선인장", rice: 10, water: 10),
                                   Tamagotchi(type: .sun, name: "태양", rice: 8, water: 7),
                                   Tamagotchi(type: .star, name: "별", rice: 3, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0),
                                   Tamagotchi(type: .none, name: "", rice: 0, water: 0)]
}





