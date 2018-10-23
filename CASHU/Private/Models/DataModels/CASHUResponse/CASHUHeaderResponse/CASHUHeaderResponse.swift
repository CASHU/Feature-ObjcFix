//
//  CASHUHeaderResponse.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class CASHUHeaderResponse : NSObject {
    private(set) var dateTime = ""
    private(set) var resultCode = ""
    private(set) var resultMessage = ""
    private(set) var uuid = ""
    private(set) var utid = ""
    
    init(data:[String:AnyObject]) {
        super.init()
        dateTime = ValidationsUtility.forceObjectToBeString(data["DateTime"])
        resultCode = ValidationsUtility.forceObjectToBeString(data["RslCod"])
        resultMessage = ValidationsUtility.forceObjectToBeString(data["RslMsg"])
        uuid = ValidationsUtility.forceObjectToBeString(data["UUID"])
        utid = ValidationsUtility.forceObjectToBeString(data["UTID"])
    }
}
