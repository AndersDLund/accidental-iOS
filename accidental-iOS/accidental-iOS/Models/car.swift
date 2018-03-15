//
//  cars.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import Foundation

class car {
    var make: String
    var model: String
    var swag: Int
    var image: String
    
    init(make: String, model: String, swag: Int, image: String){
        self.make = make
        self.model = model
        self.swag = swag
        self.image = image
    }
}
