//
//  CASHUToken.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class CASHUToken : NSObject {
    private(set) var token = ""
    private(set) var tokenLifeTime = ""
    private(set) var mobLastVersion = ""
    private(set) var manUpdateFlag = ""
    private(set) var tokenExpiryDateString = ""
    private(set) var tokenExpiryDate : Date?

    init(data:[String:AnyObject]) {
        super.init()
        token = ValidationsUtility.forceObjectToBeString(data["Token"])
        tokenLifeTime = ValidationsUtility.forceObjectToBeString(data["TokenLifeTime"])
        mobLastVersion = ValidationsUtility.forceObjectToBeString(data["MobLatestVer"])
        manUpdateFlag = ValidationsUtility.forceObjectToBeString(data["ManUpdateFlag"])
        tokenExpiryDateString = ValidationsUtility.forceObjectToBeString(data["TokenExpDate"])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        tokenExpiryDate = dateFormatter.date(from: tokenExpiryDateString)
    }
    
    func isValid() -> Bool {
        let tokenTimeStamp = tokenExpiryDate?.timeIntervalSince1970 ?? 0
        let currentTimeStamp = Date().timeIntervalSince1970
        let tokenLifeTime = Double(self.tokenLifeTime) ?? 0
        if(tokenTimeStamp - currentTimeStamp > tokenLifeTime) {
            return true
        }
        
        return false
    }
}
