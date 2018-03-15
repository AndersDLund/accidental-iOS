//
//  DetailsViewController.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var makeLabel: UILabel!
    var car:car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLabel.text = car?.make.capitalized
        modelLabel.text = car?.model.capitalized
        
    }

}
