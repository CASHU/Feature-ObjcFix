//
//  CASHUResponse.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class CASHUResponse : NSObject {
    
    private(set) var cashuHeaderResponse : CASHUHeaderResponse = CASHUHeaderResponse(data: [:])
    private(set) var cashuBodyResponse : CASHUBodyResponse = CASHUBodyResponse(data: [:])
    private(set) var cashuFooterResponse : CASHUFooterResponse = CASHUFooterResponse(data: [:])
    
    init(data:[String:AnyObject]) {
        super.init()
        if let headerResponseData = data["HeaderResponse"] as? [String:AnyObject] {
            cashuHeaderResponse = CASHUHeaderResponse(data: headerResponseData)
        }
        
        if let bodyResponseData = data["BodyResponse"] as? [String:AnyObject] {
            cashuBodyResponse = CASHUBodyResponse(data: bodyResponseData)
        }
        
        if let footerResponseData = data["FooterResponse"] as? [String:AnyObject] {
            cashuFooterResponse = CASHUFooterResponse(data: footerResponseData)
        }
    }
}
