//
//  ProductDetails.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

open class ProductDetails: NSObject {
    
    // Currency for the payment, All transaction will be in USD, if other is selected transfer rates will be applied
    open var currency : Currency = .usd
    
    // Product Price
    open var price = 0.0
    
    // Product Name
    open var productName = ""
    
    // Product Image
    open var productImage : UIImage?
    
}
