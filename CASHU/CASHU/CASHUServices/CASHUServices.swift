//
//  CASHUServices.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers open class CASHUServices: NSObject {
    
    /**
     Initializing a new payment.
     
     - parameter parent: The parent which will hold the payment process.
     - parameter configurations: The configurations which will be used to hold some info like keys, options of display ..etc
     */
    open class func initiateProductPaymentInParent(_ parent : UIViewController, configurations : CASHUConfigurations){
        CASHURouter.initiateProductPaymentInParent(parent, configurations : configurations)
    }
}
