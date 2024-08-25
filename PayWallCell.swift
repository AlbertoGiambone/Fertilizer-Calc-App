//
//  PayWallCell.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 17/03/23.
//

import UIKit

class PayWallCell: UITableViewCell {

    //MARK: Connection
    
    
    @IBOutlet weak var RevenueCatItem: UILabel!
    
    @IBOutlet weak var RevenueCatItemDescription: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var cellBackGround: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
