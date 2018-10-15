//
//  CASHUFooterResponse.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class CASHUFooterResponse : NSObject {
    private(set) var chkSum = ""
    private(set) var extra1 = ""
    private(set) var extra2 = ""
    private(set) var extra3 = ""
    
    init(data:[String:AnyObject]) {
        super.init()
        chkSum = ValidationsUtility.forceObjectToBeString(data["ChkSum"])
        extra1 = ValidationsUtility.forceObjectToBeString(data["Extra1"])
        extra2 = ValidationsUtility.forceObjectToBeString(data["Extra2"])
        extra3 = ValidationsUtility.forceObjectToBeString(data["Extra3"])
    }
}
