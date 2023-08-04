//
//  Protocol.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import Foundation

@objc
protocol CollectionCellContentsConfigure {
    @objc optional func contentsConfigure()
    @objc optional func setNib()
    @objc optional func cellFlowLayout()
    
    
}
