//
//  FieldSettingsViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 08/02/22.
//

import UIKit
import Firebase
import AVFoundation

class FieldSettingsViewController: UIViewController {

    
    //MARK: passed Var
    
    var fieldID: String?
    var fieldName: String?
    var fieldAREA: String?
    var fieldGrowing: String?
    var N: String?
    var PH: String?
    var PO: String?
    var CA: String?
    var MG: String?
    
    //MARK: Connection
    
    @IBOutlet weak var fieldNameArea: UILabel!
    
    @IBOutlet weak var growingBackground: UILabel!
    
    @IBOutlet weak var nitrogen: UILabel!
    
    @IBOutlet weak var phosphorus: UILabel!
    
    @IBOutlet weak var potassium: UILabel!
    
    @IBOutlet weak var calcium: UILabel!
    
    @IBOutlet weak var magnesium: UILabel!
    
    //BUTTON
    
    @IBOutlet weak var growing: UIButton!
    
    @IBOutlet weak var nitrogenLimit: UIButton!
    
    @IBOutlet weak var phosphorusLimit: UIButton!
    
    @IBOutlet weak var potassiumLimit: UIButton!
    
    @IBOutlet weak var magnesiumLimit: UIButton!
    
    @IBOutlet weak var calciumLimit: UIButton!
    
    @IBOutlet weak var area: UIButton!
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        overrideUserInterfaceStyle = .light
        
        if N!.isEmpty {
            print("no N value!")
        }else{
            nitrogenLimit.setTitle(String("Nitrogen Limit: \(N!) Kg/Ha"), for: .normal)
        }
        if PH!.isEmpty {
            print("no PHOSPHORUS value!")
        }else{
            phosphorusLimit.setTitle(String("Phosphorus Limit: \(PH!) Kg/Ha"), for: .normal)
        }
        if PO!.isEmpty {
            print("no POTASSIUM value!")
        }else{
            potassiumLimit.setTitle(String("Potassium Limit: \(PO!) Kg/Ha"), for: .normal)
        }
        if MG!.isEmpty {
            print("no MAGNESIUM value!")
        }else{
            magnesiumLimit.setTitle(String("Magnesium Limit: \(MG!) Kg/Ha"), for: .normal)
        }
        if CA!.isEmpty {
            print("no CALCIUM value!")
        }else{
            calciumLimit.setTitle(String("Calcium Limit: \(CA!) Kg/Ha"), for: .normal)
        }
        if fieldAREA!.isEmpty {
            area.setTitle("0.00 Ha", for: .normal)
        }else{
            area.setTitle(String("\(fieldAREA!) Ha"), for: .normal)
        }
        if fieldGrowing!.isEmpty {
            growing.setTitle("Growing", for: .normal)
        }else{
            growing.setTitle(String(fieldGrowing!), for: .normal)
        }
  
        growingBackground.layer.cornerRadius = 5
        fieldNameArea.layer.cornerRadius = 5
        nitrogen.layer.cornerRadius = 5
        phosphorus.layer.cornerRadius = 5
        potassium.layer.cornerRadius = 5
        calcium.layer.cornerRadius = 5
        magnesium.layer.cornerRadius = 5
        
        fieldNameArea.text = fieldName
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        FieldSettings()
    }
    
    //MARK: save the Field Settings
    
    let db = Firestore.firestore()
    
    func FieldSettings() {

        var are: String?
        var nitr: String?
        var phosph: String?
        var potass: String?
        var magn: String?
        var calc: String?
        
        
        let nit = String("\(nitrogenLimit.currentTitle)")
    
        let nitLimit = nit.components(separatedBy: " ")
        if nitLimit.count < 3 {
                nitr = String("Nitrogen limit")
            }else{
                nitr = nitLimit[2]
            }
        
        let pho = String("\(phosphorusLimit.currentTitle)")
        let phoLimit = pho.components(separatedBy: " ")
        if phoLimit.count < 3 {
            phosph = String("Phosphorus Limit")
        }else{
            phosph = phoLimit[2]
        }
        
        let pot = String("\(potassiumLimit.currentTitle)")
        let potLimit = pot.components(separatedBy: " ")
        if potLimit.count < 3 {
            potass = String("Potassium limit")
        }else{
            potass = potLimit[2]
        }
        
        let cal = String("\(calciumLimit.currentTitle)")
        let calLimit = cal.components(separatedBy: " ")
        if calLimit.count < 3 {
            calc = String("Calcium Limit")
        }else{
            calc = calLimit[2]
        }
        
        let mag = String("\(magnesiumLimit.currentTitle)")
        let magLimit = mag.components(separatedBy: " ")
        if magLimit.count < 3 {
            magn = String("Magnesium Limit")
        }else{
            magn = magLimit[2]
        }
        
        let ar = area.currentTitle
        let arHA = ar!.components(separatedBy: " ")
        if arHA.count < 2 {
            are = String("0.00 Ha")
        }else{
            are = arHA[0]
        }
        
        
        are?.replace(",", with: ".")
        nitr?.replace(",", with: ".")
        phosph?.replace(",", with: ".")
        potass?.replace(",", with: ".")
        calc?.replace(",", with: ".")
        magn?.replace(",", with: ".")
        
        db.collection("FarmField").document(fieldID!).updateData([
            "area": String("\(are!)"),
            "growing": String("\(growing.currentTitle!)"),
            "nitrogenLimit": String("\(nitr!)"),
            "phosphorusLimit": String("\(phosph!)"),
            "potassiumLimit": String("\(potass!)"),
            "calciumLimit": String("\(calc!)"),
            "magnesiumLimit": String("\(magn!)"),
            
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    //MARK: Action
    
    @IBAction func growingButtonTapped(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Growing", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Growing"
        }
        
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = alert.textFields![0].text
            
            if nitrogenLimit == "" {
                print("NO CROP!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.growing.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    
    
    }
    
    @IBAction func nitrogenLimitTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Nitrogen Limit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "N Kg/Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = String("Nitrogen Limit: \(alert.textFields![0].text!) Kg/Ha")
            
            if nitrogenLimit == "" {
                print("NO LIMIT!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.nitrogenLimit.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func phosphorusLimit(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Phosphorus Limit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "P Kg/Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = String("Phosphorus Limit: \(alert.textFields![0].text!) Kg/Ha")
            
            if nitrogenLimit == "" {
                print("NO LIMIT!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.phosphorusLimit.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func potassiumLimitTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Potassium Limit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "K Kg/Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = String("Potassium Limit: \(alert.textFields![0].text!) Kg/Ha")
            
            if nitrogenLimit == "" {
                print("NO LIMIT!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.potassiumLimit.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func magnesiumLimitTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Magnesium Limit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Mg Kg/Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = String("Magnesium Limit: \(alert.textFields![0].text!) Kg/Ha")
            
            if nitrogenLimit == "" {
                print("NO LIMIT!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.magnesiumLimit.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func calciumLimitTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Calcium Limit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Ca Kg/Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = String("Calcium Limit: \(alert.textFields![0].text!) Kg/Ha")
            
            if nitrogenLimit == "" {
                print("NO LIMIT!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.calciumLimit.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func areaSet(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Area Ha", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Area Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let nitrogenLimit = String("\(alert.textFields![0].text!) Ha")
            
            if nitrogenLimit == "" {
                print("NO AREA!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }
            self.area.setTitle(nitrogenLimit, for: .normal)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    }
    
    
    

}
