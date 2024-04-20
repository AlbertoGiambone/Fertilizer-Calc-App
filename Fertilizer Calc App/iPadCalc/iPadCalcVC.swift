//
//  iPadCalcVC.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 19/03/24.
//

import UIKit
import RevenueCat
import StoreKit
import Firebase

class iPadCalcVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Connection
    
    @IBOutlet weak var NInput: RoundButton!
    
    @IBOutlet weak var PInput: RoundButton!
    
    @IBOutlet weak var KInput: RoundButton!
    
    @IBOutlet weak var KGInput: RoundButton!
    
    @IBOutlet weak var NResult: UILabel!
    
    @IBOutlet weak var PResult: UILabel!
    
    @IBOutlet weak var KResult: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var weightButton: UIButton!
    
    @IBOutlet weak var areaButton: UIButton!
    
    @IBOutlet weak var resultUnitLabel: UILabel!
    
    @IBOutlet weak var ViewTitle: UIBarButtonItem!
    
    @IBOutlet weak var PurchaseState: UIBarButtonItem!
    
    @IBOutlet weak var HelpButton: UIBarButtonItem!
    
    @IBOutlet weak var Nbutton: UIButton!
    
    @IBOutlet weak var Pbutton: UIButton!
    
    @IBOutlet weak var Kbutton: UIButton!
    
    @IBOutlet weak var KGbutton: UIButton!
  
    @IBOutlet weak var KG_Label: UILabel!
    
    //MARK: FIRESTORE
    
    let db = Firestore.firestore()
    var USER_ID: String?
    var AREA_UNIT_TO_AGGREGATE = [SettingsArray]()
    var WEIGHT_UNIT_TO_AGGREGATE = [SettingsArray]()
    
    func gettingPaidUnit() async {
        
        do {
            let querySnapshot = try await db.collection("AreaUnit").whereField("UID", isEqualTo: USER_ID ?? "").getDocuments()
            for document in querySnapshot.documents {
                let y = SettingsArray(Logo: UIImage(named: "AreaIMG")!, SettingsName: document.data()["name"] as? String ?? "", SettValue: document.data()["AreaUnit"] as? String ?? "", DisclosureIMG: UIImage(systemName: "arrow.down.to.line.compact")!)
                
                self.AREA_UNIT_TO_AGGREGATE.append(y)
            }
        } catch let err {
            print("Error getting documents: \(err)")
        }
        
        do {
            let querySnapshot = try await db.collection("WeightUnit").whereField("UID", isEqualTo: USER_ID ?? "").getDocuments()
            for document in querySnapshot.documents {
                let y = SettingsArray(Logo: UIImage(named: "WeightIMG")!, SettingsName: document.data()["name"] as? String ?? "", SettValue: document.data()["WeightUnit"] as? String ?? "", DisclosureIMG: UIImage(systemName: "arrow.down.to.line.compact")!)
                
                self.WEIGHT_UNIT_TO_AGGREGATE.append(y)
            }
        } catch let err {
            print("Error getting documents: \(err)")
        }
        
    }

    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        //resultBackGround.layer.cornerRadius = 15
        
        areaButton.titleLabel?.adjustsFontSizeToFitWidth = true
        areaButton.titleLabel?.numberOfLines = 1
        
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        USER_ID = UserDefaults.standard.object(forKey: "userInfo") as? String ?? ""
        
        Task {
            await gettingPaidUnit()
            
            for i in AREA_UNIT_TO_AGGREGATE {
                
                let t = FARM_UNIT(UNIT_NAME: i.SettingsName, UNIT_VALUE: i.SettValue)
                
                AREA_UNIT.append(t)
            }
            
            for o in WEIGHT_UNIT_TO_AGGREGATE {
                let y = FARM_UNIT(UNIT_NAME: o.SettingsName, UNIT_VALUE: o.SettValue)
                
                WEIGHT_UNIT.append(y)
            }
        }
        
        let Wunit = UserDefaults.standard.object(forKey: "weight_unit_name") as? String ?? "Kg"
        weightButton.setTitle(Wunit, for: .normal)
        KG_Label.text = String(Wunit)
        //segment.setTitle(Wunit, forSegmentAt: 3)
        
        let Aunit = UserDefaults.standard.object(forKey: "area_unit_name") as? String ?? "Ha"
        areaButton.setTitle(Aunit, for: .normal)
        areaButton.titleLabel?.adjustsFontSizeToFitWidth = true
        areaButton.titleLabel?.numberOfLines = 1
        
        rWeight = UserDefaults.standard.object(forKey: "weightResultUnitName") as? String ?? "Kg"
        rArea = UserDefaults.standard.object(forKey: "areaResultUnitName") as? String ?? "Ha"
        
        rAREA = UserDefaults.standard.object(forKey: "areaResultUnit") as? String ?? "10000.00"
        rWEIGHT = UserDefaults.standard.object(forKey: "weightResultUnit") as? String ?? "1.00"
        
        resultUnitLabel.text = String("\(rWeight!)/\(rArea!)")
        
        AREA = UserDefaults.standard.object(forKey: "area_unit_value") as? String ?? "10000.00"
        WEIGHT = UserDefaults.standard.object(forKey: "weight_unit_value") as? String ?? "1.00"
        
        Segment_VAR = "n"
        
            Pbutton.layer.borderWidth = 0
            Pbutton.titleLabel?.sizeToFit()
            Pbutton.titleLabel?.numberOfLines = 0
            Kbutton.layer.borderWidth = 0
            Kbutton.titleLabel?.numberOfLines = 0
            Kbutton.titleLabel?.sizeToFit()
            KGbutton.layer.borderWidth = 0
            KGbutton.titleLabel?.sizeToFit()
            KGbutton.titleLabel?.numberOfLines = 0
            Nbutton.layer.cornerRadius = 10
            Nbutton.titleLabel?.sizeToFit()
            Nbutton.titleLabel?.numberOfLines = 0
            Nbutton.layer.borderWidth = 3
            Nbutton.layer.borderColor = CGColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
            Nbutton.titleLabel?.adjustsFontSizeToFitWidth = true
            Nbutton.titleLabel?.numberOfLines = 1
            Pbutton.titleLabel?.adjustsFontSizeToFitWidth = true
            Pbutton.titleLabel?.numberOfLines = 1
            Kbutton.titleLabel?.adjustsFontSizeToFitWidth = true
            Kbutton.titleLabel?.numberOfLines = 1
            KGbutton.titleLabel?.adjustsFontSizeToFitWidth = true
            KGbutton.titleLabel?.numberOfLines = 1
    }
    
    
    //MARK: TableView func
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleFert.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! iPadCalcTVCell
        cell.fertLabel.text = String(singleFert[indexPath.row])
        cell.fertLabel.textAlignment = .left
        
        return cell
    }
    
    //MARK: Segment Button
    
    var Segment_VAR: String?
    
    @IBAction func NbuttonPressed(_ sender: UIButton) {
 
        Segment_VAR = "n"
        
            Pbutton.layer.borderWidth = 0
            Kbutton.layer.borderWidth = 0
            KGbutton.layer.borderWidth = 0
            Nbutton.layer.cornerRadius = 10
            Nbutton.layer.borderWidth = 3
            Nbutton.layer.borderColor = CGColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
    }
    
    @IBAction func PbuttonPressed(_ sender: UIButton) {
        
        Segment_VAR = "p"
        
        Nbutton.layer.borderWidth = 0
        Kbutton.layer.borderWidth = 0
        KGbutton.layer.borderWidth = 0
        Pbutton.layer.cornerRadius = 10
        Pbutton.layer.borderWidth = 3
        Pbutton.layer.borderColor = CGColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
    }
    
    @IBAction func KbuttonPressed(_ sender: UIButton) {
        
        Segment_VAR = "k"
        
        Nbutton.layer.borderWidth = 0
        Pbutton.layer.borderWidth = 0
        KGbutton.layer.borderWidth = 0
        Kbutton.layer.cornerRadius = 10
        Kbutton.layer.borderWidth = 3
        Kbutton.layer.borderColor = CGColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
    }
    
    @IBAction func KGbuttonPressed(_ sender: UIButton) {
        
        Segment_VAR = "kg"
        
        Nbutton.layer.borderWidth = 0
        Pbutton.layer.borderWidth = 0
        Kbutton.layer.borderWidth = 0
        KGbutton.layer.cornerRadius = 10
        KGbutton.layer.borderWidth = 3
        KGbutton.layer.borderColor = CGColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 1)
    }
    
    
    //MARK: Weight and Area Picker
    
    
    var UNIT_PICKER = UIPickerView()
    var toolBar = UIToolbar()
    
    var AREA_UNIT: [FARM_UNIT] = [(FARM_UNIT(UNIT_NAME: "Ha", UNIT_VALUE: "10000.00")), (FARM_UNIT(UNIT_NAME: "Acre", UNIT_VALUE: "4046.8564224")), (FARM_UNIT(UNIT_NAME: "Square Yard", UNIT_VALUE: "0.83612736"))]
    
    var WEIGHT_UNIT: [FARM_UNIT] = [(FARM_UNIT(UNIT_NAME: "Kg", UNIT_VALUE: "1.00")), (FARM_UNIT(UNIT_NAME: "lb", UNIT_VALUE: "0.45359237"))]

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AREA_WEIGHT.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AREA_WEIGHT[row].UNIT_NAME
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if itsMe == "Weight" {
            let SELECTED_NAME = String(AREA_WEIGHT[row].UNIT_NAME)
            let SELECTED_VALUE = String(AREA_WEIGHT[row].UNIT_VALUE)
            
            UserDefaults.standard.set(SELECTED_NAME, forKey: "weight_unit_name")
            UserDefaults.standard.set(SELECTED_VALUE, forKey: "weight_unit_value")
            WEIGHT = SELECTED_VALUE
            UNIT_PICKER.removeFromSuperview()
            toolBar.removeFromSuperview()
            print("UNIT SELECTED: \(SELECTED_NAME)")
            weightButton.titleLabel?.text = String(SELECTED_NAME)
            KG_Label.text = String(SELECTED_NAME)
        }
        if itsMe == "Area" {
            let SELECTED_NAME = AREA_WEIGHT[row].UNIT_NAME
            let SELECTED_VALUE = AREA_WEIGHT[row].UNIT_VALUE
            
            UserDefaults.standard.set(SELECTED_NAME, forKey: "area_unit_name")
            UserDefaults.standard.set(SELECTED_VALUE, forKey: "area_unit_value")
            AREA = SELECTED_VALUE
            UNIT_PICKER.removeFromSuperview()
            toolBar.removeFromSuperview()
            print("UNIT SELECTED: \(SELECTED_NAME)")
            areaButton.titleLabel?.text = String(SELECTED_NAME)
            areaButton.titleLabel?.adjustsFontSizeToFitWidth = true
            areaButton.titleLabel?.numberOfLines = 1
        }
        
    }
   
    //MARK: Var to update with keyboard
    
    var N_AMOUNT: String?
    var P_AMOUNT: String?
    var K_AMOUNT: String?
    var KG_AMOUNT: String?
    
    var singleFert = [String]()
    var Nsum = [Double]()
    var Psum = [Double]()
    var Ksum = [Double]()
    
    var AREA_WEIGHT = [FARM_UNIT]()
    
    var AREA: String?
    var WEIGHT: String?
    
    var rAREA: String?
    var rWEIGHT: String?
    
    var rArea: String?
    var rWeight: String?
    
    
    //MARK: Action
    
    var itsMe: String?
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        UNIT_PICKER.removeFromSuperview()
    }
    
    @IBAction func WeightPressed(_ sender: UIButton) {
        UNIT_PICKER = UIPickerView.init()
        UNIT_PICKER.delegate = self
        UNIT_PICKER.dataSource = self
        UNIT_PICKER.backgroundColor = UIColor.white
        UNIT_PICKER.setValue(UIColor.black, forKey: "textColor")
        UNIT_PICKER.autoresizingMask = .flexibleWidth
        UNIT_PICKER.contentMode = .center
        UNIT_PICKER.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(UNIT_PICKER)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           //toolBar.barStyle = .blackTranslucent
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
        
        AREA_WEIGHT = WEIGHT_UNIT
        itsMe = "Weight"
    }
    
    @IBAction func AreaPressed(_ sender: UIButton) {
        UNIT_PICKER = UIPickerView.init()
        UNIT_PICKER.delegate = self
        UNIT_PICKER.dataSource = self
        UNIT_PICKER.backgroundColor = UIColor.white
        UNIT_PICKER.setValue(UIColor.black, forKey: "textColor")
        UNIT_PICKER.autoresizingMask = .flexibleWidth
        UNIT_PICKER.contentMode = .center
        UNIT_PICKER.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(UNIT_PICKER)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           //toolBar.barStyle = .blackTranslucent
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
        
        AREA_WEIGHT = AREA_UNIT
        itsMe = "Area"
        areaButton.titleLabel?.adjustsFontSizeToFitWidth = true
        areaButton.titleLabel?.numberOfLines = 1
    }
    
    @IBAction func SettingsPressed(_ sender: UIBarButtonItem) {
        
        
        let nextVC = navigationController?.storyboard?.instantiateViewController(withIdentifier: "Settings") as! SettingsVC
        nextVC.modalPresentationStyle = .automatic
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func ZeroPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "0"
                NInput.setTitle("0", for: .normal)
            }else{
                N_AMOUNT = String("\(N_AMOUNT!)0")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "0"
                PInput.setTitle("0", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)0")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "0"
                KInput.setTitle("0", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)0")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "0"
                KGInput.setTitle("0", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)0")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func OnePressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "1"
                NInput.setTitle("1", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)1")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "1"
                PInput.setTitle("1", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)1")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "1"
                KInput.setTitle("1", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)1")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "1"
                KGInput.setTitle("1", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)1")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func TwoPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "2"
                NInput.setTitle("2", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)2")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "2"
                PInput.setTitle("2", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)2")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "2"
                KInput.setTitle("2", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)2")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "2"
                KGInput.setTitle("2", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)2")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func ThreePressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "3"
                NInput.setTitle("3", for: .normal)
            }else{
                N_AMOUNT = String("\(N_AMOUNT!)3")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "3"
                PInput.setTitle("3", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)3")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "3"
                KInput.setTitle("3", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)3")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "3"
                KGInput.setTitle("3", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)3")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func FourPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "4"
                NInput.setTitle("4", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)4")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "4"
                PInput.setTitle("4", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)4")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "4"
                KInput.setTitle("4", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)4")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "4"
                KGInput.setTitle("4", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)4")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func FivePressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "5"
                NInput.setTitle("5", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)5")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "5"
                PInput.setTitle("5", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)5")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "5"
                KInput.setTitle("5", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)5")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "5"
                KGInput.setTitle("5", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)5")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func SixPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "6"
                NInput.setTitle("6", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)6")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "6"
                PInput.setTitle("6", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)6")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "6"
                KInput.setTitle("6", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)6")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "6"
                KGInput.setTitle("6", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)6")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func SevenPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "7"
                NInput.setTitle("7", for: .normal)
            }else{
                N_AMOUNT = String("\(N_AMOUNT!)7")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "7"
                PInput.setTitle("7", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)7")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "7"
                KInput.setTitle("7", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)7")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "7"
                KGInput.setTitle("7", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)7")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func EightPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "8"
                NInput.setTitle("8", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)8")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "8"
                PInput.setTitle("8", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)8")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "8"
                KInput.setTitle("8", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)8")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "8"
                KGInput.setTitle("8", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)8")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func NinePressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT == nil {
                N_AMOUNT = "9"
                NInput.setTitle("9", for: .normal)
            }else{
                
                N_AMOUNT = String("\(N_AMOUNT!)9")
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT == nil {
                P_AMOUNT = "9"
                PInput.setTitle("9", for: .normal)
            }else{
                P_AMOUNT = String("\(P_AMOUNT!)9")
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT == nil {
                K_AMOUNT = "9"
                KInput.setTitle("9", for: .normal)
            }else{
                K_AMOUNT = String("\(K_AMOUNT!)9")
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT == nil {
                KG_AMOUNT = "9"
                KGInput.setTitle("9", for: .normal)
            }else{
                
                KG_AMOUNT = String("\(KG_AMOUNT!)9")
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    //VAR
    
    var Nresult: Double = 0
    var Presult: Double = 0
    var Kresult: Double = 0
    
    
    @IBAction func EnterPressed(_ sender: UIButton) {
        let N = Double(NInput.titleLabel?.text ?? "0.00")
        let P = Double(PInput.titleLabel?.text ?? "0.00")
        let K = Double(KInput.titleLabel?.text ?? "0.00")
        let KG = Double(KGInput.titleLabel?.text ?? "0.00")
        let A = Double(AREA!)
        let W = Double(WEIGHT!)
        
        let rA = Double(rAREA!)
        let rW = Double(rWEIGHT!)
        
        let aA: Double = (rA! / A!)
        let Wr: Double = (W! / rW!)
        
        Nresult += ((N! / 100) * KG! * (Wr) * (aA)).truncate(places: 2)
        Presult += ((P! / 100) * KG! * (Wr) * (aA)).truncate(places: 2)
        Kresult += ((K! / 100) * KG! * (Wr) * (aA)).truncate(places: 2)
        
        NResult.text = String("\(Nresult.truncate(places: 2)) N")
        PResult.text = String("\(Presult.truncate(places: 2)) P")
        KResult.text = String("\(Kresult.truncate(places: 2)) K")
        
        print("WEIGHT:\(W) rWeight:\(rW) rArea: \(rA) AREA: \(A) KG:\(KG!)")
    }
    
    @IBAction func DelPressed(_ sender: UIButton) {
        if Segment_VAR == "n" {
            if N_AMOUNT?.isEmpty == true {
                print("Nothing to DROP!")
            }else{
                
                N_AMOUNT?.removeLast()
                NInput.setTitle(N_AMOUNT, for: .normal)
                print(N_AMOUNT!)
            }
        }
        if Segment_VAR == "p" {
            if P_AMOUNT?.isEmpty == true {
                print("Nothing to DROP!")
            }else{
                P_AMOUNT?.removeLast()
                PInput.setTitle(P_AMOUNT, for: .normal)
                print(P_AMOUNT!)
            }
        }
        if Segment_VAR == "k" {
            if K_AMOUNT?.isEmpty == true {
                print("Nothing to DROP!")
            }else{
                K_AMOUNT?.removeLast()
                KInput.setTitle(K_AMOUNT, for: .normal)
                print(K_AMOUNT!)
            }
        }
        if Segment_VAR == "kg" {
            if KG_AMOUNT?.isEmpty == true {
                print("Nothing to DROP!")
            }else{
                KG_AMOUNT?.removeLast()
                KGInput.setTitle(KG_AMOUNT, for: .normal)
                print(KG_AMOUNT!)
            }
        }
    }
    
    @IBAction func EreaseAllPressed(_ sender: UIButton) {
        N_AMOUNT = "0"
        P_AMOUNT = "0"
        K_AMOUNT = "0"
        KG_AMOUNT = "0"
        NInput.setTitle("0", for: .normal)
        PInput.setTitle("0", for: .normal)
        KInput.setTitle("0", for: .normal)
        KGInput.setTitle("0", for: .normal)
        Nresult = 0
        Presult = 0
        Kresult = 0
        NResult.text = "N"
        PResult.text = "P"
        KResult.text = "K"
        singleFert.removeAll()
        table.reloadData()
    }
    
    @IBAction func PlusPressed(_ sender: UIButton) {
        let N = Double(NInput.titleLabel?.text ?? "0.00")
        let P = Double(PInput.titleLabel?.text  ?? "0.00")
        let K = Double(KInput.titleLabel?.text  ?? "0.00")
        let KG = Double(KGInput.titleLabel?.text  ?? "0.00")
        
        let A = Double(AREA!)
        let W = Double(WEIGHT!)
        
        let rA = Double(rAREA!)
        let rW = Double(rWEIGHT!)
        
        let aA: Double = (rA! / A!)
        let Wr: Double = (W! / rW!)
        
        let NR = ((N! / 100) * KG! * (Wr) * (aA)).truncate(places: 2)
        let PR = ((P! / 100) * KG! * (Wr) * (aA)).truncate(places: 2)
        let KR = ((K! / 100) * KG! * (Wr) * (aA)).truncate(places: 2)
        
        let Wunit = UserDefaults.standard.object(forKey: "weight_unit_name") as? String ?? "Kg"
        
        Nresult += NR
        Presult += PR
        Kresult += KR
        
        Nsum.append(NR)
        Psum.append(PR)
        Ksum.append(KR)
        
        NResult.text = String("\(Nresult.truncate(places: 2)) N")
        PResult.text = String("\(Presult.truncate(places: 2)) P")
        KResult.text = String("\(Kresult.truncate(places: 2)) K")
        
        let single = String("\(N ?? 0)N \(P ?? 0)P \(K ?? 0)K \(KG ?? 0)\(Wunit)")
        singleFert.append(single)
        print(single)
        table.reloadData()
    }
    
    @IBAction func LessPressed(_ sender: UIButton) {
        if singleFert.count >= 1 {
            
            Nsum.removeLast()
            Psum.removeLast()
            Ksum.removeLast()
            NResult.text = String("\(Nsum.reduce(0, +))N")
            PResult.text = String("\(Psum.reduce(0, +))P")
            KResult.text = String("\(Ksum.reduce(0, +))K")
            
            singleFert.removeLast()
            table.reloadData()
        }else{
            print("Array of fertilization ERROR.")
        }
    }
    
    
    

}
