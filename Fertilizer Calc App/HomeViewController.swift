//
//  HomeViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 13/04/21.
//

import UIKit
import Firebase
import FirebaseUI

class HomeViewController: UIViewController, FUIAuthDelegate {

    
    func showLoginVC() {
        let autUI = FUIAuth.defaultAuthUI()
        let providers = [FUIOAuth.appleAuthProvider()]
        
        autUI?.providers = providers
        
        let autViewController = autUI!.authViewController()
        autViewController.modalPresentationStyle = .fullScreen
        self.present(autViewController, animated: true, completion: nil)
    }
    
    func showUserInfo(user:User) {
        
        print("USER.UID: \(user.uid)")
        UserDefaults.standard.setValue(user.uid, forKey: "userInfo")
    }
    
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let user = authDataResult?.user {
            print("GREAT!!! You Are Logged in as \(user.uid)")
            UserDefaults.standard.setValue(user.uid, forKey: "userInfo")
        }
    }
    
    
    
    //MARK: Lifecycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.showUserInfo(user:user)
            } else {
                self.showLoginVC()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }
    
    //MARK: Connection
    
    @IBOutlet weak var one: RoundButton!
    
    @IBOutlet weak var two: RoundButton!
    
    @IBOutlet weak var three: RoundButton!
    
   
    
    
    
    
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
    
    
    
    
    
    
    
    
    
    
}
