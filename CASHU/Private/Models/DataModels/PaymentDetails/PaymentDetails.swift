//
//  PaymentDetails.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class PaymentDetails : NSObject {
    
    private(set) var currency = ""
    private(set) var amount = ""
    private(set) var displayText = ""
    
    init(data:[String:AnyObject]) {
        super.init()
        
        if let payObjectData = data["Pay_Obj"] as? String{
            let payObject = payObjectData.data(using: .utf8)!
            let data = ParsingUtility.parseDataAsDictionary(payObject)
            currency = ValidationsUtility.forceObjectToBeString(data["currency"])
            amount = ValidationsUtility.forceObjectToBeString(data["amount"])
            displayText = ValidationsUtility.forceObjectToBeString(data["displayText"])
        }
    }
}

