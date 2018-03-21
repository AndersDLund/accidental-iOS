//
//  cars.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import Foundation

class car {
    var plate: String
    var car_id: Int
    var user_id: Int
    var make: String
    var model: String
    var image: String
    
    init(plate:String, car_id:Int, make: String, model: String, image: String, user_id:Int){
        self.plate = plate
        self.car_id = car_id
        self.make = make
        self.model = model
        self.image = image
        self.user_id = user_id
    }
}
