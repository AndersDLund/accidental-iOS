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
import StatusProvider
import PKHUD

class CarCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var carLabel: UILabel!
}


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StatusController {
      @IBOutlet weak var tableView: UITableView!
    

    
    @IBAction func logoutClicked(_ sender: Any) {
        UserManager.manager.currentUser = nil
//        self.reloadInputViews()
         self.performSegue(withIdentifier: "logoutSegue", sender: sender)
    
    }
    
    
    var sentData : JSON?
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "profileRegisterSegue", sender: sender)
    }
    
    
  
    
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
        
        
        let rect = CGRect(origin: CGPoint(x: 12,y :12), size: CGSize(width: 300, height: 100))
        let url = URL(string: cars[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! CarCell
        cell.carLabel?.textColor = .white
        cell.carLabel?.text = "\(cars[indexPath.row].model.uppercased()) ~ \(cars[indexPath.row].plate.uppercased())"
        cell.carImageView.image = UIImage(data:data!)
     

//        cell?.backgroundView!.addSubview(imageView)
        return cell
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
        
        if let user = UserManager.manager.currentUser {
            Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/carGet/\(user.id!)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
                {response in
                    switch response.result{
                    case .success:
                        self.cars.removeAll()
                        let data = response.result.value!
                        for i in 0..<data.count{
                            self.cars.append(car(plate: data[i]["plate"].string!, car_id: data[i]["car_id"].int!, make: data[i]["make"].string!, model: data[i]["model"].string!, image: data[i]["image"].string!, user_id: data[i]["user_id"].int!))
                            print(data[i], "looking for the right id!!!!!!!")
                            self.hideStatus()
                           HUD.hide(animated: true)
                        }
                        self.tableView.reloadData()
                    case .failure:
                        self.tableView.isHidden = true
                        let controller = UIAlertController(title: "Welcome to Accidental, \(user.fullName!)", message: "please register a car to get started", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Got it!", style: .default, handler: nil)
                        controller.addAction(action)
                        self.present(controller, animated: true, completion: nil)
                        
                        HUD.hide(animated: true)
                    }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = UserManager.manager.currentUser {
            if user.organization == "" {
                self.navBar.title = user.fullName!
            } else {
                 self.navBar.title = user.fullName!
            }
            
            }
            
            
            
            
        else {
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

