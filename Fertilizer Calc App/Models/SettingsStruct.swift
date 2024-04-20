//
//  SettingsStruct.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 24/02/23.
//

import UIKit
import Foundation

struct SettingsArray {
    
    var Logo: UIImage
    var SettingsName: String
    var SettValue: String
    var DisclosureIMG: UIImage
    
    var dict: [String: Any] {
        return[
            "Logo": Logo,
            "SettingsName": SettingsName,
            "SettValue": SettValue,
            "DisclosureIMG": DisclosureIMG
        ]}
    
}
