//
//  Field.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 05/02/22.
//

import Foundation

struct FarmField {
    
    var name: String
    var area: String
    var growing: String
    var nitrogenLimit: String
    var phosphorusLimit: String
    var potassiumLimit: String
    var calciumLimit: String
    var magnesiumLimit: String
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
        return[
        "name": name,
        "area": area,
        "nitrogenLimit": nitrogenLimit,
        "phosphorusLimit": phosphorusLimit,
        "potassiumLimit": potassiumLimit,
        "calciumLimit": calciumLimit,
        "magnesiumLimit": magnesiumLimit,
        "UID": UID,
        "DID": DID
        
    ]}
    

}
