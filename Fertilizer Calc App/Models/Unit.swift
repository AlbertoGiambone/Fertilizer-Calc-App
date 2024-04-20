//
//  Unit.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 03/03/23.
//

import Foundation


    struct FARM_UNIT {
    
        var UNIT_NAME: String
        var UNIT_VALUE: String
    
        var dict: [String: String] {
            return[
                "UNIT_NAME": UNIT_NAME,
                "UNIT_VALUE": UNIT_VALUE
            ]
        }
    
    }


