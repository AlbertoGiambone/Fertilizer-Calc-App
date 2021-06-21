//
//  SETareaORweightViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 09/06/21.
//

import UIKit
import Firebase

class SETareaORweightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: object connection
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var selectedUnit: UILabel!
    

    //MARK: var for select TV
    
    var area: Bool?
    var weight: Bool?
    
    
    //MARK: VC Lifecycle
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        if area == true {
            selectedUnit.text = UserDefaults.standard.object(forKey: "NomeArea") as? String
        }
        if weight == true {
            selectedUnit.text = UserDefaults.standard.object(forKey: "NomeWeight") as? String
        }
        
    }
    

    
    //MARK: TV Settings
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var L: Int?
        
        if area == true {
            L = nomi.count
        }
        if weight == true {
            L = measureUnit.count
        }
        
        return L!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
        
        if area == true {
            cell?.textLabel?.text = nomi[indexPath.row].unità
            cell?.detailTextLabel?.text = String("\(nomi[indexPath.row].valore) Square Meters")
        }
        if weight == true {
            cell?.textLabel?.text = measureUnit[indexPath.row].misura
            cell?.detailTextLabel?.text = String("\(measureUnit[indexPath.row].attributo) Kg")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     table.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if area == true {
            UserDefaults.standard.setValue(nomi[indexPath.row].unità, forKey: "NomeArea")
            UserDefaults.standard.setValue(nomi[indexPath.row].valore, forKey: "ValoreArea")
            selectedUnit.text = nomi[indexPath.row].unità
        }
        if weight == true {
            UserDefaults.standard.setValue(measureUnit[indexPath.row].misura, forKey: "NomeWeight")
            UserDefaults.standard.setValue(measureUnit[indexPath.row].attributo, forKey: "ValoreWeight")
            selectedUnit.text = measureUnit[indexPath.row].misura
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        table.cellForRow(at: indexPath)?.accessoryType = .none
    }
   
    
    
}
