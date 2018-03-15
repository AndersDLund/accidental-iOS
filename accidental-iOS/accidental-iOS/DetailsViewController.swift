//
//  DetailsViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
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

}
