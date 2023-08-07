//
//  AssetSingleton.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

//이건 클래스를 써야할까 구조체를 써야할까? 
struct Design {
    static let backgroundColor: UIColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    static let fontAndBorderColor: UIColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
}

struct ImageAsset {
    static let cactusImage: [String] = ["1-1", "1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "1-8", "1-9", "1-9"]
    static let sunImage: [String] = ["2-1", "2-1", "2-2", "2-3", "2-4", "2-5", "2-6", "2-7", "2-8", "2-9", "2-9"]
    static let starImage: [String] = ["3-1", "3-1", "3-2", "3-3", "3-4", "3-5", "3-6", "3-7", "3-8", "3-9", "3-9"]
}
