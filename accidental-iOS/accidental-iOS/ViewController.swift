//
//  ViewController.swift
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
import TOMSMorphingLabel



class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: TOMSMorphingLabel!
   
    
    @IBAction func signupButton(_ sender: Any) {
        print("signup")
        self.performSegue(withIdentifier: "signupSegue", sender: sender)
    }
    @IBAction func loginButton(_ sender: Any) {
        print("login")
        self.performSegue(withIdentifier: "loginSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         mainLabel.animationDuration = 8
//        mainLabel.characterAnimationOffset = 1
//        mainLabel.characterShrinkFactor = 3
        // Do any additional setup after loading the view, typically from a nib.
        
        
         mainLabel.text = "An app for damage recognition"
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
       
       
        mainLabel.text = "Please signup or login to continue"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


