//
//  SettingsViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 31/05/21.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Connection
    
    @IBOutlet weak var areaTexField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    
    
    
    var areapicker: UIPickerView?
    var weightPicker: UIPickerView?
    
    
    
    @objc func areaPickerDone() {
        areaTexField.resignFirstResponder()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        areapicker = UIPickerView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        areaTexField.inputView = areapicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.areaPickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
 toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        areaTexField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
        
        areapicker?.delegate = self
        areapicker?.dataSource = self
        weightPicker?.delegate = self
        weightPicker?.dataSource = self
        
        areapicker = UIPickerView()
        areaTexField.inputView = areapicker
        areapicker?.backgroundColor = .white
        
        weightPicker = UIPickerView()
        weightTextField.inputView = weightPicker
        weightPicker?.backgroundColor = .white
    }
    

    
    var someAreaValue = ["Square Meters", "Square Feet", "Acre", "Hecteare"]
    var someWeightValue = ["Kg", "lb", "Ton"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var y: Int?
        
        if areaTexField.isEditing {
        
         y = someAreaValue.count
        
        }
        if weightTextField.isEditing {
            y = someWeightValue.count
        }
        return y!
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var r: String?
        
        if areaTexField.isEditing {
            r = someAreaValue[row]
        }
        if weightTextField.isEditing {
            r = someWeightValue[row]
        }
        
        return r
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        if areaTexField.isEditing {
            label.text = someAreaValue[row]
            label.textColor = .black
            label.textAlignment = .center
        }
        if weightTextField.isEditing {
            label.text = someWeightValue[row]
            label.textColor = .black
            label.textAlignment = .center
        }
        
        return label
    }
    
    
}
