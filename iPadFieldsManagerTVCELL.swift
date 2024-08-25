//
//  iPadFieldsManagerTVCELL.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 29/03/24.
//

import UIKit
import DGCharts

class iPadFieldsManagerTVCELL: UITableViewCell {

    //MARK: Connection
    
    @IBOutlet weak var fieldName: UILabel!
    
    @IBOutlet weak var growingLabel: UILabel!
    
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
