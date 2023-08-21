//
//  OKAYButton.swift
//  Recap
//
//  Created by 권현석 on 2023/08/21.
//


import UIKit

@IBDesignable
class EatButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor {
        get {
            return .systemBlue
            
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
