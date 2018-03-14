//
//  UserManager.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    
    // MARK: - Properties
    
    static let manager = UserManager()
    var currentUser: User?
    
    override private init() {
        super.init()
    }
}
