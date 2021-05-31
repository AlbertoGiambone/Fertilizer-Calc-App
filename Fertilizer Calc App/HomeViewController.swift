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
        
        
    }
    
    @IBAction func twoButton(_ sender: RoundButton) {
        
        if segment.selectedSegmentIndex == 0 {
            
            if nLabel.text == "N Unit" {
                nLabel.text = "1"
            }else{
                nLabel.text = String("\(nLabel.text!)2")
            }
        }
        
        if segment.selectedSegmentIndex == 1 {
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}
