//
//  DetailsViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/19/18.
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
import PKHUD
import VerticalSlider

class DetailsViewController: UIViewController, StatusController {
    var damages = [damage]()
    var car:car?
   
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        HUD.show(.progress)
        Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/carDelete/\(car!.car_id)", method: .delete, encoding: JSONEncoding.default).responseString
            {response in
                print(response.result)
                
                 self.performSegue(withIdentifier: "deleteSegue", sender: sender)
        }
    }
    
    
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var damageReportLabel: TOMSMorphingLabel!
    
    @IBOutlet weak var scratchLabel: TOMSMorphingLabel!
    @IBOutlet weak var dentLabel: TOMSMorphingLabel!
    @IBOutlet weak var chipLabel: TOMSMorphingLabel!
    @IBOutlet weak var curbLabel: TOMSMorphingLabel!
    
    @IBOutlet weak var scratchButton: UIButton!
    @IBOutlet weak var dentButton: UIButton!
    @IBOutlet weak var chipButton: UIButton!
    @IBOutlet weak var curbButton: UIButton!
    
    @IBOutlet weak var scratchSlider: UISlider!
    @IBOutlet weak var dentSlider: UISlider!
    @IBOutlet weak var chipSlider: UISlider!
    @IBOutlet weak var curbSlider: UISlider!
    
    var scratchCount = 0 //1
    var dentCount = 0 //2
    var chipCount = 0 //3
    var curbCount = 0 //4
    
    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InspectViewController {
            destination.car = car
        }
    }
    
    @IBAction func scratchSliderAction(_ sender: Any) {
        scratchLabel.text = "\(Int(scratchSlider.value))"
    }
    @IBAction func dentSliderAction(_ sender: Any) {
        dentLabel.text = "\(Int(dentSlider.value))"
    }
    @IBAction func chipSliderAction(_ sender: Any) {
        chipLabel.text = "\(Int(chipSlider.value))"
    }
    @IBAction func curbSliderAction(_ sender: Any) {
        curbLabel.text = "\(Int(curbSlider.value))"
    }
    
    
    

    
    
    @IBAction func scratchButtonClicked(_ sender: Any) {
        scratchSlider.isHidden = false
        dentSlider.isHidden = true
        chipSlider.isHidden = true
        curbSlider.isHidden = true
        
        
        
    }

    @IBAction func dentButtonClicked(_ sender: Any) {
        dentSlider.isHidden = false
        scratchSlider.isHidden = true
        chipSlider.isHidden = true
        curbSlider.isHidden = true
        


    }
    
    
    @IBAction func chipButtonClicked(_ sender: Any) {
        chipSlider.isHidden = false
        scratchSlider.isHidden = true
        dentSlider.isHidden = true
        curbSlider.isHidden = true
        
   
        
    }
    
    @IBAction func curbButtonClicked(_ sender: Any) {
        curbSlider.isHidden = false
        scratchSlider.isHidden = true
        dentSlider.isHidden = true
        chipSlider.isHidden = true
        
        
      
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scratchSlider.isHidden = true
        dentSlider.isHidden = true
        chipSlider.isHidden = true
        curbSlider.isHidden = true
        
        
        
        let url = URL(string: (car?.image)!)
        let data = try? Data(contentsOf: url!)
        print(url!)
        carLabel.text = "\(car!.make.uppercased()) \(car!.model.uppercased())"
        
        carImage.image = UIImage(data:data!)
        
        
        self.scratchButton.setTitle("Scratchs:", for: .normal)
        self.dentButton.setTitle("Dents:", for: .normal)
        self.chipButton.setTitle("Chips:", for: .normal)
        self.curbButton.setTitle("Curb Rash:", for: .normal)
        
        self.scratchLabel.text = "\(0)"
        self.dentLabel.text = "\(0)"
        self.chipLabel.text = "\(0)"
        self.curbLabel.text = "\(0)"
        
    }
    
    
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let status = Status(title: "🙅‍♀️No Damage Recorded🙅‍♀️", description: "Keep up the Good Work!", image: UIImage(named: "placeholder")) {
            self.hideStatus()
           
        }
        
        print(self.car!, "the car!")
        Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageGet/\(car!.car_id)", method: .get, encoding: JSONEncoding.default).responseSwiftyJSON
            {response in
                print(response, "response from details!!!!!")
                
                 self.scratchCount = 0 //1
                 self.dentCount = 0 //2
                 self.chipCount = 0 //3
                 self.curbCount = 0 //4
                
                
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
                            self.scratchLabel.text = "\(self.scratchCount)"
                        case 2:
                            self.dentCount += 1
                            print(self.dentCount, "dents")
                            self.dentLabel.text = "\(self.dentCount)"
                        case 3:
                            self.chipCount += 1
                            print(self.chipCount, "chips")
                            self.chipLabel.text = "\(self.chipCount)"
                        case 4:
                            self.curbCount += 1
                            print(self.curbCount, "curb rash")
                            self.curbLabel.text = "\(self.curbCount)"
                        default:
                            self.curbLabel.text = "\(0)"
                            self.chipLabel.text = "\(0)"
                            self.dentLabel.text = "\(0)"
                            self.scratchLabel.text = "\(0)"
                        }
                        self.curbSlider.value = Float(self.curbCount)
                        self.curbSlider.minimumValue = 0
                        self.curbSlider.maximumValue = Float(self.curbCount + 10)
                        
                        self.chipSlider.value = Float(self.chipCount)
                        self.chipSlider.minimumValue = 0
                        self.chipSlider.maximumValue = Float(self.chipCount + 10)
                        
                        self.dentSlider.value = Float(self.dentCount)
                        self.dentSlider.minimumValue = 0
                        self.dentSlider.maximumValue = Float(self.dentCount + 10)
                        
                        self.scratchSlider.value = Float(self.scratchCount)
                        self.scratchSlider.minimumValue = 0
                        self.scratchSlider.maximumValue = Float(self.scratchCount + 10)
                    }
                case .failure:
                    print("no damage")
                    self.scratchLabel.isHidden = true
                    self.dentLabel.isHidden = true
                    self.chipLabel.isHidden = true
                    self.curbLabel.isHidden = true
                    self.damageReportLabel.isHidden = true
                    self.scratchButton.isHidden = true
                    self.dentButton.isHidden = true
                    self.chipButton.isHidden = true
                    self.curbButton.isHidden = true
                    self.show(status:status)
                }
        }
    
        
    }
    
}

