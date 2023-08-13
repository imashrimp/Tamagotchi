//
//  TamagotchiModel.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import Foundation

enum TamagotchiSpecies: String {
    case cactus
    case sun
    case star
    case none
}


struct Tamagotchi: Codable {
    let id: Int
    var type: String
    var name: String
    var rice: Int
    var water: Int
}

struct TamagotchiList {
    var tamagotchi: [Tamagotchi] = [Tamagotchi(id: 0,type: TamagotchiSpecies.cactus.rawValue, name: "선인장", rice: 0, water: 0),
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



