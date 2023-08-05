//
//  SettingModel.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import Foundation

struct SettingItem {
    var imageName: String
    var title: String
    var subtitle: String
}

struct SettingItemlList {
    var list: [SettingItem] = [SettingItem(imageName: "pencil", title: "사용자 이름 설정하기", subtitle: "대장님"),
                               SettingItem(imageName: "moon.fill", title: "다마고치 변경하기", subtitle:""),
                               SettingItem(imageName: "arrow.clockwise", title: "데이터 초기화", subtitle: "")]
}
