//
//  CASHUConfigurations.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

open class CASHUConfigurations: NSObject {
    
    // Client ID provided to your from cashu
    open var clientID = ""
    
    // UNIQUE Merchant Reference 
    open var merchantReference = ""
    
    // Prefered enviornment to run the sdk on it
    open var environment : Environment = .dev
    
    // Unique device identifier
    open var deviceID = ""
    
    
    // Product details which will be used through the payment process
    open var productDetails : ProductDetails = ProductDetails()
    
    // How to do you want to display the service
    open var presentingMethod : PresentingMethod = .push
    
    // SDK Token provided to you from cash u
    open var sdkToken = ""
    
    // choose one of our supported languages
    open var language : ContentLanguge = .english
    
    // enable logging
    open var isLoggingEnabled : Bool = true

}
