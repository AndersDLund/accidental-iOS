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

class SignupViewController: UIViewController {
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
    @objc
    internal func handleResignResponderButton(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        nameField?.resignFirstResponder()
        organizationField?.resignFirstResponder()

    }
    
    /// Button Actions
    
    @IBAction func signupButtonPressed(sender: RaisedButton) {
        if emailField.text!.count > 5 && passwordField.text!.count > 8 && nameField.text!.count > 0{
            let params = ["full_name": nameField.text, "email": emailField.text, "organization": organizationField.text, "password": passwordField.text]
            
            Alamofire.request("http://localhost:3000/signup", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                {response in
                    print(response)
                    // Take response and pass data to user object.
                    // For now, just set UserDefaults.
                    
                    

                    self.navigationController?.dismiss(animated: true, completion: nil)
            }
        } else {
        let controller = UIAlertController(title: "Hold Up", message: "Please fill out the required infromation", preferredStyle: .alert)
        let action = UIAlertAction(title: "Thank you!", style: .default, handler: nil)
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
        }
    }
}


extension SignupViewController {
   
    
    fileprivate func prepareFullName(){
        nameField = ErrorTextField()
        nameField.placeholder = "Name"
        
        nameField.isClearIconButtonEnabled = true
        nameField.delegate = self
        nameField.isPlaceholderUppercasedWhenEditing = true
        
        view.layout(nameField).left(20).right(20).top(100)
    }
    
    
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        nameField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        
        // Set the colors for the emailField, different from the defaults.
//                emailField.placeholderNormalColor = Color.amber.darken4
                emailField.placeholderNormalColor =               Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        // Set the text inset
//                emailField.textInset = 20
        
        view.layout(emailField).left(20).right(20).top(200)
    }
    
    fileprivate func prepareOrganizationField() {
        organizationField = TextField()
        organizationField.placeholder = "Organization"
        organizationField.isClearIconButtonEnabled = true
        organizationField.delegate = self
        organizationField.isPlaceholderUppercasedWhenEditing = true
        
        view.layout(organizationField).left(20).right(20).top(300)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}