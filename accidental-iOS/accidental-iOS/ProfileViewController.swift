//
//  ProfileViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit
import Material
import Motion
import SwiftyJSON
import Alamofire
import Alamofire_SwiftyJSON

class ProfileViewController: UIViewController {
    var sentData : JSON?
    @IBOutlet weak var navBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = UserManager.manager.currentUser {
            // Yes they are, continue as normal.
            Alamofire.request("http://:3000/profileGet/\(user.id!)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
                { response in
                    print(response.result.value!)
                    print(response.result.value![0]["organization"].isEmpty)
                    if response.result.value![0]["organization"] == ""{
                        self.navBar.title = "Accidental"
                    } else {
                        self.navBar.title = ("\(response.result.value![0]["organization"])")
                    }
                    
            }
        } else {
            // No, a user is not logged in. Present our login flow.
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
            self.present(viewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
