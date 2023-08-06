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
        cellImageView.tintColor = Design.fontAndBorderColor
        cellTitleLabel.textColor = Design.fontAndBorderColor
        cellSubTitleLabel.textColor = Design.fontAndBorderColor
        cellSubTitleLabel.font = .systemFont(ofSize: 13)
        self.backgroundColor = Design.backgroundColor
        self.accessoryType = .disclosureIndicator
    }
    
    func setUIContents(item: SettingItem) {
        
        cellImageView.image = UIImage(systemName: item.imageName)
        cellTitleLabel.text = item.title
        
    }
}
