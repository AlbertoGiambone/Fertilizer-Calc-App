//
//  iPadFdTvCell.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 23/04/24.
//

import UIKit

class iPadFdTvCell: UITableViewCell {

    //MARK: Connection
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nitrogenLabel: UILabel!
    
    @IBOutlet weak var phosphorusLabel: UILabel!
    
    @IBOutlet weak var potassiumLabel: UILabel!
    
    @IBOutlet weak var magnesiumLabel: UILabel!
    
    @IBOutlet weak var calciuLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var chartView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
