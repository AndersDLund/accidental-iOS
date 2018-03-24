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
import Material
import Motion
import PKHUD


class RegisterViewController: UIViewController, UITextFieldDelegate {
    fileprivate var plateField: TextField!
    var user = UserManager.manager.currentUser
    
    @IBOutlet weak var makePicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    
    public var makeModelDict = [String: [String]]()
    public var modelIdDict = [String: Int]()
    
    var carMakeArray = ["Select Make"]
    var carModelArray = ["Select Model"]
    
    
    var selectedModel: String = ""

    
    var currentMake: String = ""
    var currentModel: String = ""
    
    @IBAction func registerCarButton(_ sender: Any) {
        HUD.show(.progress)
        let params = ["model_id": modelIdDict[selectedModel]!, "plate": plateField.text!] as [String : Any]
        Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/carRegister/\(String(describing: user!.id!))", method: .post, parameters: params, encoding: JSONEncoding.default).responseSwiftyJSON
            {response in
                switch response.result {
                case .success:
                    print("nice")
                    
                case .failure:
                    print("boo")
                }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        preparePlateField()
        self.makePicker.delegate = self
        self.makePicker.dataSource = self
        self.modelPicker.delegate = self
        self.modelPicker.dataSource = self
        // Do any additional setup after loading the view.
        self.modelPicker.isHidden = true
        print(carMakeArray, "from didload")
         plateField.isHidden = true
        self.plateField.delegate = self
       
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
                        self.modelIdDict[data[i]["model"].string!] = data[i]["car_model_id"].int!
                        
                        
//                        print(data[i])
                        if !self.makeModelDict.keys.contains(data[i]["make"].string!){
                            self.makeModelDict[data[i]["make"].string!] = []
                            self.carMakeArray.append(data[i]["make"].string!)
                            self.makePicker.reloadAllComponents()
                        }
                        for var (key, value) in self.makeModelDict {
                            if !value.contains(data[i]["model"].string!) && data[i]["make"].string! == key{
                               
                                self.makeModelDict[key]!.append(data[i]["model"].string!)
                                
                                
                                
                            }
                        }
                        
                        }
                    
                    print(self.modelIdDict)
                    
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
            
            if selection != "Select Make"{
                self.carModelArray.removeAll()
                self.carModelArray.append("Select Model")
                self.modelPicker.isHidden = false
                 self.plateField.isHidden = false
            for i in 0..<makeModelDict[currentMake]!.count{
                self.carModelArray.append(makeModelDict[currentMake]![i])
                self.modelPicker.reloadAllComponents()
                }
            } else if selection == "Select Make"{
                self.modelPicker.isHidden = true
                 self.plateField.isHidden = true
            }
            
            
        default:
            currentModel = carModelArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case makePicker:
            print(carMakeArray[row])
            return carMakeArray[row]
        default:
            print(carModelArray[row])
            self.selectedModel = carModelArray[row]
            return carModelArray[row]
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

extension RegisterViewController {
    fileprivate func preparePlateField() {
        plateField = ErrorTextField()
        plateField.placeholder = "License Plate #"
        plateField.isClearIconButtonEnabled = true
        plateField.isPlaceholderUppercasedWhenEditing = true
//        plateField.placeholderNormalColor = Color.pink.base
     
        
        view.layout(plateField).left(20).right(20).top(450)
    }
}


