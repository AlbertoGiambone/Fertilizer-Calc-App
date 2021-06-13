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
    
    

    //MARK: var for select TV
    
    var area: Bool?
    var weight: Bool?
    
    
    //MARK: VC Lifecycle
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if area == true {
            
        }
        if weight == true {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //MARK: TV Settings
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if area == true {
            return nomi.count
        }
        if weight == true {
            return measureUnit.count
        }
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
    
    
}
