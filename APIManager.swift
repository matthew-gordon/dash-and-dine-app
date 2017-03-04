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
    
    let baseURL = NSURL(string: BASE_URL)
    
    var accessToken = ""
    var refreshToken = ""
    var expired = Date()
    
    // API to login a User
    func login(userType: String, completionHandler: @escaping (NSError?) -> Void) {
    
        let path = "api/social/convert-token"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "grant_type": "conevrt-token",
            "client_id": CLIENT_ID,
            "client_Secret": CLIENT_SECRET,
            "backend": "facebook",
            "token": FBSDKAccessToken.current().tokenString,
            "user_type": userType
        ]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                let jsonData = JSON(value)
                
                self.accessToken = jsonData["access_token"].string!
                self.refreshToken = jsonData["refresh_token"].string!
                self.expired = Date().addingTimeInterval(TimeInterval(jsonData["expires_in"].int!))
                
                completionHandler(nil)
                break
                
            case .failure(let error):
                completionHandler(error as NSError?)
                break
            }
        }
    }
    
    // API to log a user out
    func logout(completionHandler: @escaping (NSError?) -> Void) {
    
        let path = "api/social/revoke-token"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "token": self.accessToken
        ]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil)
            .responseString { (response) in
                switch response.result {
                case .success:
                    completionHandler(nil)
                    break
                    
                case .failure(let error):
                    completionHandler(error as NSError?)
                    break
                }
            }
        
    }
    
}
