//
//  User.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import Foundation

struct User {
    var id: Int?
    var email: String?
    var fullName: String?
    var organization: String?
}

//class User: NSObject {
//
//    var id: Int?
//    var email: String?
//    var fullName: String?
//    var organization: String?
//
//    override init() {
//        super.init()
//    }
//
//    init(id: Int, email: String, fullName: String, org: String) {
//        super.init()
//        self.id = id
//        self.email = email
//        self.fullName = fullName
//        self.organization = org
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        self.id = aDecoder.decodeObject(forKey: "id") as? Int
//        self.email = aDecoder.decodeObject(forKey: "email") as? String
//        self.fullName = aDecoder.decodeObject(forKey: "fullName") as? String
//        self.organization = aDecoder.decodeObject(forKey: "organization") as? String
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(id, forKey: "id")
//        aCoder.encode(email, forKey: "email")
//        aCoder.encode(fullName, forKey: "fullName")
//        aCoder.encode(organization, forKey: "organization")
//    }
//}

