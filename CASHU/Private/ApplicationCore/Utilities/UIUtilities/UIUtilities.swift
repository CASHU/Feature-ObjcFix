//
//  UIUtilities.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/29/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//


import Foundation
import QuartzCore
import UIKit

/**
 This class provides an easy way to deal with different UI Utilities.
 It's a utility class with static methods.
 */
class UIUtilities: NSObject {
    
    /**
     Finds the first responder inside a view.
     
     - parameter view: The view to search for the first responder
     
     - returns: The view which is the first responder or nil if we can't find it.
     */
    class func findFirstResponderInView(_ view: UIView) -> UIView? {
        for subView: UIView in view.subviews {
            if subView.isFirstResponder {
                return subView
            }
        }
        return nil
    }

    /**
     Notify the target when the keyboard will show.
     
     - parameter target: The target to be notified when the keyboard will show
     - parameter selector: The method which will be called when the keyboard will show
     */
    class func notifyMeWhenKeyPadWillShow(target: Any, selector: Selector) {
        NotificationCenter.default.addObserver(target, selector: selector, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    /**
     Notify the target when the keyboard will hide.
     
     - parameter target: The target to be notified when the keyboard will hide
     - parameter selector: The method which will be called when the keyboard will hide
     */
    class func notifyMeWhenKeyPadWillHide(target: Any, selector: Selector) {
        NotificationCenter.default.addObserver(target, selector: selector, name: UIResponder.keyboardWillHideNotification , object: nil)
    }

    /**
     Notify the target when the keyboard will change it's frame.
     
     - parameter target: The target to be notified when the keyboard will change it's frame
     - parameter selector: The method which will be called when the keyboard will change it's frame
     */
    class func notifyMeWhenKeyPadWillChangeFrame(target: Any, selector: Selector) {
        NotificationCenter.default.addObserver(target, selector: selector, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    /**
     Notify the target when the keyboard did change it's frame.
     
     - parameter target: The target to be notified when the keyboard did change it's frame
     - parameter selector: The method which will be called when the keyboard did change it's frame
     */
    class func notifyMeWhenKeyPadDidChangeFrame(target: Any, selector: Selector) {
        NotificationCenter.default.addObserver(target, selector: selector, name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }

    /**
     Rotate view 90 degrees anti clockwise.
     
     - parameter view: The view to be rotated
     */
    class func rotateView90DegreeAntiClockWise(_ view: UIView) {
        view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
    }

    /**
     Rotate view 90 degrees clockwise.
     
     - parameter view: The view to be rotated
     */
    class func rotateView90DegreeClockWise(_ view: UIView) {
        view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
    }

    /**
     Rotate view with specific degrees.
     
     - parameter view: The view to be rotated
     - parameter degree: The degrees to rotate the view with
     */
    class func rotateView(_ view: UIView, withDegrees degree: Double) {
        view.transform = CGAffineTransform(rotationAngle: CGFloat(degree))
    }

    /**
     Restore the intial transofrmation form for a specific view.
     
     - parameter view: The view to be restored
     */
    class func resetRotationToInitialFormFor(_ view: UIView) {
        view.transform = CGAffineTransform.identity
    }

    /**
     Create circular view from a specific view.
     
     - parameter view: The view to circular
     */
    class func createCircularView(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.size.width / 2
    }

    /**
     Create circular view from a specific view.
     
     - parameter view: The view to circular
     - parameter radius: The radius of the circle
     */
    class func createCircularViewforView(_ view: UIView, withRadius radius: Int) {
        view.clipsToBounds = true
        view.layer.cornerRadius = CGFloat(radius)
    }

    /**
     Create top left circular view from a specific view.
     
     - parameter view: The view to circular
     - parameter radius: The radius of the circle
     */
    class func createTopCircularViewForView(_ view: UIView, withRadius radius: Int) {
        view.clipsToBounds = true
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: ([.topLeft, .topRight]), cornerRadii: CGSize(width: CGFloat(radius), height: CGFloat(radius)))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }

    /**
     Sets padding to a text field.
     
     - parameter textField: The text field that you want to add the padding to it
     - parameter frame: The padding as a frame
     */
    class func setPaddingToTextField(_ textField: UITextField, withFrame frame: CGRect) {
        let paddingView = UIView(frame: frame)
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    /**
     Sets right padding to a text field.
     
     - parameter textField: The text field that you want to add the padding to it
     - parameter frame: The padding as a frame
     */
    class func setRightPaddingToTextField(_ textField: UITextField, withFrame frame: CGRect) {
        let paddingView = UIView(frame: frame)
        textField.rightView = paddingView
        textField.rightViewMode = .always
    }
    
    /**
     Sets padding to a text view.
     
     - parameter textView: The text view that you want to add the padding to it
     - parameter insets: The insets for the padding
     */
    class func setPaddingToTextView(_ textView: UITextView, with insets: UIEdgeInsets) {
        textView.textContainerInset = insets
    }

    /**
     Changes the place holder text color of a text field.
     
     - parameter textField: The text view that you want to add the padding to it
     - parameter color: The new color for the place holder text
     */
    class func changePlaceHolderTextColorForTextField(_ textField: UITextField, color: UIColor) {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    /**
     Add tap gesture recognizer to a view.
     
     - parameter view: The view to add the tap gesture on it
     - parameter target: The target to be notified when the user taps on the screen
     - parameter selector: The method which will be called when the user taps on the screen
     - parameter isCancelTouchesInTheView: The screen will not recieve the touch or not
     */
    class func addTapGestureToView(_ view: UIView, withTarget target: Any, andSelector selector: Selector, andCanCancelTouchesInTheView isCancelTouchesInTheView: Bool) {
        view.isUserInteractionEnabled = true
        let tapper = UITapGestureRecognizer(target: target, action: selector)
        tapper.cancelsTouchesInView = isCancelTouchesInTheView
        view.addGestureRecognizer(tapper)
    }

    /**
     Add tap gesture recognizer to a view.
     
     - parameter view: The view to add the tap gesture on it
     - parameter target: The target to be notified when the user taps on the screen
     - parameter selector: The method which will be called when the user taps on the screen
     - parameter canCancelTouchesInTheView: The screen will not recieve the touch or not
     - parameter numberOfTabsRequired: The number of touches required to fire the selector
     */
    class func addTapGestureToView(_ view: UIView, withTarget target: Any, andSelector selector: Selector, andCanCancelTouchesInTheView canCancelTouchesInTheView: Bool, andNumberOfTabsRequired numberOfTabsRequired: Int) {
        view.isUserInteractionEnabled = true
        let tapper = UITapGestureRecognizer(target: target, action: selector)
        tapper.numberOfTapsRequired = numberOfTabsRequired
        tapper.cancelsTouchesInView = canCancelTouchesInTheView
        view.addGestureRecognizer(tapper)
    }

    /**
     Add swipe gesture to a view.
     
     - parameter view: The view to add the tap gesture on it
     - parameter target: The target to be notified when the user swipe on the screen
     - parameter selector: The method which will be called when the user swipe on the screen
     - parameter isCanCancelTouchesInTheView: The screen will not recieve the touch or not
     - parameter numberOfTouchesRequired: The number of touches required to fire the selector
     - parameter direction: The direction of swiping to fire the selector
     */
    class func addSwipeGestureToView(_ view: UIView, withTarget target: Any, andSelector selector: Selector, andCanCancelTouchesInTheView isCanCancelTouchesInTheView: Bool, andNumberOfTouchesRequired numberOfTouchesRequired: Int, andWith direction: UISwipeGestureRecognizer.Direction) {
        let swipper = UISwipeGestureRecognizer(target: target, action: selector)
        swipper.numberOfTouchesRequired = numberOfTouchesRequired
        swipper.direction = direction
        swipper.cancelsTouchesInView = isCanCancelTouchesInTheView
        view.addGestureRecognizer(swipper)
    }

    /**
     Add blur effect to a view.
     
     - parameter view: The view to add the blur on it
     */
    class func addBlurEffectToView(_ view: UIView) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = UIColor.clear
            view.alpha = 1
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = 0.9
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
        }
    }

    /**
     Create a distinct copy of a view.
     
     - parameter view: The view to create the copy from it
     
     - returns: A new fresh copy of the provided view.
     */
    class func makeACopyOfView(_ view: UIView) -> Any {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: view)
        let copyOfView: Any? = NSKeyedUnarchiver.unarchiveObject(with: archivedData)
        return copyOfView!
    }

    /**
     Fade the scroll view from the top.
     
     - parameter scrollView: The scroll view to fade
     - parameter opacity: The opacity of fading
     - parameter scrollViewcontentSize: The scroll view content size
     */
    class func makeScrollView(_ scrollView: UIScrollView, fadeFromTopWithOpacity opacity: Float, withContentSize scrollViewcontentSize: CGSize) {
        let transparent: CGColor = UIColor(white: CGFloat(0), alpha: CGFloat(0)).cgColor
        let opaque: CGColor = UIColor(white: CGFloat(0), alpha: CGFloat(1)).cgColor
        let maskLayer = CALayer()
        maskLayer.frame = scrollView.bounds
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: CGFloat(scrollView.bounds.origin.x), y: CGFloat(0), width: CGFloat(scrollViewcontentSize.width), height: CGFloat(scrollViewcontentSize.height))
        gradientLayer.colors = [transparent, opaque]
        gradientLayer.locations = [0, NSNumber(floatLiteral: Double(opacity))]
        maskLayer.addSublayer(gradientLayer)
        scrollView.layer.mask = maskLayer
    }

    /**
     Check if scroll view did hit the end of it's content or not.
     
     - parameter scrollView: The scroll view to check on its content size
     - parameter offset: The offset value if you need to add or substract margines
     
     - returns: True or false based on the scroll view did hit the end of it's content or not.
     */
    class func isScrollViewHitsEndOfScrollContent(_ scrollView: UIScrollView, offset: CGFloat = 0) -> Bool {
        if(scrollView.contentSize.height < scrollView.frame.size.height){
            return false
        }
        let bottomEdge: CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge - offset >= scrollView.contentSize.height {
            return true
        }
        return false
    }

    /**
     Apply a color as mask on image.

     - parameter color: The color of the mask
     - parameter image: The image to apply the color on it
     
     - returns: The image after applying the color masking on it.
     */
    class func applyColor(_ color: UIColor, to image: UIImage) -> UIImage {
        let rect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.width), height: CGFloat(image.size.height))
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.clip(to: rect, mask: image.cgImage!)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let coloredImage = UIImage(cgImage: img.cgImage!, scale: 1.0, orientation: .downMirrored)
        return coloredImage
    }

    /**
     Change image insets of a button.
     
     - parameter button: The button to change the insets of its image
     - parameter top: The top inset
     - parameter bottom: The bottom inset
     - parameter left: The left inset
     - parameter right: The right inset
     */
    class func setImageEdgeInsetsForButton(_ button: UIButton, withTop top: CGFloat, andBottom bottom: CGFloat, andLeft left: CGFloat, andRight right: CGFloat) {
        button.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /**
     Drops a shadow over the bottom of a view.
     
     - parameter view: The view to drop the shadow on it
     - parameter shadowColor: The shadow color
     - parameter shadowOpacity: The shadow opacity
     - parameter isMaskToBounds: Mask the shadow to the bounds or not
     */
    class func dropShadowForView(_ view: UIView, withShadowColor shadowColor: UIColor, andShadowOpacity shadowOpacity: Float, andMaskToBounds isMaskToBounds: Bool) {
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = isMaskToBounds
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(5.0))
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowPath = shadowPath.cgPath
    }

    /**
     Set a gradient background to a view.
     
     - parameter view: The view to add the background for it
     - parameter startingColor: The starting color of the gradient
     - parameter endingColor: The ending color of the gradient
     */
    class func setGradientBackgroundForView(_ view: UIView, withStarting startingColor: UIColor, andEnding endingColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [startingColor.cgColor, endingColor.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

    /**
     Flips an image horizontally.
     
     - parameter image: The image to flip
     
     - returns: The image after flipping.
     */
    class func flipImageHorizontally(_ image: UIImage) -> UIImage {
        return UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .upMirrored)
    }

    /**
     Add a tool bar for input fields.
     
     - parameter inputFields: The input fields to add the toolbar for it
     - parameter target: The target to be notified when the segment controll is tapped
     - parameter segmentChangeSelector: The selector to be executed when the segment changed
     - parameter doneSelector: The selector to be executed when the user taps on done button
    
     - returns: The segment control of the toolbar.
     */
    class func addToolbarForInputFieldsInOrder(_ inputFields: [Any], withTarget target: Any, andSegmentChange segmentChangeSelector: Selector, andDoneButtonSelector doneSelector: Selector) -> UISegmentedControl {
        let toolbar = UIToolbar()
        toolbar.barStyle = .blackTranslucent
        toolbar.sizeToFit()
        let segControl = UISegmentedControl(items: [LocalizationManager.sharedInstance.getTranslationForKey("Previous") ?? "", LocalizationManager.sharedInstance.getTranslationForKey("Next") ?? ""] )
        segControl.isMomentary = true
        segControl.tag = 0
        segControl.addTarget(target, action: segmentChangeSelector, for: (.valueChanged))
        segControl.setEnabled(false, forSegmentAt: 0)
        let nextButton = UIBarButtonItem(customView: segControl)
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: doneSelector)
        let itemsArray: [UIBarButtonItem] = [nextButton, flexButton, doneButton]
        toolbar.items = itemsArray
        for inputField: Any in inputFields {
            if (inputField is UITextField) {
                (inputField as? UITextField)?.inputAccessoryView = toolbar
            }
        }
        return segControl
    }
}
