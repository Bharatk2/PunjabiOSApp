//
//  User.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 8/24/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import Foundation
import SwiftyJSON

class FBUser {
    var name: String?
    var email: String?
    var pictureURL: String?
    
    static let currentUser = FBUser()
    
    func setInfo(json: JSON) {
        self.name = json["name"].string
        self.email = json["email"].string
        
        let image = json["picture"].dictionary
        let imageData = image?["data"]?.dictionary
        self.pictureURL = imageData?["url"]?.string
    }
    
    func resetInfo() {
        self.name = nil
        self.email = nil
        self.pictureURL = nil
    }
}
