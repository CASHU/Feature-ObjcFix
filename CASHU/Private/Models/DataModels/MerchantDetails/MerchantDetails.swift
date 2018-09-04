//
//  MerchantDetails.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class MerchantDetails : NSObject {
    
    private(set) var merchantReference = ""
    private(set) var clientID = ""
    private(set) var ip = ""
    private(set) var merchantLogo = ""
    private(set) var deviceID = ""
    private(set) var merchantName = ""
    private(set) var paymentDetails : PaymentDetails = PaymentDetails(data: [:])


    init(data:[String:AnyObject]) {
        super.init()
        merchantReference = ValidationsUtility.forceObjectToBeString(data["Merchant_Ref"])
        clientID = ValidationsUtility.forceObjectToBeString(data["Client_ID"])
        ip = ValidationsUtility.forceObjectToBeString(data["IP"])
        merchantLogo = ValidationsUtility.forceObjectToBeString(data["Merchant_LogoPath"])
        deviceID = ValidationsUtility.forceObjectToBeString(data["Device_Id"])
        merchantName = ValidationsUtility.forceObjectToBeString(data["Merchant_DisplayName"])
        
        if let paymentObject = data["Pay_Obj"] as? [String : AnyObject] {
            paymentDetails = PaymentDetails(data : paymentObject)
        }
    }
}
