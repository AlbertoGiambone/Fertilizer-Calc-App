//
//  iPadPayWall.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 08/05/24.
//

import UIKit
import StoreKit
import RevenueCat

class iPadPayWall: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var offering: Offering?
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.7804335356, blue: 0.5362561345, alpha: 1)
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.offering?.availablePackages.count) ?? 0
    }
    
    
    var cex = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! iPadPayWallCell
        
        if let package = self.offering?.availablePackages[indexPath.row] {
            //cell.RevenueCatItem.text = String(package.storeProduct.localizedTitle)
            
            cex += 1
            cell.RevenueCatItem.text = RevenueOffer[indexPath.row]
            
            cell.price.text = String("\(package.localizedPriceString)")
            
            if cex == 1 {
                cell.layer.borderWidth = 0
                cell.back.backgroundColor = .clear
            }else{
                
                cell.layer.cornerRadius = 10
                //cell.layer.borderWidth = 2
                cell.layer.backgroundColor = CGColor(red: 60/255, green: 179/255, blue: 113/256, alpha: 1.0)
            }
            
            //cell.layer.cornerRadius = 10
            //cell.layer.borderWidth = 2
            //cell.layer.backgroundColor = CGColor(red: 60/255, green: 179/255, blue: 113/256, alpha: 1.0)
            
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
    
    @IBAction func termsOfUseTapped(_ sender: Any) {
        
        guard let settingsUrl = URL(string:"https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") else {
                return
            }
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        
    }
    
    
    @IBAction func privacyPolicyTapped(_ sender: Any) {
        
        guard let settingsUrl = URL(string:"https://termsfeed.com/privacy-policy/e7ec1c291bd325a5097793e36df3e79d") else {
                return
            }
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func unwind(_ sender: UIButton) {
        
        performSegue(withIdentifier: "unwindToViewController", sender: nil)
        //performSegue(withIdentifier: "unwindToViewController", sender: self)
        print("segue tapped!")
    }
    
    
    

    

    
    
}
