//
//  iPadPayWallCell.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 08/05/24.
//

import UIKit

class iPadPayWallCell: UITableViewCell {
    @IBOutlet weak var back: UILabel!
    
    @IBOutlet weak var RevenueCatItem: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
