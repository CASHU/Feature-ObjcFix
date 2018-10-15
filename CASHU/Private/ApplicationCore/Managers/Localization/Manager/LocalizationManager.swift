//
//  LocalizationManager.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/23/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 Languages that is supported by the application.
 
 - english: English Langauge.
 */
enum Language : String {
    case english
    case arabic
}

/**
 Localization Manager is a static singelton class which is responsible for providing the correct strings for the currently selected language.
 PLEASE use the shared instance to make sure that the application strings will be handled by only one static manager.
 The way it works that you need to add the Langauge key in the Language enum and provide a .plist file with the same keys for a different langauges and name it as the Langauge enum string.
 */
@objcMembers class LocalizationManager: NSObject {
    // Currently cached dictionary with the langauge keys and values
    private var dict = [String: String]()
    // The default language is english
    private var currentLanguage : Language = .english
    // Key which will be used to save the default langauge in user defaults
    private var defaultLangaugeKey = "DefaultLanguage"

    /**
     Initializing a new static Localization manager that you can use accross the application to make sure that there is only one localization manager is controlling the translation.
     
     - returns: Static object for the Localization Manager.
     */
    static let sharedInstance: LocalizationManager = {
        let sharedInstance = LocalizationManager()
        return sharedInstance
    }()
    
    override init() {
        super.init()
        
        // Proivde the cached or default values for the langauge selection
        // Intializing the cached langauge dictionary
        currentLanguage = getCachedLanguage()
        let languageAsString: String = currentLanguage.rawValue
        let path: String? = Bundle(for: LocalizationManager.self).path(forResource: languageAsString, ofType: "plist")
        dict = NSDictionary(contentsOfFile: path!) as! [String : String]
    }

    /**
     Will translate the provided key with the currently selected langauge in the application.
     It will return nil if the key is not provided.
     
     - parameter key: The key for the string you want to translate
     
     - returns: Translated string for the provided key or nil if the key doesn't exist in the langauge .plist file.
     */
    func getTranslationForKey(_ key: String) -> String? {
        return dict[key]
    }

    /**
     Provides the current selected langauge in the application.
     
     - returns: current selected langague and it will be an entry from the Language enum.
     */
    func getCurrentLanguage() -> Language {
        return currentLanguage
    }
    
    /**
     Changes the current langauge of the application with the provided language.
     
     - parameter language: An entry from the langauge enum
     */
    func changeCurrentLanguageTo(_ language: Language) {
        currentLanguage = language
        let languageAsString: String = currentLanguage.rawValue
        let path: String? = Bundle(for: LocalizationManager.self).path(forResource: languageAsString, ofType: "plist")
        dict = NSDictionary(contentsOfFile: path!) as! [String : String]
        submitLanguage(currentLanguage)
    }
    
    /**
     Retruns if there is a cached langague .
     
     - returns: true of false based on is there any cached languages exists on the desk.
     */
    func isCachedLanguageExists() -> Bool {
        let myUserDefaults = UserDefaults.standard
        if myUserDefaults.object(forKey: defaultLangaugeKey) == nil {
            return false
        }
        
        return true
    }

    /**
     Private function for submitting language to the user defaults of the application.
     
     - parameter language: An entry from the langauge enum
     */
    private func submitLanguage(_ language: Language) {
        let myUserDefaults = UserDefaults.standard
        let languageAsString: String = currentLanguage.rawValue
        myUserDefaults.removeObject(forKey: defaultLangaugeKey)
        myUserDefaults.setValue(languageAsString, forKey: defaultLangaugeKey)
        myUserDefaults.synchronize()
    }
    
    /**
     Private function for loading the selected langauge from the user defaults and if it's nill it will use enlish as it's default value.
     
     - returns: current cached langague and it will be an entry from the Language enum.
     */
    private func getCachedLanguage() -> Language {
        let myUserDefaults = UserDefaults.standard
        if myUserDefaults.object(forKey: defaultLangaugeKey) == nil {
            return .english
        }
        return Language(rawValue: "\((myUserDefaults.object(forKey: defaultLangaugeKey)!))")!
    }

}
