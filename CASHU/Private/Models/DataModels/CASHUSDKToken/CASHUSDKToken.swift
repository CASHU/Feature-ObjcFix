//
//  CASHUSDKToken.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class CASHUSDKToken : NSObject {
    
    private(set) var token = ""
    private(set) var tokenExpiryDateString = ""
    
    init(data:[String:AnyObject]) {
        super.init()
        
        tokenExpiryDateString = ValidationsUtility.forceObjectToBeString(data["SDK_Token_Expiry"])
        token = ValidationsUtility.forceObjectToBeString(data["SDK_Token"])
    }
    
//    func isValid() -> Bool {
//        let tokenTimeStamp = tokenExpiryDate?.timeIntervalSince1970 ?? 0
//        let currentTimeStamp = Date().timeIntervalSince1970
//        let tokenLifeTime = Double(self.tokenLifeTime) ?? 0
//        if(tokenTimeStamp - currentTimeStamp > tokenLifeTime) {
//            return true
//        }
//
//        return false
//    }
}
