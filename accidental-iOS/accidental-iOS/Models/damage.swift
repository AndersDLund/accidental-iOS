//
//  damage.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/15/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import Foundation

class damage {
    var dents: Int
    var scratches: Int
    var curbRash: Int
    var chips: Int
    
    init(dents:Int, scratches:Int, curbRash:Int, chips:Int){
        self.dents = dents
        self.scratches = scratches
        self.curbRash = curbRash
        self.chips = chips
    }
}
