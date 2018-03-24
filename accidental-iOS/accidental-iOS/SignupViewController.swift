//
//  SignupViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/13/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit
import Material
import Motion
import SwiftyJSON
import Alamofire
import PKHUD

class SignupViewController: UIViewController  {
    var responseData : JSON?
    
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    fileprivate var nameField: TextField!
    fileprivate var organizationField: TextField!
    
    @IBOutlet weak var loginOutlet: RaisedButton!
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.lighten5
        
        prepareFullName()
        preparePasswordField()
        prepareOrganizationField()
        prepareEmailField()
       
    }
    
    
    /// Handle the resign responder button.
//    @objc
//    internal func handleResignResponderButton(button: UIButton) {
//        emailField?.resignFirstResponder()
//        passwordField?.resignFirstResponder()
//        nameField?.resignFirstResponder()
//        organizationField?.resignFirstResponder()
//
//    }
    
    /// Button Actions
    
    @IBAction func signupButtonPressed(sender: RaisedButton) {
        HUD.show(.progress)
        if emailField.text!.count > 5 && passwordField.text!.count > 8 && nameField.text!.count > 0{
            
            let params = ["full_name": nameField.text, "email": emailField.text, "organization": organizationField.text, "password": passwordField.text]
            
            Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/signup", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                {response in
                    print(response.result.value!)
                    switch response.result {
                    case .success:
                        print("nice")
                        
                        if response.result.value! == "Email already exists"{
                            HUD.flash(.error, delay: 1.0)
                            let controller = UIAlertController(title: "Hold Up", message: "That email already exists, proceed to login", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Got it!", style: .default, handler: nil)
                            controller.addAction(action)
                            self.present(controller, animated: true, completion: nil)
                            
                        } else if response.result.value! != "Email already exists"{
                         self.responseData = JSON(parseJSON: response.result.value!)
                        print(self.responseData![0], "responseeeeeeeeeee")
                            if let jsonData = self.responseData?[0] {
                                print(jsonData, "jsondata");
                                let userId = jsonData["id"].intValue
                                let userEmail = jsonData["email"].stringValue
                                print(userEmail)
                                let fullName = jsonData["full_name"].stringValue ?? "User"
                                let userOrg = jsonData["organization"].stringValue ?? fullName
                                let user = User(id: userId, email: userEmail, fullName: fullName, organization: userOrg)
                                UserManager.manager.currentUser = user
                                self.navigationController?.dismiss(animated: true, completion: nil)
                            }
                        }
            
                        
                    case .failure:
                        print("boo")
                    }

                    
            }
        } else {
            HUD.flash(.error, delay: 1.0)
        }
    }
}


extension SignupViewController {
   
    
    fileprivate func prepareFullName(){
        nameField = TextField()
        nameField.placeholder = "Name"
        
        nameField.isClearIconButtonEnabled = true
        nameField.delegate = self
        nameField.isPlaceholderUppercasedWhenEditing = true
        nameField.delegate = self
        
        view.layout(nameField).left(20).right(20).top(100)
    }
    
    
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.delegate = self
        
        // Set the colors for the emailField, different from the defaults.
//                emailField.placeholderNormalColor = Color.amber.darken4
//                emailField.placeholderNormalColor =               Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        // Set the text inset
//                emailField.textInset = 20
        
        view.layout(emailField).left(20).right(20).top(200)
    }
    
    fileprivate func prepareOrganizationField() {
        organizationField = TextField()
        organizationField.placeholder = "Organization (leave blank for personal accounts)"
        organizationField.isClearIconButtonEnabled = true
        organizationField.delegate = self
        organizationField.isPlaceholderUppercasedWhenEditing = true
        organizationField.delegate = self
        
        view.layout(organizationField).left(20).right(20).top(300)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        passwordField.delegate = self
        
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(passwordField).left(20).right(20).top(400)
    }
}


extension SignupViewController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        (textField as? ErrorTextField)?.isErrorRevealed = true
//        return true
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}




