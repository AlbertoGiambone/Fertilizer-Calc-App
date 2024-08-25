//
//  Fertilization.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 05/02/22.
//

import Foundation

struct Fertilization {
    
    var nitrogen: String
    var phosphorus: String
    var potassium: String
    var calcium: String
    var magnesium: String
    var quantity: String
    var date: String
    var UID: String
    var FID: String
    var DID: String
    
    var dict: [String: Any] {
        return [
        
            "nitrogen": nitrogen,
            "phosphorus": phosphorus,
            "potassium": potassium,
            "calcium": calcium,
            "magnesium": magnesium,
            "quantity": quantity,
            "date": date,
            "UID": UID,
            "FID": FID,
            "DID": DID
        
        ]
        
    }
    
    
}
