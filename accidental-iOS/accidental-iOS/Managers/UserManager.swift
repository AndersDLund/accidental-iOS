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
//    {
//        didSet {
//            if let currentUser = currentUser {
//                let archivedUser = NSKeyedArchiver.archivedData(withRootObject: currentUser)
//                UserDefaults.standard.set(archivedUser, forKey: "currentUser")
//            }
//        }
//    }
    
    override private init() {
        super.init()
    }
    
    func fetchUserLocally() {
        let userData = UserDefaults.standard.data(forKey: "currentUser")
        if let userData = userData {
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as! User
            currentUser = user
        } else {
            currentUser = nil
        }
    }
}
