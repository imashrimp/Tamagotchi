//
//  TamagotchiCollectionViewCell.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class TamagotchiCollectionViewCell: UICollectionViewCell, CollectionCellContentsConfigure {
    

    @IBOutlet var tamagotchiImage: UIImageView!
    @IBOutlet var tamagotchiNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tamagotchiImage.layer.cornerRadius = 15
        
        tamagotchiNameLabel.font = .systemFont(ofSize: 13)
        tamagotchiNameLabel.textColor = Design.fontAndBorderColor
        tamagotchiNameLabel.clipsToBounds = true
        tamagotchiNameLabel.layer.cornerRadius = 5
        tamagotchiNameLabel.layer.borderWidth = 3
        tamagotchiNameLabel.layer.borderColor = Design.fontAndBorderColor.cgColor
        tamagotchiNameLabel.numberOfLines = 0
        tamagotchiNameLabel.backgroundColor = Design.backgroundColor
        tamagotchiNameLabel.textAlignment = .center
        
    }
    
    func labelSetting(data: Tamagotchi) {
        if data.type == TamagotchiSpecies.none.rawValue {
            tamagotchiNameLabel.text = "준비중이에요."
        
        } else {
            tamagotchiNameLabel.text = data.name
        }
    }
}
