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
import LTMorphingLabel
import TOMSMorphingLabel
import StatusProvider

class DetailsViewController: UIViewController, StatusController {
    var damages = [damage]()
    
    @IBOutlet weak var scratchesLabel: TOMSMorphingLabel!
    @IBOutlet weak var dentsLabel: TOMSMorphingLabel!
    @IBOutlet weak var chipsLabel: TOMSMorphingLabel!
    @IBOutlet weak var curbRashLabel: TOMSMorphingLabel!
    @IBOutlet weak var damageReportLabel: TOMSMorphingLabel!
    
    var scratchCount = 0 //1
    var dentCount = 0 //2
    var chipCount = 0 //3
    var curbCount = 0 //4
    
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
        
        
        
      
        
        
        
        self.curbRashLabel.text = "Curb Rash: \(0)"
        self.chipsLabel.text = "Chips: \(0)"
        self.dentsLabel.text = "Dents: \(0)"
        self.scratchesLabel.text = "scratches: \(0)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let status = Status(title: "🙅‍♀️No Damage Recorded🙅‍♀️", description: "Keep up the Good Work!", image: UIImage(named: "placeholder")) {
            self.hideStatus()
        }
        
        
            print(self.car!.id, "the car!")
        Alamofire.request("http://:3000/damageGet/\(car!.id)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
            {response in
                print(response, "response from details!!!!!")
                switch response.result{
                case .success:
                    print("you got DAMAGE!")
                    let data = response.result.value!
                    for i in 0..<data.count{
                        self.damages.append(damage(id: data[i]["damage_type_id"].int!))
                        switch data[i]["damage_type_id"] {
                        case 1:
                            self.scratchCount += 1
                            print(self.scratchCount, "scratches")
                            self.scratchesLabel.text = "scratches: \(self.scratchCount)"
                        case 2:
                            self.dentCount += 1
                            print(self.dentCount, "dents")
                            self.dentsLabel.text = "Dents: \(self.dentCount)"
                        case 3:
                            self.chipCount += 1
                            print(self.chipCount, "chips")
                            self.chipsLabel.text = "Chips: \(self.chipCount)"
                        case 4:
                            self.curbCount += 1
                            print(self.curbCount)
                            self.curbRashLabel.text = "Curb Rash: \(self.curbCount)"
                        default:
                            self.curbRashLabel.text = "Curb Rash: \(0)"
                            self.chipsLabel.text = "Chips: \(0)"
                            self.dentsLabel.text = "Dents: \(0)"
                            self.scratchesLabel.text = "scratches: \(0)"
                        }
                    }
                case .failure:
                    print("no damage")
                    self.scratchesLabel.isHidden = true
                    self.dentsLabel.isHidden = true
                    self.chipsLabel.isHidden = true
                    self.curbRashLabel.isHidden = true
                    self.damageReportLabel.isHidden = true
                    self.show(status:status)
                }
        }
        
        
    }

}
