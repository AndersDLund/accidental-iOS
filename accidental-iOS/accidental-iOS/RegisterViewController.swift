//
//  RegisterViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/16/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var makePicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    
    var carMakeArray = ["Select Make"]
    var carModelArray = ["Select Model", "TSX", "Civic", "Model S"]

    
    var currentMake: String = ""
    var currentModel: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.makePicker.delegate = self
        self.makePicker.dataSource = self
        self.modelPicker.delegate = self
        self.modelPicker.dataSource = self
        // Do any additional setup after loading the view.
        self.modelPicker.isHidden = true
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/carGetAll/", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
            {resposne in
                switch resposne.result {
                case .success:
                    print("nice!")
                    let data = resposne.result.value!
                    for i in 0..<data.count{
                        print(data[i])
                        self.carMakeArray.append(data[i]["make"].string!)
                        print(self.carMakeArray)
                    }
                case .failure:
                    print("boo!")
                }
        }
    }
    
}

extension RegisterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case makePicker:
            return carMakeArray.count
        default:
            return carModelArray.count
        }
    }
}

extension RegisterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case makePicker:
            let selection = carMakeArray[row]
            currentMake = carMakeArray[row]
            self.modelPicker.isHidden = selection == "Select Make"
        default:
            currentModel = carModelArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case makePicker:
            return carMakeArray[row]
        default:
            return carModelArray[row]
        }
    }
    
}
