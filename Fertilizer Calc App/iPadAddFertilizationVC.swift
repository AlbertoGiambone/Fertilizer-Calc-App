//
//  iPadAddFertilizationVC.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 21/04/24.
//

import UIKit
import Firebase

class iPadAddFertilizationVC: UIViewController {

    //MARK: passed Var
    
    var fieldID: String?
    var fieldName: String?
    
    var fielDID: String?
    var fertUID: String?
    var fertFID: String?
    var fertN: String?
    var fertP: String?
    var fertPO: String?
    var fertMG: String?
    var fertCA: String?
    var fertQ: String?
    var fertDATE: String?
    
    var editingMode = false
    
    
    //MARK: Connection
    
    @IBOutlet weak var fieldNAME: UILabel!
    
    
    
    
    //MARK: LifeCycle
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fieldNAME.text = fieldName
        overrideUserInterfaceStyle = .light
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        /*
        if editingMode == true {
            
            nitrogenLabel.text = fertN ?? ""
            phosphorusLabel.text = fertP ?? ""
            potassiumLabel.text = fertPO ?? ""
            magnesiumLabel.text = fertMG ?? ""
            claciumLabel.text = fertCA ?? ""
            quantityLabel.text = fertQ ?? ""
            let da = fertDATE ?? ""
            let FDATE = DateFormatter()
            FDATE.dateStyle = .short
            let t = FDATE.date(from: da)
            datePicker.date = t ?? Date()
        }
        */
    }
 
}
