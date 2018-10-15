//
//  ColorsUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/27/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation
import UIKit

/**
 This class provides an easy way to handle different ways for dealing with colors in the application.
 It's a utility class with static methods.
 */
@objcMembers class ColorsUtility: NSObject {
    
    /**
     Convert color from hex string format to color format.
     
     - parameter hex: Color in hex string format
     
     - returns: Color from the provided hex string.
     */
    class func colorWithHexString(_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cString.count < 6 {
            return UIColor.gray
        }
        if cString.hasPrefix("0X") {
            let index = cString.index(cString.startIndex, offsetBy: 2)
            cString = String(cString[index..<cString.endIndex])
        }
        if cString.count == 7 && cString.first == "#" {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index..<cString.endIndex])
        }
        if cString.count
            != 6 {
            return UIColor.gray
        }
        var range: NSRange = NSRange()
        range.location = 0
        range.length = 2
        let rString: String = (cString as NSString).substring(with: range)
        range.location = 2
        let gString: String = (cString as NSString).substring(with: range)
        range.location = 4
        let bString: String = (cString as NSString).substring(with: range)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat((Float(r) / 255.0)), green: CGFloat((Float(g) / 255.0)), blue: CGFloat((Float(b) / 255.0)), alpha: CGFloat(1.0))
    }
}
