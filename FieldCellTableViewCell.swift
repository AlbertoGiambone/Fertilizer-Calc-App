//
//  FieldCellTableViewCell.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 08/02/22.
//

import UIKit

class FieldCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Connection
    
    @IBOutlet weak var nitrogenLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var phosphorusLabel: UILabel!
    
    @IBOutlet weak var potassiumLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var magnesiumLabel: UILabel!
    
    @IBOutlet weak var calciumLabel: UILabel!
    
}
