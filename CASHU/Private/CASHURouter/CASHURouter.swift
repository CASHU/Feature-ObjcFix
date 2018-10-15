//
//  CASHURouter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

public enum PresentingMethod {
    case present
    case push
}

public enum ContentLanguge {
    case english
    case arabic
}

public enum Environment {
    case prod
    case dev
}

public enum Currency {
    case usd
    case aed
}

@objcMembers class CASHURouter: NSObject {
    
    class func initiateProductPaymentInParent(_ parent : UIViewController, configurations : CASHUConfigurations){
        CASHUConfigurationsCenter.sharedInstance().cashuConfigurations = configurations
        InitializationInterface.initiateInInParent(parent)
    }
}

