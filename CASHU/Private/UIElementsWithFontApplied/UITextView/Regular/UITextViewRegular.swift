//
//  UITextViewLight.swift
//  
//
//  Created by Ahmed Abd El-Samie on 31/5/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import UIKit

/**
 UITextView with the font applied based on the current selected langauge from the localization manager
 Different Languages may have different fonts
 */
@objcMembers class UITextViewLight: UITextView {
    override func awakeFromNib() {
        super.awakeFromNib()
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .english){
            font = UIFont(name: "Helvetica", size: CGFloat((font?.pointSize)!))
        }else{
            font = UIFont(name: "DroidArabicKufi", size: CGFloat((font?.pointSize)!))
        }
    }
}
