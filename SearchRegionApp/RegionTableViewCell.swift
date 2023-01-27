//
//  RegionTableViewCell.swift
//  SearchRegionApp
//
//  Created by Peter Chen on 24/1/2023.
//

import UIKit

class RegionTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var regionImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        tintColor = .systemGreen
        regionImage.image = UIImage(systemName: "globe.asia.australia")
        regionImage.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellType(isSelected: Bool) {
        if isSelected {
            accessoryType = .checkmark
            regionImage.tintColor = .systemGreen
            name.font = .boldSystemFont(ofSize: 16)
        } else {
            accessoryType = .none
            regionImage.tintColor = .lightGray
            name.font = .systemFont(ofSize: 16)
        }
    }
}
