//
//  Extensions.swift
//  Recap
//
//  Created by 권현석 on 2023/08/06.
//

import Foundation

extension String {
    var isNumber: Bool {
        // String값이 빈 값이 아니고 숫자를 제외한 문자로만 이루어진 배열이 nil이면 아마 true 반환 이겠지?
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
