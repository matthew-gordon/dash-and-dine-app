//
//  APIManager.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/4/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class APIManager {

    static let shared = APIManager()
    
    let baseURL = NSURL(string: "localhost:8000/")
    
    var accessToken = ""
    var refreshToken = ""
    var expired = Date()
    
    // API to login a User
    func login(userType: String, completionHandler: @escaping (JSON) -> Void) {
    
    }
    
    // API to log a user out
    func logout(completionHandler: @escaping (NSError?) -> Void) {
    
    }
    
}
