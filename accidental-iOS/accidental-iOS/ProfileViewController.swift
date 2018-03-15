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


    



class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var sentData : JSON?
    
    
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationItem!

   var cars = [car]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let url = URL(string: cars[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")
        cell?.textLabel?.text = "\(cars[indexPath.row].model.uppercased()), \(cars[indexPath.row].make.uppercased())"
        cell?.backgroundView? = UIImageView(image: UIImage(data:data!)!)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = UserManager.manager.currentUser{
            print(user, "user in profile view")
            Alamofire.request("http://:3000/carGet/\(user.id!)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
                {response in
                    switch response.result{
                    case .success:
                        self.cars.removeAll()
                        print(response.result.value!, "return value from profile")
                        let data = response.result.value!
                        for i in 0..<data.count{
                            self.cars.append(car(make: data[i]["make"].string!, model: data[i]["model"].string!, swag: 6, image: data[i]["image"].string!))
                            print(data[i]["make"].string!)
                            print(self.cars)
                        }
                        self.tableView.reloadData()
                    case .failure:
                        self.tableView.isHidden = true
                        let controller = UIAlertController(title: "Welcome to Accidental", message: "please register a car to get started", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Got it!", style: .default, handler: nil)
                        controller.addAction(action)
                        self.present(controller, animated: true, completion: nil)
                    }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = UserManager.manager.currentUser {
            if user.organization! == ""{
                self.navBar.title = "Accidental"
            } else {
                self.navBar.title = user.organization!
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

