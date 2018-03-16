//
//  DetailsViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit
import Material
import Motion
import Alamofire
import Alamofire_SwiftyJSON

class DetailsViewController: UIViewController {
    var damages = [damage]()
    
    @IBOutlet weak var scratchesLabel: UILabel!
    @IBOutlet weak var dentsLabel: UILabel!
    @IBOutlet weak var chipsLabel: UILabel!
    @IBOutlet weak var curbRashLabel: UILabel!
    @IBOutlet weak var damageReportLabel: UILabel!
    
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var carLabel: UILabel!
    var car:car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: (car?.image)!)
        let data = try? Data(contentsOf: url!)
        print(url!)
        carLabel.text = "\(car!.make.uppercased()) \(car!.model.capitalized.uppercased())"
        
        carImage.image = UIImage(data:data!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
            print(self.car!.id, "the car!")
        Alamofire.request("http://:3000/damageGet/\(car!.id)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
            {response in
                print(response, "response from details!!!!!")
                switch response.result{
                case .success:
                    print("nice!")
                case .failure:
                    print("no damage")
                    self.scratchesLabel.isHidden = true
                    self.dentsLabel.isHidden = true
                    self.chipsLabel.isHidden = true
                    self.curbRashLabel.isHidden = true
                    self.damageReportLabel.isHidden = true
                }
        }
        
        
    }

}
