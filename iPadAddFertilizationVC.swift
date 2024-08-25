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
    
    @IBOutlet weak var nitrogenLabel: UITextField!

    @IBOutlet weak var phosphorusLabel: UITextField!

    @IBOutlet weak var potassiumLabel: UITextField!

    @IBOutlet weak var magnesiumLabel: UITextField!

    @IBOutlet weak var claciumLabel: UITextField!

    @IBOutlet weak var quantityLabel: UITextField!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: LifeCycle
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fieldNAME.text = fieldName
        overrideUserInterfaceStyle = .light
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
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
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if editingMode == true {
            
            if fieldID!.isEmpty || fieldID == "" {
                navigationController?.popViewController(animated: true)
            }else{
            
                let db = Firestore.firestore()
                
                var n = nitrogenLabel.text ?? ""
                
                var ph = phosphorusLabel.text ?? ""
                
                var ca = claciumLabel.text ?? ""
                
                var mg = magnesiumLabel.text ?? ""
      
                var po = potassiumLabel.text ?? ""
                
                var qu = quantityLabel.text ?? ""
                
                
                n.replace(",", with: ".")
                ph.replace(",", with: ".")
                ca.replace(",", with: ".")
                mg.replace(",", with: ".")
                po.replace(",", with: ".")
                qu.replace(",", with: ".")
                
                let newDate = datePicker?.date
                let dayFormatter = DateFormatter()
                dayFormatter.dateStyle = .short
                let d = dayFormatter.string(from: newDate!)
                
                let DOCREFERENCE = db.collection("Ferilization").document(fertFID!)
                
                DOCREFERENCE.updateData([
                    "nitrogen": String(n), "phosphorus": String(ph), "potassium": String(po), "calcium": String(ca), "magnesium": String(mg), "quantity": String(qu), "date": String(d), "UID": self.userID!, "FID": String(fieldID!)
                ])
                { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        }
                    }
                    //navigationController?.popViewController(animated: true)
                    print("FERT ADDED SUCCESSIFULLY;)")
            }
            
        }else{
    
        if fieldID!.isEmpty || fieldID == "" {
            navigationController?.popViewController(animated: true)
        }else{
        
        let db = Firestore.firestore()
    
            // ESEMPIO var t = nitrogenLabel.text ?? ""
            
            var n = nitrogenLabel.text ?? ""
            
            var ph = phosphorusLabel.text ?? ""
            
            var ca = claciumLabel.text ?? ""
            
            var mg = magnesiumLabel.text ?? ""
  
            var po = potassiumLabel.text ?? ""
            
            var qu = quantityLabel.text ?? ""
            
            
            n.replace(",", with: ".")
            ph.replace(",", with: ".")
            ca.replace(",", with: ".")
            mg.replace(",", with: ".")
            po.replace(",", with: ".")
            qu.replace(",", with: ".")
  
            let newDate = datePicker?.date
            let dayFormatter = DateFormatter()
            dayFormatter.dateStyle = .short
            let d = dayFormatter.string(from: newDate!)
            
            
        db.collection("Ferilization").addDocument(data: [
            "nitrogen": String(n), "phosphorus": String(ph), "potassium": String(po), "calcium": String(ca), "magnesium": String(mg), "quantity": String(qu), "date": String(d), "UID": self.userID!, "FID": String(fieldID!)
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                }
            }
            print("FERT ADDED SUCCESSIFULLY;)")
            dismiss(animated: true)
            }
        
        }
        
    }
    
    
 
}
