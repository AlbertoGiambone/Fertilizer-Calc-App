//
//  SETareaORweightViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 09/06/21.
//

import UIKit
import Firebase

class SETareaORweightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
