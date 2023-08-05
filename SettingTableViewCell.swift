//
//  SettingTableViewCell.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellTitleLabel: UILabel!
    @IBOutlet var cellSubTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.tintColor = Design.shared.fontAndBorderColor
        cellTitleLabel.textColor = Design.shared.fontAndBorderColor
        cellSubTitleLabel.textColor = Design.shared.fontAndBorderColor
        self.backgroundColor = Design.shared.backgroundColor
        self.accessoryType = .disclosureIndicator
    }
    
    func setUIContents(item: SettingItem) {
        
        cellImageView.image = UIImage(systemName: item.imageName)
        cellTitleLabel.text = item.title
        
    }
}
