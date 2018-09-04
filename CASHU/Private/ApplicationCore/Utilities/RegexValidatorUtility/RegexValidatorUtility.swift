//
//  RegexValidatorUtility.swift
//
//  Created by Ahmed AbdEl-Samie on 3/4/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

class RegexValidatorUtility{
    class func isContainingAtLeastOneCharacter(_ text : String) -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: ".*[a-zA-z\\u0621-\\u064A].*")
            let results = regex.matches(in: text, range: NSRange(location: 0, length: text.count))
            if(results.count > 0){
                return true
            }
            return false
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    class func isContainingAtLeastOneNumber(_ text : String) -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: ".*[0-9\\u0660-\\u0669].*")
            let results = regex.matches(in: text, range: NSRange(location: 0, length: text.count))
            if(results.count > 0){
                return true
            }
            return false
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    class func isContainingAtLeastOneSpecialCharacterOtherThanSpace(_ text : String) -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-z\\u0621-\\u064A 0-9\\u0660-\\u0669]+$")
            let results = regex.matches(in: text, range: NSRange(location: 0, length: text.count))
            if(results.count > 0){
                return false
            }
            return true
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
}
