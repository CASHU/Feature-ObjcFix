//
//  ValidationsUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/29/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 This class provides some validations methods to be used across the app.
 It's a utility class with static methods.
 */
@objcMembers class ValidationsUtility: NSObject {
    /**
     Check if the passed object is not null.
     
     - parameter object: The object you want to check if it's null or not
     
     - returns: True of false based on if the object is null or not.
     */
    class func isObjectNotNull(_ object: Any?) -> Bool {
        if object is NSNull || object == nil {
            return false
        }
        return true
    }

    /**
     forces the passed object to be string.
     Please note that if the object is null it will return empty string.
     
     - parameter object: The object you want to force to be string
     
     - returns: The passed object as string
     */
    class func forceObjectToBeString(_ object: AnyObject?) -> String {
        if isObjectNotNull(object) {
            return "\((object)!)"
        }
        return ""
    }

    /**
     Check if the passed string is not null.
     
     - parameter string: The string you want to check if it's null or not
     
     - returns: True of false based on if the string is null or not.
     */
    class func isStringNotNull(_ string: String?) -> Bool {
        if string == nil || string?.caseInsensitiveCompare("null") == .orderedSame || string?.caseInsensitiveCompare("<null>") == .orderedSame {
            return false
        }
        return true
    }

    /**
     Check if the passed string is not empty.
     
     - parameter string: The string you want to check if it's empty or not
     
     - returns: True of false based on if the string is empty or not.
     */
    class func isStringNotEmpty(_ string: String) -> Bool {
        if isStringNotNull(string) {
            if string.caseInsensitiveCompare("") == .orderedSame {
                return false
            }
            return true
        }
        return false
    }

    /**
     Check if the passed strings are equals or not.
     
     - parameter string: First string you want to compare
     - parameter anotherString: Second string you want to compare
     - parameter isCaseSensitivity: Is the comparison with case sensitivity or not
     
     - returns: True of false based on if the strings are equals or not.
     */
    class func isString(_ string: String, equalsString anotherString: String, withCaseSensitivityCoparison isCaseSensitivity: Bool) -> Bool {
        if isStringNotNull(string) {
            if isCaseSensitivity {
                if (string == anotherString) {
                    return true
                }
                return false
            }
            else {
                if string.caseInsensitiveCompare(anotherString) == .orderedSame {
                    return true
                }
                return false
            }
        }
        return false
    }

    /**
     Check if the passed strings charachters count is between the passed boundaires.
     
     - parameter string: String that you want to check for boundaries
     - parameter lowestBoundary: Lowest boundary for the charachters count
     - parameter highestBoundary: Highest boundary for the charachters count
     
     - returns: True of false based on if the charachters count is between the passed boundaires.
     */
    class func isCharachtersCountOfStringBetweenBoundaries(string: String, lowestBoundary: Int, highestBoundary: Int) -> Bool {
        if ((string.count >= lowestBoundary ) && (string.count <= highestBoundary)) {
            return true
        }
        return false
    }

    /**
     Check if the string contains another string or not.
     Please note that this is a case sensitive search.
     
     - parameter string: string that you want to search in
     - parameter stringToBeFound: string that you want to find
     
     - returns: True of false based on if the string does exist or not.
     */
    class func isStringContainsString(string: String,  stringToBeFound: String) -> Bool {
        if (string as NSString).range(of: stringToBeFound).location == NSNotFound {
            return false
        }
        return true
    }

    /**
     Cehck if the provided string is in the correct mail format.
     
     - parameter email: The email as string that you want to validate
     - parameter isStrict: Is the the validation strict or not - recommended is true
     
     - returns: Initialized Object with the URL request ready to be used.
     */
    class func isEmailIsValid(_ email: String, isStrict: Bool) -> Bool {
        let stricterFilterString: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let laxString: String = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex: String = isStrict ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
}

