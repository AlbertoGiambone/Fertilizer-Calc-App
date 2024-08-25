//
//  PayWall.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 17/03/23.
//

import UIKit
import StoreKit
import RevenueCat

class PayWall: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //MARK: Connection
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var dismissPW: UIButton!
    
    
    var offering: Offering?
    
    var dismissing = false
    
    //MARK: LifeCycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        if dismissing == false {
            dismissPW.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(red: 60/255, green: 179/255, blue: 113/256, alpha: 1.0)
        overrideUserInterfaceStyle = .light

        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.offering = offerings?.current
         
            self.table.reloadData()
        }
        
        
        
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 10
        //table.layer.borderWidth = 2
        //table.layer.borderColor = CGColor(red: 60/255, green: 179/255, blue: 113/256, alpha: 1.0)
    }
    
    //MARK: Tableview Func
    
    
    //func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //    return "Unlock Custom Area/Weight Unit"
    //}
    
    var RevenueOffer = ["Month", "Year"]
    //var RevenueDescription = "Pro Version: Custom Area unit, Custom Weight unit, and Field manager. Field manager can help you keep control of the amount of fertilizer you already distributed by setting element limit and recod every fertilization."
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.offering?.availablePackages.count) ?? 0
    }
    
    var cex = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! PayWallCell
        
        if let package = self.offering?.availablePackages[indexPath.row] {
            //cell.RevenueCatItem.text = String(package.storeProduct.localizedTitle)
            
            cex += 1
            var item = String(RevenueOffer[indexPath.row])
            cell.RevenueCatItem.text = item
            print("ITEM ON TV: \(item)")
            cell.price.text = String("\(package.localizedPriceString)")
            
            if cex == 1 {
                cell.layer.borderWidth = 0
                cell.cellBackGround.backgroundColor = .clear
            }else{
                
                cell.layer.cornerRadius = 10
                //cell.layer.borderWidth = 2
                cell.layer.backgroundColor = CGColor(red: 60/255, green: 179/255, blue: 113/256, alpha: 1.0)
            }
            //Dark Mode Color Control
            if traitCollection.userInterfaceStyle == .dark {
                cell.RevenueCatItem.textColor = .white
                cell.price.textColor = .white
            }else{
                cell.RevenueCatItem.textColor = .black
                cell.price.textColor = .black
            }
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        if let package = self.offering?.availablePackages[indexPath.row] {
            Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                if let error = error {
                    
                    let settError = UIAlertAction(title: "Dismiss", style: .cancel)
                    let Error = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    Error.addAction(settError)
                    self.present(Error, animated: true)
                    //self.present(UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert), animated: true)
                }else{
                    if customerInfo?.entitlements[Costants.entitlementID]?.isActive == true {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
            
    }
    

    //MARK: Action
    
    @IBAction func TermsOfUseTApped(_ sender: UIButton) {
        guard let settingsUrl = URL(string:"https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") else {
                return
            }
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    
    
    
    @IBAction func PrivacyPolicyTapped(_ sender: UIButton) {
        guard let settingsUrl = URL(string:"https://termsfeed.com/privacy-policy/e7ec1c291bd325a5097793e36df3e79d") else {
                return
            }
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        
        }
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        
        let nextVC = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "calc") as! CalcVC
        nextVC.modalPresentationStyle = .automatic
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
    }
    
    
    
    
    
    







/*
 
 if let package = self.offering?.availablePackages[indexPath.row] {
     Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
         if let error = error {
             
             let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert), animated: true) { (controller: UIAlertController!) in
                 print("Getting the error!")
                 
             }
             let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel) { (action: UIAlertAction!) in
                 print("Error Dismissed!")
             }
             alert.addAction(dismissButton)
             self.present(alert, animated: true)
             //self.present(UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert), animated: true)
         }else{
             if customerInfo?.entitlements[Costants.entitlementID]?.isActive == true {
                 self.dismiss(animated: true)
             }
         }
         
     }
 }
 
 */
