//
//  UITextFieldExtensions.swift
//
//
//  Created by Ahmed AbdEl-Samie on 2/28/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

let errorBorderColor : UIColor = ColorsUtility.colorWithHexString("#C4141E")
var defaultNormalBorderColor : UIColor = UIColor.white.withAlphaComponent(0.4)
let errorMessageColor : UIColor = ColorsUtility.colorWithHexString("#C4141E")
private let errorFrameHeight : CGFloat = 25.0
private let fontDifferenece : CGFloat = 1.0

private var normalBorderColorKey: UInt8 = 0
private var labelKey: UInt8 = 0
private var heightConstraintKey: UInt8 = 0

extension UITextField {
    private(set) var errorLabel: UILabel? {
        get {
            guard let label = objc_getAssociatedObject(self, &labelKey) as? UILabel else {
                return nil
            }
            return label
        }
        set(newValue) {
            objc_setAssociatedObject(self, &labelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            guard let heightConstraint = objc_getAssociatedObject(self, &heightConstraintKey) as? NSLayoutConstraint else {
                return nil
            }
            return heightConstraint
        }
        set(newValue) {
            objc_setAssociatedObject(self, &heightConstraintKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    var normalBorderColor: UIColor? {
        get {
            guard let normalBorderColor = objc_getAssociatedObject(self, &normalBorderColorKey) as? UIColor else {
                return nil
            }
            return normalBorderColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, &normalBorderColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setBottomBorderWithColor(_ bottomBorderColor : UIColor = defaultNormalBorderColor) {
        if(self.normalBorderColor == nil){
            self.normalBorderColor = bottomBorderColor
        }

        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = bottomBorderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: 1)
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .english){
            border.frame.origin.y -= 5
        }
        border.borderWidth = width
        border.name = "BorderLayer"
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func shake(numberOfShakes shakes: Float, revert: Bool) {
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
    
    func showErrorMessage(_ errorMessage : String, messageColor : UIColor = errorMessageColor) {
        if errorLabel == nil {
            self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
            self.heightConstraint?.constant += errorFrameHeight
            errorLabel = UILabel(frame: CGRect(x:0, y:self.frame.height, width:self.frame.width, height:errorFrameHeight))
            errorLabel?.font = UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! - fontDifferenece)
            errorLabel?.lineBreakMode = .byTruncatingTail
            errorLabel?.adjustsFontSizeToFitWidth = true
            errorLabel?.minimumScaleFactor = 0.3

            if(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic){
                errorLabel?.textAlignment = .right
            }else{
                errorLabel?.textAlignment = .left
            }
            self.addSubview(errorLabel!)
        }
        
        errorLabel?.textColor = messageColor
        errorLabel!.text = errorMessage
        
        self.setBottomBorderWithColor(errorBorderColor)
        AnimationsUtility.animateLayoutFor(self.superview!, duration: 0.2, delay: 0.0) {
            self.shake(numberOfShakes: 3, revert: true)
        }
    }
    
    func hideErrorMessage(){
        if errorLabel != nil {
            errorLabel?.removeFromSuperview()
            errorLabel = nil
            self.heightConstraint?.constant -= errorFrameHeight
            AnimationsUtility.animateLayoutFor(self.superview!, duration: 0.1, delay: 0.0) {
                
            }
            
            if let layers = self.layer.sublayers {
                for layer in layers{
                    if(layer.name == "BorderLayer"){
                        layer.removeFromSuperlayer()
                    }
                }
            }

            self.setBottomBorderWithColor(normalBorderColor!)
        }
    }
}
