//
//  ThreadsUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/29/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 This class provides an easy way to deal with threads and delays.
 It's a utility class with static methods.
 */
class ThreadsUtility: NSObject {
    /**
     Execute a block of code after a specific amount of seconds.
     
     - parameter block: The block to be executed
     - parameter delay: The delay in seconds before executing the block
     */
    class func execute(_ block: @escaping () -> Void, afterDelay delay: Double) {
        let delayInSeconds: DispatchTime = DispatchTime.now() + delay
        
        DispatchQueue.main.asyncAfter(deadline: delayInSeconds) {
            block()
        }
    }
}
