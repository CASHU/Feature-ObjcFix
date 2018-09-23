//
//  AnimationsUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/25/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import UIKit

/**
 This class provides an easy way to animate views.
 It's a utility class with static methods.
 */
class AnimationsUtility: NSObject {
    
    /**
     Animate layout change for a view.
     
     - parameter view: The view you want to animate the layout changes in it.
     - parameter duration: The duration for the animation.
     - parameter delay: The delay before starting the animation.
     - parameter completionBlock: The block which will be executed after the animation is completed
     */
    class func animateLayoutFor(_ view: UIView, duration: Float, delay: Float, completionBlock: (() -> Void)?) {
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: .curveEaseOut, animations: {() -> Void in
            view.layoutIfNeeded()
        }, completion: {(_ finished: Bool) -> Void in
            if completionBlock != nil {
                completionBlock!()
            }
        })
    }

    /**
     Animate change of transperancy for a view.
     
     - parameter alpha: The new alpha for the view.
     - parameter view: The view you want to animate the transperancy in it.
     - parameter duration: The duration for the animation.
     - parameter completionBlock: The block which will be executed after the animation is completed
     */
    class func animateViewTransperancy(alpha: Float, view: UIView, duration: Float, completionBlock:(() -> Void)?) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {() -> Void in
            view.alpha = CGFloat(alpha)
        }, completion: {(_ finished: Bool) -> Void in
            if completionBlock != nil {
                completionBlock!()
            }
        })
    }

    /**
     Animate change of frame for a view.
     
     - parameter view: The view you want to animate the frame changes in it.
     - parameter frame: The new frame for the view.
     - parameter duration: The duration for the animation.
     - parameter completionBlock: The block which will be executed after the animation is completed
     */
    class func animateChangeFrameFor(_ view: UIView, frame: CGRect, duration: Float, completionBlock: (() -> Void)?) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {() -> Void in
            view.frame = frame
        }, completion: {(_ finished: Bool) -> Void in
            if completionBlock != nil {
                completionBlock!()
            }
        })
    }

    /**
     Animate text change for a button.
     
     - parameter button: The button you want to animate the change of text in it.
     - parameter duration: The duration for the animation.
     - parameter transationType: The transation type for the animation.
     */
    class func animateTextForButton(_ button: UIButton, duration: Double, transationType: String) {
    
        button.layer.add(transationAnimationWith(duration: duration, transationType: transationType), forKey: "animation")
    }

    /**
     Animate text change for a label.
     
     - parameter label: The label you want to animate the change of text in it.
     - parameter duration: The duration for the animation.
     - parameter transationType: The transation type for the animation.
     */
    class func animateTextForLabel(_ label: UIView, duration: Double, transationType: String) {
        label.layer.add(self.transationAnimationWith(duration: duration, transationType: transationType), forKey: "animation")
    }

    /**
     Animate view appearance in it's superview with pop in effect.
     
     - parameter view: The view you want to animate.
     - parameter duration: The duration for the animation.
     - parameter delay: The delay before starting the animation.
     - parameter completionBlock: The block which will be executed after the animation is completed
     */
    class func animatePopInEffectFor(view: UIView, duration: Float, delay: Float, completionBlock: (() -> Void)?) {
        view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        view.isHidden = false
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: .curveEaseOut, animations: {() -> Void in
            view.transform = CGAffineTransform.identity
        }, completion: {(_ finished: Bool) -> Void in
            if completionBlock != nil {
                completionBlock!()
            }
        })
    }

    /**
     Animate view appearance in it's superview with pop out effect.
     PLEASE note that view must be hidden before calling this method.
     
     - parameter view: The view you want to animate.
     - parameter duration: The duration for the animation.
     - parameter delay: The delay before starting the animation.
     - parameter completionBlock: The block which will be executed after the animation is completed
     */
    class func animatePopOutEffectFor(_ view: UIView, duration: Float, delay: Float, completionBlock: (() -> Void)?) {
        view.isHidden = false
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: .curveEaseOut, animations: {() -> Void in
            view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: {(_ finished: Bool) -> Void in
            view.transform = CGAffineTransform.identity
            view.isHidden = true
            if completionBlock != nil {
                completionBlock!()
            }
        })
    }
    
    /**
     Animate view appearance in it's superview with pop up effect. 
     
     - parameter view: The view you want to animate.
     */
    class func animatePopUpAndBounceEffectFor(_ view: UIView) {
        view.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.3 / 1.5, animations: {() -> Void in
            view.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.3 / 2, animations: {() -> Void in
                view.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }, completion: {(_ finished: Bool) -> Void in
                UIView.animate(withDuration: 0.3 / 2, animations: {() -> Void in
                    view.transform = CGAffineTransform.identity
                })
            })
        })
    }

    /**
     Animate view appearance in it's superview with push effect.
     
     - parameter view: The view you want to animate.
     - parameter duration: The duration for the animation.
     */
    class func animatePushEffectFor(_ view: UIView, withDuration duration: Float) {
        let applicationLoadViewIn = CATransition()
        applicationLoadViewIn.duration = CFTimeInterval(duration)
        applicationLoadViewIn.type = CATransitionType.push
        applicationLoadViewIn.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        view.layer.add(applicationLoadViewIn, forKey: CATransitionType.push.rawValue)
    }

    /**
     Animate a block.
     
     - parameter animationBlock: The block of code you want to animate.
     - parameter duration: The duration for the animation.
     - parameter completionBlock: The block which will be executed after the animation is completed     
     */
    class func animateBlock(_ animationBlock: @escaping () -> Void, duration: Float, completionBlock: (() -> Void)?) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {() -> Void in
            animationBlock()
        }, completion: {(_ finished: Bool) -> Void in
            if completionBlock != nil {
                completionBlock!()
            }
        })
    }

    /**
     Private helper method for animating text change in different type of views.
     
     - parameter duration: The duration for the animation.
     - parameter transationType: The transation type for the animation.
     
     - returns: animation intialized with provided info
     */
    private class func transationAnimationWith(duration: Double, transationType: String) -> CATransition {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType(rawValue: transationType)
        animation.duration = duration
        return animation
    }
}
