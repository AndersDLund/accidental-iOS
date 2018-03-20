//
//  LoginViewController.swift
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
import StatusProvider

class LoginViewController: UIViewController, StatusController {
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    var responseData : JSON?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginProfileSegue" {
            if let destinationViewController = segue.destination as? ProfileViewController {
                destinationViewController.sentData = (responseData as! JSON)
            }
        }
    }
    
    /// A constant to layout the textFields.
    fileprivate let constant: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.grey.lighten5
        
        
        preparePasswordField()
        prepareEmailField()
//        prepareResignResponderButton()
        
    }
    
    /// Prepares the resign responder button.
//    fileprivate func prepareResignResponderButton() {
//        let btn = RaisedButton(title: "Login", titleColor: Color.blue.base)
//        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
//
//        view.layout(btn).width(100).height(constant).top(650).right(view.frame.width - 150)
//    }
    
    /// Handle the resign responder button.
    @objc
    internal func handleResignResponderButton(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
    }
    
    /// Button Actions
    
    @IBAction func loginButtonPressed(sender: RaisedButton) {
        if emailField.text!.count > 5 {
            
            let params = ["email": emailField.text, "password": passwordField.text]
            
            Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/login", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                {response in
                    print(response)
                    switch response.result {
                    case .success:
                        print("Validated")
                        self.responseData = JSON(parseJSON: response.result.value!)
                        if let jsonData = self.responseData {
                            let userId = jsonData["id"].intValue
                            let userEmail = jsonData["email"].stringValue
                            let fullName = jsonData["full_name"].string ?? "Anders Lund"
                            let userOrg = jsonData["organization"].string ?? "Galvanize"
                            let user = User(id: userId, email: userEmail, fullName: fullName, organization: userOrg)
                            UserManager.manager.currentUser = user
                            self.navigationController?.dismiss(animated: true, completion: nil)
                        }
                        
                        
                    case .failure(let error):
                        print(error)
                    }
            }
        } else {
            let controller = UIAlertController(title: "Hold Up", message: "Please fill out the required infromation", preferredStyle: .alert)
            let action = UIAlertAction(title: "Thank you!", style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension LoginViewController {
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        
        //        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
//        emailField.placeholderAnimation = .hidden
        
        // Set the colors for the emailField, different from the defaults.
//                emailField.placeholderNormalColor = Color.amber.darken4
                emailField.placeholderNormalColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        // Set the text inset
        //        emailField.textInset = 20
        
        //        let leftView = UIImageView()
        //        leftView.image = Icon.cm.audio
        //        emailField.leftView = leftView
        
        view.layout(emailField).left(20).right(20).top(300)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = ErrorTextField()
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordField.resignFirstResponder()
            self.view.endEditing(true)
        default:
            print("How in the hell did we reach this case?")
        }
        
        return true
    }
}
