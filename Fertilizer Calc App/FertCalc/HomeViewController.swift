//
//  HomeViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 13/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    
    
    
    //MARK: Lifecycle
    
    
    func getTheUnit() {
        if UserDefaults.standard.object(forKey: "NomeArea") == nil {
            areaUnit.text = String("Area Unit: Hectare")
        }else{
            let au = UserDefaults.standard.object(forKey: "NomeArea") as? String
            areaUnit.text = String("Area Unit: \(au!)")
        }
        if UserDefaults.standard.object(forKey: "NomeWeight") == nil {
            weightUnit.text = String("Fertilizer Unit: Kg")
            segment.setTitle("Kg", forSegmentAt: 3)
        }else{
            let wu = UserDefaults.standard.object(forKey: "NomeWeight") as? String
            weightUnit.text = String("Fertilizer Unit: \(wu!)")
            segment.setTitle(wu, forSegmentAt: 3)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        getTheUnit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    
    //MARK: Connection
    
    @IBOutlet weak var one: RoundButton!
    
    @IBOutlet weak var two: RoundButton!
    
    @IBOutlet weak var three: RoundButton!
    
    @IBOutlet weak var areaUnit: UILabel!
    
    @IBOutlet weak var weightUnit: UILabel!
    
    
    
    
    @IBOutlet weak var nLabel: UILabel!
    
    @IBOutlet weak var pLabel: UILabel!
    
    @IBOutlet weak var kLabel: UILabel!
    
    @IBOutlet weak var weightlabel: UILabel!
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    
    
    //MARK: Action Button
    
    
    @IBAction func mySegmentControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            segment.selectedSegmentTintColor = UIColor.systemTeal
        case 1:
            segment.selectedSegmentTintColor = UIColor.orange
        case 2:
            segment.selectedSegmentTintColor = UIColor.yellow
        case 3:
            segment.selectedSegmentTintColor = UIColor.systemBlue
            
        default:
            break
        }
        
        
    }
    
    
    
    
    
    @IBAction func Onebutton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
        
        if nLabel.text == "N Unit" {
            nLabel.text = "1"
        }else{
            nLabel.text = String("\(nLabel.text!)1")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "1"
            }else{
                pLabel.text = String("\(pLabel.text!)1")
            }
        }
        
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "1"
            }else{
                kLabel.text = String("\(kLabel.text!)1")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)1")
        }
        
        
    }
    
    @IBAction func twoButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "2"
            }else{
                nLabel.text = String("\(nLabel.text!)2")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "2"
            }else{
                pLabel.text = String("\(pLabel.text!)2")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "2"
            }else{
                kLabel.text = String("\(kLabel.text!)2")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)2")
        }
    }
    
    @IBAction func threeButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "3"
            }else{
                nLabel.text = String("\(nLabel.text!)3")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "3"
            }else{
                pLabel.text = String("\(pLabel.text!)3")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "3"
            }else{
                kLabel.text = String("\(kLabel.text!)3")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)3")
        }
    }
    
    @IBAction func fourButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "4"
            }else{
                nLabel.text = String("\(nLabel.text!)4")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "4"
            }else{
                pLabel.text = String("\(pLabel.text!)4")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "4"
            }else{
                kLabel.text = String("\(kLabel.text!)4")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)4")
        }
        
    }
    
    @IBAction func fiveButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "5"
            }else{
                nLabel.text = String("\(nLabel.text!)5")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "5"
            }else{
                pLabel.text = String("\(pLabel.text!)5")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "5"
            }else{
                kLabel.text = String("\(kLabel.text!)5")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)5")
        }
    }
    
    @IBAction func sixButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "6"
            }else{
                nLabel.text = String("\(nLabel.text!)6")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "6"
            }else{
                pLabel.text = String("\(pLabel.text!)6")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "6"
            }else{
                kLabel.text = String("\(kLabel.text!)6")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)6")
        }
        
    }
    
    @IBAction func sevenButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "7"
            }else{
                nLabel.text = String("\(nLabel.text!)7")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "7"
            }else{
                pLabel.text = String("\(pLabel.text!)7")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "7"
            }else{
                kLabel.text = String("\(kLabel.text!)7")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)7")
        }
        
    }
    
    @IBAction func eightButton(_ sender: RoundButton) {
    
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "8"
            }else{
                nLabel.text = String("\(nLabel.text!)8")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "8"
            }else{
                pLabel.text = String("\(pLabel.text!)8")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "8"
            }else{
                kLabel.text = String("\(kLabel.text!)8")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)8")
        }
    
    }
    
    @IBAction func nineButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "9"
            }else{
                nLabel.text = String("\(nLabel.text!)9")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "9"
            }else{
                pLabel.text = String("\(pLabel.text!)9")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "9"
            }else{
                kLabel.text = String("\(kLabel.text!)9")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)9")
        }
        
    }
    
    @IBAction func zeroButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "0"
            }else{
                nLabel.text = String("\(nLabel.text!)0")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            if pLabel.text == "P Unit" {
                pLabel.text = "0"
            }else{
                pLabel.text = String("\(pLabel.text!)0")
            }
        }
     
        if segment.selectedSegmentIndex == 2 {
            if kLabel.text == "K Unit" {
                kLabel.text = "0"
            }else{
                kLabel.text = String("\(kLabel.text!)0")
            }
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!)0")
        }
    }
    
    @IBAction func cancelButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            nLabel.text = String("\(nLabel.text!.dropLast())")
                
        }
        
        if segment.selectedSegmentIndex == 1 {
            
            pLabel.text = String("\(pLabel.text!.dropLast())")
            
        }
     
        if segment.selectedSegmentIndex == 2 {
            
            kLabel.text = String("\(kLabel.text!.dropLast())")
            
        }
        
        if segment.selectedSegmentIndex == 3 {
            
            weightlabel.text = String("\(weightlabel.text!.dropLast())")
        }
    }
    
    
    //MARK: tableview Settings
    /*
    var azoto: Int
    var fosforo: Int
    var potassio: Int
     */
 

     
    
    
    //MARK: result Button action
    
    @IBAction func equalsTapped(_ sender: RoundButton) {
        
        let areaUnit = UserDefaults.standard.object(forKey: "ValoreArea") as? String
        let weightUnit = UserDefaults.standard.object(forKey: "ValoreWeight") as? String
        
        if areaUnit != nil && weightUnit != nil {
            
            let n: String = nLabel.text ?? "0"
            let p: String = pLabel.text ?? "0"
            let k: String = kLabel.text ?? "0"
            let kg: String = weightlabel.text ?? "0"
            
            let partial = (Double(n)!/100)
            let nextPartial = partial * Double(kg)!
            let postPartial = nextPartial * (Double(areaUnit!)!/10000)
            
        }
        
        
        
        
    }
    
    
    
    
    
}
