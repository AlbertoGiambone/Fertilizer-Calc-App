//
//  SettingsTableCell.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 24/02/23.
//

import UIKit

class SettingsTableCell: UITableViewCell {

    
    //MARK: Connection
    
    
    @IBOutlet weak var LogoIMG: UIImageView!
    
    @IBOutlet weak var TextLabel: RoundLabel!
    
    @IBOutlet weak var DisclosureIMG: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
