//
//  ApiManager.swift
//  accidental-iOS
//
//  Created by Anders Lund on 3/14/18.
//  Copyright © 2018 accidental. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

class apiManager: NSObject {
    func apiCall(url: String, apiMethod: HTTPMethod){
        if apiMethod == .get{
             Alamofire.request(url, method: apiMethod, encoding: JSONEncoding.default).responseString
                {response in
                    print(response)
            }
        } else {
            print("need different logic!")
        }
    }
}
