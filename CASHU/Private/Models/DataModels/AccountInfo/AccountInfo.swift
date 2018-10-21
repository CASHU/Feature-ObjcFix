//
//  AccountInfo.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class AccountInfo : NSObject {
    
    private(set) var name = ""
    private(set) var balanceAmount = ""
    private(set) var balanceCurrency = ""
    private(set) var loginSession = ""
    
    init(data:[String:AnyObject]) {
        super.init()
        
        if let profileInfoData = data["ProfileInfo_Obj"] as? String{
            let data = profileInfoData.data(using: .utf8)!
            let profileInfo = ParsingUtility.parseDataAsDictionary(data)
            name = ValidationsUtility.forceObjectToBeString(profileInfo["nickname"])
        }
        
        if let balanceInfoData = data["BalanceInfo_Obj"] as? String{
            let data = balanceInfoData.data(using: .utf8)!
            let balanceInfo = ParsingUtility.parseDataAsDictionary(data)
            balanceAmount = ValidationsUtility.forceObjectToBeString(balanceInfo["balanceAmount"])
            balanceCurrency = ValidationsUtility.forceObjectToBeString(balanceInfo["balanceCurrency"])
        }

        loginSession = ValidationsUtility.forceObjectToBeString(data["LoginSession"])
    }
}
