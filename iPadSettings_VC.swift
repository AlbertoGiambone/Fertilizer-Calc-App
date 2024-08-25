//
//  iPadSettings_VC.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 20/05/24.
//

import UIKit
import Firebase
import StoreKit
import RevenueCat

class iPadSettings_VC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    //MARK: Connection
    
    @IBOutlet weak var weightButton: UIButton!
    
    @IBOutlet weak var areaButton: UIButton!

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var restorePurchase: UIButton!

    
    //MARK: Array and var
    
    var settArray = [
        SettingsArray(Logo: UIImage(named: "AreaIMG")!, SettingsName: "Set Area Unit", SettValue: "", DisclosureIMG: UIImage(systemName: "arrow.down.to.line.compact")!), SettingsArray(Logo: UIImage(named: "WeightIMG")!, SettingsName: "Set Weight Unit", SettValue: "", DisclosureIMG: UIImage(systemName: "arrow.down.to.line.compact")!), SettingsArray(Logo: UIImage(named: "AddCustomArea")!, SettingsName: "Add Custom Area Unit",SettValue: "", DisclosureIMG: UIImage(systemName: "plus")!), SettingsArray(Logo: UIImage(named: "AddCustomWeight")!, SettingsName: "Add Custom Weight Unit", SettValue: "", DisclosureIMG: UIImage(systemName: "plus")!)
    ]
    
    
    var AREA_UNIT: [FARM_UNIT] = [(FARM_UNIT(UNIT_NAME: "Ha", UNIT_VALUE: "10000.00")), (FARM_UNIT(UNIT_NAME: "Acre", UNIT_VALUE: "4046.8564224")), (FARM_UNIT(UNIT_NAME: "Square Yard", UNIT_VALUE: "0.83612736"))]
    
    var WEIGHT_UNIT: [FARM_UNIT] = [(FARM_UNIT(UNIT_NAME: "Kg", UNIT_VALUE: "1.00")), (FARM_UNIT(UNIT_NAME: "lb", UNIT_VALUE: "0.45359237"))]
    
    
    
    var AggregateSettArray = [SettingsArray]()
    
    
    //MARK: Picker and ToolBar
    
    var UNIT_PICKER = UIPickerView()
    var toolBar = UIToolbar()
    var USER_ID: String?
    
    
    //MARK: Firestore
    
    let db = Firestore.firestore()
    
    func QueryAreaUnit() async {
        
        do {
            let querySnapshot = try await
            db.collection("AreaUnit").whereField("UID", isEqualTo: USER_ID ?? "").getDocuments()
            for document in querySnapshot.documents {
                let y = FARM_UNIT(UNIT_NAME: document.data()["name"] as? String ?? "", UNIT_VALUE: document.data()["AreaUnit"] as? String ?? "")
                
                self.AREA_UNIT.append(y)
            }
        }catch let err {
            print("Error getting documents: \(err)")
        }
    }
    
    func QueryWeightUnit() async {
        
        do {
            let querySnapshot = try await
            db.collection("WeightUnit").whereField("UID", isEqualTo: USER_ID ?? "").getDocuments()
            for document in querySnapshot.documents {
                
                let y = FARM_UNIT(UNIT_NAME: document.data()["name"] as? String ?? "", UNIT_VALUE: document.data()["WeightUnit"] as? String ?? "")
                self.WEIGHT_UNIT.append(y)
            }
        }catch let err {
            print("Error getting documents: \(err)")
        }
    }
    
    //MARK: Lifecycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        USER_ID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
        Task  {
            await QueryAreaUnit()
            await QueryWeightUnit()
        }
        
        weightButton.setTitle(UserDefaults.standard.object(forKey: "weightResultUnitName") as? String ?? "Kg", for: .normal)
        areaButton.setTitle(UserDefaults.standard.object(forKey: "areaResultUnitName") as? String ?? "Ha", for: .normal)
        
        refreshUserDetail()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        table.layer.cornerRadius = 15
        
        table.delegate = self
        table.dataSource = self
        
        table.rowHeight = 50
        table.estimatedRowHeight = 50
        
        restorePurchase.setTitle("🔄 Restore Purchase", for: .normal)
    }
    
    
    //MARK: Picker Settings
    
    var PickerTag = 0
    var whereAreYou: String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if PickerTag == 0 {
            return AREA_UNIT.count
        }else{
            return WEIGHT_UNIT.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if PickerTag == 0 {
            return AREA_UNIT[row].UNIT_NAME
        }else{
            return WEIGHT_UNIT[row].UNIT_NAME
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        switch whereAreYou {
        case "weightButton":
            UserDefaults.standard.set(WEIGHT_UNIT[row].UNIT_VALUE, forKey: "weightResultUnit")
            UserDefaults.standard.set(WEIGHT_UNIT[row].UNIT_NAME, forKey: "weightResultUnitName")
            weightButton.titleLabel?.text = UserDefaults.standard.object(forKey: "weightResultUnitName") as? String ?? "Kg"
            print("weight result unit: \(WEIGHT_UNIT[row].UNIT_NAME)")
            print("weight result value: \(WEIGHT_UNIT[row].UNIT_VALUE)")
        case "areaButton":
            UserDefaults.standard.set(AREA_UNIT[row].UNIT_VALUE, forKey: "areaResultUnit")
            UserDefaults.standard.set(AREA_UNIT[row].UNIT_NAME, forKey: "areaResultUnitName")
            areaButton.titleLabel?.text = UserDefaults.standard.object(forKey: "areaResultUnitName") as? String ?? "Ha"
            print("area result unit: \(AREA_UNIT[row].UNIT_NAME)")
            print("area result value: \(AREA_UNIT[row].UNIT_VALUE)")
        default:
            print("default")
        }
        
    }
    
    
    //MARK: Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! iPadSettings_Tv_Cell
        
        cell.LogoIMG.image = settArray[indexPath.row].Logo
        cell.TextLabel.text = settArray[indexPath.row].SettingsName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = settArray[indexPath.row].Logo
        if selected == UIImage(named: "AreaIMG") {
            print("Select Area Unit!")
            PickerTag = 0
            
            UNIT_PICKER = UIPickerView.init()
            UNIT_PICKER.delegate = self
            UNIT_PICKER.dataSource = self
            UNIT_PICKER.backgroundColor = UIColor.systemGray3
            UNIT_PICKER.setValue(UIColor.black, forKey: "textColor")
            UNIT_PICKER.autoresizingMask = .flexibleWidth
            UNIT_PICKER.contentMode = .center
            UNIT_PICKER.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(UNIT_PICKER)
            
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
            self.areaButton.setTitle(UserDefaults.standard.object(forKey: "areaResultUnitName") as? String ?? "Ha", for: .normal)
        }
        if selected == UIImage(named: "WeightIMG") {
            print("Select Weight Unit!")
            PickerTag = 1
            
            UNIT_PICKER = UIPickerView.init()
            UNIT_PICKER.delegate = self
            UNIT_PICKER.dataSource = self
            UNIT_PICKER.backgroundColor = UIColor.systemGray3
            UNIT_PICKER.setValue(UIColor.black, forKey: "textColor")
            UNIT_PICKER.autoresizingMask = .flexibleWidth
            UNIT_PICKER.contentMode = .center
            UNIT_PICKER.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(UNIT_PICKER)
            
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            //toolBar.barStyle = .blackTranslucent
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
            self.weightButton.setTitle(UserDefaults.standard.object(forKey: "weightResultUnitName") as? String ?? "Kg", for: .normal)
        }
        if selected == UIImage(named: "AddCustomArea") {
            
            //RevenueCat Check
            
            Task { @MainActor in
                
                do {
                    let shared = try await AppTransaction.shared
                    
                    if case .verified(let appTransaction) = shared {
                        let newBusinessModel = "2"
                        
                        let VersionComponents = appTransaction.originalAppVersion.split(separator: ".")
                        
                        let FirstVersionComponent = VersionComponents[0]
                        
                        Purchases.shared.getCustomerInfo { (customerInfo, error) in
                            if customerInfo?.entitlements.all[Costants.entitlementID]?.isActive == true || FirstVersionComponent < newBusinessModel {
                                // User is "premium"
                                
                                print("Add your custom Area Unit!")
                                self.PickerTag = 2
                                
                                let CUSTOM_AREA = UIAlertController(title: "Custom Area Unit", message: "Insert Area name and unit in square meters!", preferredStyle: .alert)
                                CUSTOM_AREA.addTextField{ (textField) in
                                    textField.placeholder = "Name"
                                    textField.keyboardType = .default
                                }
                                CUSTOM_AREA.addTextField{ (textField) in
                                    textField.placeholder = "Unit in square meters"
                                    textField.keyboardType = .decimalPad
                                }
                                
                                let saveTapped = UIAlertAction(title: "Save", style: .default){ (_) in
                                    
                                    self.db.collection("AreaUnit").addDocument(data: [
                                        
                                        "UID": String(self.USER_ID ?? ""),
                                        "name": String(CUSTOM_AREA.textFields?[0].text ?? ""),
                                        "AreaUnit": String(CUSTOM_AREA.textFields?[1].text ?? ""),
                                        
                                    ]) { err in
                                        if let err = err {
                                            print("Error adding document: \(err)")
                                        } else {
                                            print("Client added successifully!")
                                        }
                                    }
                                }
                                
                                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                                    print("Cancel button tapped");
                                }
                                
                                CUSTOM_AREA.addAction(saveTapped)
                                CUSTOM_AREA.addAction(cancelAction)
                                
                                self.present(CUSTOM_AREA, animated: true, completion: nil)
                            }else{
                                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "paywall") as! PayWall
                                nextVC.modalPresentationStyle = .automatic
                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }
                        }
                        
                    }
                }
            }
            
        }
        
    
            
        if selected == UIImage(named: "AddCustomWeight") {
            
            //RevenueCat Check
            
            Task { @MainActor in
                
                do {
                    let shared = try await AppTransaction.shared
                    
                    if case .verified(let appTransaction) = shared {
                        let newBusinessModel = "2"
                        
                        let VersionComponents = appTransaction.originalAppVersion.split(separator: ".")
                        
                        let FirstVersionComponent = VersionComponents[0]
                        
                        Purchases.shared.getCustomerInfo { (customerInfo, error) in
                            if customerInfo?.entitlements.all[Costants.entitlementID]?.isActive == true || FirstVersionComponent < newBusinessModel {
                                // User is "premium"
                                
                                print("Add your custom Weight Unit!")
                                self.PickerTag = 3
                                
                                let CUSTOM_WEIGHT = UIAlertController(title: "Custom Weight Unit", message: "Insert Weight unit name in Kilogram!", preferredStyle: .alert)
                                CUSTOM_WEIGHT.addTextField{ (textField) in
                                    textField.placeholder = "Name"
                                    textField.keyboardType = .default
                                }
                                CUSTOM_WEIGHT.addTextField{ (textField) in
                                    textField.placeholder = "Unit in Kilogram"
                                    textField.keyboardType = .decimalPad
                                }
                                
                                let saveTapped = UIAlertAction(title: "Save", style: .default){ (_) in
                                    
                                    self.db.collection("WeightUnit").addDocument(data: [
                                        
                                        "UID": String(self.USER_ID ?? ""),
                                        "name": String(CUSTOM_WEIGHT.textFields?[0].text ?? ""),
                                        "WeightUnit": String(CUSTOM_WEIGHT.textFields?[1].text ?? ""),
                                        
                                    ]) { err in
                                        if let err = err {
                                            print("Error adding document: \(err)")
                                        } else {
                                            print("Client added successifully!")
                                        }
                                    }
                                }
                                
                                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                                    print("Cancel button tapped");
                                }
                                
                                CUSTOM_WEIGHT.addAction(saveTapped)
                                CUSTOM_WEIGHT.addAction(cancelAction)
                                
                                self.present(CUSTOM_WEIGHT, animated: true, completion: nil)
                            }else{
                                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "paywall") as! PayWall
                                nextVC.modalPresentationStyle = .automatic
                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        UNIT_PICKER.removeFromSuperview()
    }
    
    
    //RevenueCat user manager
    
    func refreshUserDetail() {
        self.statusLabel.text = Purchases.shared.appUserID
        
        if Purchases.shared.isAnonymous {
            self.statusLabel.text = "User is Anonymous"
        }
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if customerInfo?.entitlements[Costants.entitlementID]?.isActive == true {
                    self.statusLabel.text = "Active 🟢"
                    self.statusLabel.textColor = .green
                }else{
                    self.statusLabel.text = "Not Active 🔴"
                    self.statusLabel.textColor = .red
                }
            }
        }
        
    }
  
    //MARK: Action
    
    @IBAction func restorePurchaseTapped(_ sender: UIButton) {
        Purchases.shared.restorePurchases { (CustomerInfo, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("SUCCESS!")
            }
        }
    }
    
    @IBAction func weightButtonTapped(_ sender: UIButton) {
        
        print("Select Weight Unit!")
        PickerTag = 1
        
        whereAreYou = "weightButton"
        
        UNIT_PICKER = UIPickerView.init()
        UNIT_PICKER.delegate = self
        UNIT_PICKER.dataSource = self
        UNIT_PICKER.backgroundColor = UIColor.systemGray3
        UNIT_PICKER.setValue(UIColor.black, forKey: "textColor")
        UNIT_PICKER.autoresizingMask = .flexibleWidth
        UNIT_PICKER.contentMode = .center
        UNIT_PICKER.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(UNIT_PICKER)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           //toolBar.barStyle = .blackTranslucent
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
        
    }
    
    @IBAction func areaButton(_ sender: UIButton) {
        
        PickerTag = 0
        
        whereAreYou = "areaButton"
        
        UNIT_PICKER = UIPickerView.init()
        UNIT_PICKER.delegate = self
        UNIT_PICKER.dataSource = self
        UNIT_PICKER.backgroundColor = UIColor.systemGray3
        UNIT_PICKER.setValue(UIColor.black, forKey: "textColor")
        UNIT_PICKER.autoresizingMask = .flexibleWidth
        UNIT_PICKER.contentMode = .center
        UNIT_PICKER.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(UNIT_PICKER)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           //toolBar.barStyle = .blackTranslucent
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
        
    }
    
}
