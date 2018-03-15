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
import FoldingCell


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var sentData : JSON?
    
    
    @IBOutlet weak var tableView: TableView!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    var cars = [car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cars.append(car(make: "Audi", model: "A4", swag: 6))
        cars.append(car(make: "Ford", model: "Mustang", swag: 7))
        cars.append(car(make: "Nissan", model: "Xterra", swag: 100))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        cell?.textLabel?.text = cars[indexPath.row].model.capitalized
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.car = cars[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = UserManager.manager.currentUser {
            print(user)
            // Yes they are, continue as normal.
            Alamofire.request("http://:3000/profileGet/\(user.id!)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
                { response in
                    print(response)
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

