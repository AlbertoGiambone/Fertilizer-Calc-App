//
//  RCPaywall.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 25/06/24.
//

import UIKit
import StoreKit
import RevenueCat
import RevenueCatUI

class RCPaywall: UIViewController, PaywallViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
                let controller = PaywallViewController()
                controller.delegate = self

                present(controller, animated: true, completion: nil)
            

    }
    
}

extension ViewController: PaywallViewControllerDelegate {
    
    func paywallViewController(_ controller: PaywallViewController,
                               didFinishPurchasingWith customerInfo: CustomerInfo) {
        
    }
}
