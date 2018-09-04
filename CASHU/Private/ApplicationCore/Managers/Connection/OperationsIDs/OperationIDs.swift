//
//  OperationIDs.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/20/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 Operation IDs which is unique identifiers to identify every request is going out from the application
 */
enum OperationID : Int {
    case None
    case LoadImageGeneralOperationID
    case IPAddressInfo
    case Authenticate
    case Initialize
    case SignIn
    case CancelInitialize
    case CompletePayment
}
