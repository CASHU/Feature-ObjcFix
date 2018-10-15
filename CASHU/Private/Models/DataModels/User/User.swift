//
//  User.swift
//
//  Created by Ahmed AbdEl-Samie on 3/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

import Foundation

@objcMembers class User : NSObject {
    private static let userKey = "LoggedInUserData"
    var status = ""
    
    var data:[String:AnyObject] = [:]
    
    init(data:[String:AnyObject]) {
        super.init()
        status = ValidationsUtility.forceObjectToBeString(data["status"])
    }
}
