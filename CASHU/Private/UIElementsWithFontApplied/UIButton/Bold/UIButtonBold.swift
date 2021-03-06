//
//  UIButtonBold.swift
//  
//
//  Created by Ahmed Abd El-Samie on 31/5/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import UIKit

/**
 UIButton with the font applied based on the current selected langauge from the localization manager
 Different Languages may have different fonts
 */
class UIButtonBold: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .english){
            titleLabel?.font = UIFont(name: "Helvetica-Bold", size: CGFloat((titleLabel?.font?.pointSize)!))
        }else{
            titleLabel?.font = UIFont(name: "DroidArabicKufi-Bold", size: CGFloat((titleLabel?.font?.pointSize)!))
        }
    }
}
