//
//  HomeTableViewCell.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 25/03/22.
//

import UIKit
import DGCharts

class HomeTableViewCell: UITableViewCell {

    //MARK: Connection
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var chartView: HorizontalBarChartView!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
