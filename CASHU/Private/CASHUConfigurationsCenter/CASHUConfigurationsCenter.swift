//
//  CASHUConfigurationsCenter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation


class CASHUConfigurationsCenter: NSObject {
    
    var cashuConfigurations : CASHUConfigurations = CASHUConfigurations(){
        didSet{
            switch CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.language{
            case .arabic:
                LocalizationManager.sharedInstance.changeCurrentLanguageTo(.arabic)
            case.english:
                LocalizationManager.sharedInstance.changeCurrentLanguageTo(.english)
            }
        }
    }
    
    
    private static var privateSharedInstance : CASHUConfigurationsCenter?
    
    class func sharedInstance() -> CASHUConfigurationsCenter {
        guard let sharedInstance = privateSharedInstance else {
            privateSharedInstance = CASHUConfigurationsCenter()
            return privateSharedInstance!
        }
        
        return sharedInstance
    }
    
    class func destroy() {
        privateSharedInstance = nil
    }
}
