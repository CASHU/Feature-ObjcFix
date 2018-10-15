//
//  ParsingUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/29/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 This class provides an easy way to parse the date provided from any response.
 It's a utility class with static methods.
 */
@objcMembers class ParsingUtility: NSObject {
    /**
     Parses the raw data as an array of strings.
     
     - parameter rawData: The data to be parssed
     
     - returns: An array with parsed data.
     */
    class func parseDataAsArray(_ rawData: Data) -> [AnyObject]? {
        var dataString = NSString(data: rawData, encoding: String.Encoding.utf8.rawValue)
        dataString = dataString?.replacingOccurrences(of: "NULL", with: "null") as NSString?
        let rawDataAfterRemovingNulls = dataString?.data(using: String.Encoding.utf8.rawValue)
        var dataArray: [AnyObject] = []
        do {
            if let tempArray = try JSONSerialization.jsonObject(with: rawDataAfterRemovingNulls!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [AnyObject]{
                dataArray = tempArray
            }else{
                return nil
            }
        } catch let error as NSError {
            print(error)
        }
        
        return dataArray
    }

    /**
     Parses the raw data as a dictionary of strings.
     
     - parameter rawData: The data to be parssed
     
     - returns: A dictionary with parsed data.
     */
    class func parseDataAsDictionary(_ rawData: Data) -> [String: AnyObject] {
        var dataString = NSString(data: rawData, encoding: String.Encoding.utf8.rawValue)
        dataString = dataString?.replacingOccurrences(of: "NULL", with: "null") as NSString?
        let rawDataAfterRemovingNulls = dataString?.data(using: String.Encoding.utf8.rawValue)
        var dataDictionary: [String: AnyObject] = [:]
        do {
            dataDictionary = try JSONSerialization.jsonObject(with: rawDataAfterRemovingNulls!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
        } catch let error as NSError {
            print(error)
        }
        
        return dataDictionary
    }

    /**
     Parses the raw data as a string.
     
     - parameter rawData: The data to be parssed
     
     - returns: A string with parsed data.
     */
    class func parseDataAsString(_ rawData: Data) -> String {
        var dataString = NSString(data: rawData, encoding: String.Encoding.utf8.rawValue)
        dataString = dataString?.replacingOccurrences(of: "NULL", with: "null") as NSString?
        return dataString! as String
    }

    /**
     Clears HTML tags from passed string and replace <br> with \n.
     
     - parameter text: The string to be cleared
     
     - returns: A string with the provided text after clearing the HTML tags from it.
     */
    class func clearHTMLTagsFrom(_ text: String) -> String {
        var textAfterClearingHTMLTags: String = text
        let htmlTags: [String] = ["<table>", "<tbody>", "<tr>", "<td>", "</td>", "</tbody>", "</table>", "</tr>", "</li>", "<li>", "</ul>", "<ul>", "<h1>", "</h1>", "<h2>", "</h2>", "<h3>", "</h3>", "<h4>", "</h4>", "<h5>", "</h5>", "<h6>", "</h6>", "<p>"]
        let newLineTags: [String] = ["</br>", "<br />", "<br/>", "<br>", "</p>"]
        for htmlTag: String in htmlTags {
            textAfterClearingHTMLTags = textAfterClearingHTMLTags.replacingOccurrences(of: htmlTag, with: "")
        }
        for newLineHTMLTag: String in newLineTags {
            textAfterClearingHTMLTags = textAfterClearingHTMLTags.replacingOccurrences(of: newLineHTMLTag, with: "\n")
        }
        return textAfterClearingHTMLTags
    }
    
    /**
     Clears HTML tags from passed string and replace <br> with \n.
     
     - parameter text: The string to be converted
     
     - returns: A string with the provided text after converting the digits to arabic.
     */
    class func convertNumbersToArabic(_ text: String) -> String {
        let Formatter: NumberFormatter = NumberFormatter()
        Formatter.locale = Locale(identifier: "ar")
        let convertedString = Formatter.string(from: NSNumber(value: Double(text)!))
        
        return convertedString!
    }
}
