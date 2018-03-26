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
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var scratchLabel: TOMSMorphingLabel!
    @IBOutlet weak var dentLabel: TOMSMorphingLabel!
    @IBOutlet weak var chipLabel: TOMSMorphingLabel!
    @IBOutlet weak var curbLabel: TOMSMorphingLabel!

    
    @IBOutlet weak var scratchSlider: UISlider!
    @IBOutlet weak var dentSlider: UISlider!
    @IBOutlet weak var chipSlider: UISlider!
    @IBOutlet weak var curbSlider: UISlider!
    
    @IBOutlet weak var scratchConfirmation: UIButton!
    @IBOutlet weak var dentsConfirmation: UIButton!
    @IBOutlet weak var chipsConfirmation: UIButton!
    @IBOutlet weak var curbConfirmation: UIButton!
    
    
    var scratchCount = 0 //1
    var dentCount = 0 //2
    var chipCount = 0 //3
    var curbCount = 0 //4
    
    @IBAction func scratchConfirmationClicked(_ sender: Any) {
        let params = ["damage_type_id": 1]
        if Int(scratchSlider.value) - scratchCount > 0 {
            for _ in 0..<Int(scratchSlider.value) - scratchCount {
                
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
//                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            HUD.flash(.success, delay: 1.0)
        } else if Int(scratchSlider.value) - scratchCount < 0 {
            //decrease
//            for _ in 0..<abs(Int(scratchSlider.value) - scratchCount) {
            
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageDelete/\(car!.car_id)?limit=\(abs(Int(scratchSlider.value) - scratchCount))", method: .delete, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
//                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            for _ in 0..<scratchCount - abs(Int(scratchSlider.value) - scratchCount) {
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            
//            }
            HUD.flash(.success, delay: 1.0)
        } else {
            //do nothing
            print("nothing shoud change")
        }
        HUD.flash(.success, delay: 1.0)
    
    }
    
    @IBAction func dentConfirmationClicked(_ sender: Any) {
        let params = ["damage_type_id": 2]
        if Int(dentSlider.value) - dentCount > 0 {
            for _ in 0..<Int(dentSlider.value) - dentCount {
                
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            HUD.flash(.success, delay: 1.0)
        } else if Int(dentSlider.value) - dentCount < 0 {
            //decrease
            //            for _ in 0..<abs(Int(scratchSlider.value) - scratchCount) {
            
            Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageDelete/\(car!.car_id)?limit=\(abs(Int(dentSlider.value) - dentCount))", method: .delete, parameters: params, encoding: JSONEncoding.default).responseString
                {response in
                    //                        HUD.flash(.success, delay: 1.0)
                    print(response)
            }
            for _ in 0..<dentCount - abs(Int(dentSlider.value) - dentCount) {
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            
            //            }
            HUD.flash(.success, delay: 1.0)
        } else {
            //do nothing
            print("nothing shoud change")
        }
        HUD.flash(.success, delay: 1.0)
    }
    
    @IBAction func chipConfirmationClicked(_ sender: Any) {
        let params = ["damage_type_id": 3]
        if Int(chipSlider.value) - chipCount > 0 {
            for _ in 0..<Int(chipSlider.value) - chipCount {
                
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            HUD.flash(.success, delay: 1.0)
        } else if Int(chipSlider.value) - chipCount < 0 {
            //decrease
            //            for _ in 0..<abs(Int(scratchSlider.value) - scratchCount) {
            
            Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageDelete/\(car!.car_id)?limit=\(abs(Int(chipSlider.value) - chipCount))", method: .delete, parameters: params, encoding: JSONEncoding.default).responseString
                {response in
                    //                        HUD.flash(.success, delay: 1.0)
                    print(response)
            }
            for _ in 0..<chipCount - abs(Int(chipSlider.value) - chipCount) {
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            
            //            }
            HUD.flash(.success, delay: 1.0)
        } else {
            //do nothing
            print("nothing shoud change")
        }
        HUD.flash(.success, delay: 1.0)
    }
    
    @IBAction func curbConfirmationClicked(_ sender: Any) {
        let params = ["damage_type_id": 4]
        if Int(curbSlider.value) - curbCount > 0 {
            for _ in 0..<Int(curbSlider.value) - curbCount {
                
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            HUD.flash(.success, delay: 1.0)
        } else if Int(curbSlider.value) - curbCount < 0 {
            //decrease
            //            for _ in 0..<abs(Int(scratchSlider.value) - scratchCount) {
            
            Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageDelete/\(car!.car_id)?limit=\(abs(Int(curbSlider.value) - curbCount))", method: .delete, parameters: params, encoding: JSONEncoding.default).responseString
                {response in
                    //                        HUD.flash(.success, delay: 1.0)
                    print(response)
            }
            for _ in 0..<curbCount - abs(Int(curbSlider.value) - curbCount) {
                Alamofire.request("https://aqueous-hollows-24814.herokuapp.com/damageNew/\(car!.car_id)", method: .post, parameters: params, encoding: JSONEncoding.default).responseString
                    {response in
                        //                        HUD.flash(.success, delay: 1.0)
                        print(response)
                }
            }
            
            //            }
            HUD.flash(.success, delay: 1.0)
        } else {
            //do nothing
            print("nothing shoud change")
        }
        HUD.flash(.success, delay: 1.0)
    }
    
    

    
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
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            scratchSlider.isHidden = false
            dentSlider.isHidden = true
            chipSlider.isHidden = true
            curbSlider.isHidden = true
            
            scratchConfirmation.isHidden = false
            dentsConfirmation.isHidden = true
            chipsConfirmation.isHidden = true
            curbConfirmation.isHidden = true
            
            scratchLabel.isHidden = false
            dentLabel.isHidden = true
            chipLabel.isHidden = true
            curbLabel.isHidden = true
            
        case 1:
            dentSlider.isHidden = false
            scratchSlider.isHidden = true
            chipSlider.isHidden = true
            curbSlider.isHidden = true
            
            scratchConfirmation.isHidden = true
            dentsConfirmation.isHidden = false
            chipsConfirmation.isHidden = true
            curbConfirmation.isHidden = true
            
            scratchLabel.isHidden = true
            dentLabel.isHidden = false
            chipLabel.isHidden = true
            curbLabel.isHidden = true
            
        case 2:
            chipSlider.isHidden = false
            scratchSlider.isHidden = true
            dentSlider.isHidden = true
            curbSlider.isHidden = true
            
            scratchConfirmation.isHidden = true
            dentsConfirmation.isHidden = true
            chipsConfirmation.isHidden = false
            curbConfirmation.isHidden = true
            
            scratchLabel.isHidden = true
            dentLabel.isHidden = true
            chipLabel.isHidden = false
            curbLabel.isHidden = true
            
        case 3:
            curbSlider.isHidden = false
            scratchSlider.isHidden = true
            dentSlider.isHidden = true
            chipSlider.isHidden = true
            
            scratchConfirmation.isHidden = true
            dentsConfirmation.isHidden = true
            chipsConfirmation.isHidden = true
            curbConfirmation.isHidden = false
            
            scratchLabel.isHidden = true
            dentLabel.isHidden = true
            chipLabel.isHidden = true
            curbLabel.isHidden = false
            
        default:
            print("how did this happen?!?!?!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scratchSlider.isHidden = true
        dentSlider.isHidden = true
        chipSlider.isHidden = true
        curbSlider.isHidden = true
        
        scratchLabel.isHidden = true
        dentLabel.isHidden = true
        chipLabel.isHidden = true
        curbLabel.isHidden = true
        
        scratchConfirmation.isHidden = true
        dentsConfirmation.isHidden = true
        chipsConfirmation.isHidden = true
        curbConfirmation.isHidden = true
        
        
        
        let url = URL(string: (car?.image)!)
        let data = try? Data(contentsOf: url!)
        print(url!)
        carLabel.text = "\(car!.make.uppercased()) \(car!.model.uppercased())"
        
        carImage.image = UIImage(data:data!)
        
        
        self.scratchLabel.text = "\(0)"
        self.dentLabel.text = "\(0)"
        self.chipLabel.text = "\(0)"
        self.curbLabel.text = "\(0)"
        
    }
    
    
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
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
                        self.curbSlider.maximumValue = Float(self.curbCount + 5)
                        
                        self.chipSlider.value = Float(self.chipCount)
                        self.chipSlider.minimumValue = 0
                        self.chipSlider.maximumValue = Float(self.chipCount + 5)
                        
                        self.dentSlider.value = Float(self.dentCount)
                        self.dentSlider.minimumValue = 0
                        self.dentSlider.maximumValue = Float(self.dentCount + 5)
                        
                        self.scratchSlider.value = Float(self.scratchCount)
                        self.scratchSlider.minimumValue = 0
                        self.scratchSlider.maximumValue = Float(self.scratchCount + 5)
                    }
                case .failure:
                    print("no damage")
//                    self.scratchLabel.isHidden = true
//                    self.dentLabel.isHidden = true
//                    self.chipLabel.isHidden = true
//                    self.curbLabel.isHidden = true
//
//
//                    self.scratchConfirmation.isHidden = true
//                    self.dentsConfirmation.isHidden = true
//                    self.chipsConfirmation.isHidden = true
//                    self.curbConfirmation.isHidden = true
                    
                }
        }
    
        
    }
    
}

