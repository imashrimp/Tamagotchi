//
//  VCID.swift
//  Recap
//
//  Created by 권현석 on 2023/08/14.
//

import UIKit

protocol ResuableProtocol {
    static var identifier: String { get }
}

extension UIViewController: ResuableProtocol {
    
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ResuableProtocol {
    
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ResuableProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
