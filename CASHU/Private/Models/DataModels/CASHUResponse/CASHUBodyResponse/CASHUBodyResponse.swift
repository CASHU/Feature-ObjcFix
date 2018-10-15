//
//  CASHUBodyResponse.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class CASHUBodyResponse : NSObject {
    private(set) var resultCode = ""
    private(set) var resultMessageError = ""
    private(set) var resultMessageAr = ""
    private(set) var resultMessageEn = ""

    private(set) var data:[String:AnyObject] = [:]
    
    init(data:[String:AnyObject]) {
        super.init()
        resultCode = ValidationsUtility.forceObjectToBeString(data["ResCod"])
        if let resultMessage = data["ResMsg"] as? [String:AnyObject] {
            resultMessageError = ValidationsUtility.forceObjectToBeString(resultMessage["error"])
            resultMessageAr = ValidationsUtility.forceObjectToBeString(resultMessage["ar"])
            resultMessageEn = ValidationsUtility.forceObjectToBeString(resultMessage["en"])
        }else if let resultMessage = data["ResMsg"] as? String{
            resultMessageError = resultMessage
            resultMessageAr = resultMessage
            resultMessageEn = resultMessage
        }

        self.data = data
    }
}
