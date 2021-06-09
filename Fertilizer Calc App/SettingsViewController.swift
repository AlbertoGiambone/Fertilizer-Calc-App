//
//  SettingsViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 31/05/21.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: Connection
    
    @IBOutlet weak var areaButton: UIButton!
    
    @IBOutlet weak var weightButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }
    
    
    
    @IBAction func areaTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "areaEDIT", sender: nil)
    }
    
    @IBAction func weightTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "weightEDIT", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "areaEDIT" {
            let nextVC = segue.destination as! SETareaORweightViewController
            nextVC.area = true
        }
        if segue.identifier == "weightEDIT"{
            let nextVC = segue.destination as! SETareaORweightViewController
            nextVC.weight = true
        }
    }

    
    
}
