//
//  Test.swift
//  Recap
//
//  Created by 권현석 on 2023/08/06.
//

import Foundation

// 클래스가 아니라 구조체를 쓴 이유
//1. 만약에 UI요소를 이런식으로 만드는 거였으면 해당 UI 요소를 클래스에서 상속을 받아야 사용하기 편할 듯, 하지만 메서드의 타입을 클래스가 상속받을 수 없으니까?
//2. 값타입 참조타입에 의해서 객체의 값이 바뀌는 차이가 있을 수 있을거 같은데 이거는 타입 메서드로 썼을 때는 상관없는거 같은데...?
struct Methods {
    static func saveTamagotchiStruct(tamagotchi: Tamagotchi ,key: String) {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(tamagotchi) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
        
        print(tamagotchi)
    }
}