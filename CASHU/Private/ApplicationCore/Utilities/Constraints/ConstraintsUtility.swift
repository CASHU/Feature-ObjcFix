//
//  ConstraintsUtility.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/27/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation
import UIKit

/**
 This class provides an easy way to add constrains to views using code.
 It's a utility class with static methods.
 */
@objcMembers class ConstraintsUtility: NSObject {
    
    /**
     Add width constraint to a view.
     
     - parameter view: The view you want to add the constraint to it.
     - parameter width: The width as constant value for the constraint
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addWidthConstraintTo(_ view: UIView, width: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(width))
        view.addConstraint(widthConstraint)
        return widthConstraint
    }

    /**
     Add height constraint to a view.
     
     - parameter view: The view you want to add the constraint to it.
     - parameter height: The height as constant value for the constraint
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addHeightConstraintTo(_ view: UIView, height: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(height))
        view.addConstraint(heightConstraint)
        return heightConstraint
    }
    
    
    /**
     Add Vertical Alignment constraint to a view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addVerticalAlignmentConstraintTo(superView: UIView, view: UIView, relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let verticalAlignmentConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: relation, toItem: relatedView, attribute: .centerX, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(verticalAlignmentConstraint)
        return verticalAlignmentConstraint

    }
    
    /**
     Add horizontal Alignment constraint to a view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addHorizontalAlignmentConstraintTo(superView: UIView, view: UIView, relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let verticalAlignmentConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: relation, toItem: relatedView, attribute: .centerX, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(verticalAlignmentConstraint)
        return verticalAlignmentConstraint
        
    }

    /**
     Add top constraint to a view.

     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addTopConstraintTo(superView: UIView, view: UIView, relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: relation, toItem: relatedView, attribute: .top, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(topConstraint)
        return topConstraint
    }
    
    /**
     Add top constraint to a view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addTopConstraintToBottom(superView: UIView, view: UIView, relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: relation, toItem: relatedView, attribute: .bottom, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(topConstraint)
        return topConstraint
    }

    /**
     Add bottom constraint to a view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addBottomConstraintTo(superView: UIView, view: UIView, relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: relation, toItem: relatedView, attribute: .bottom, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(bottomConstraint)
        return bottomConstraint
    }

    /**
     Add leading constraint to a view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addLeadingConstraintTo(superView: UIView, view: UIView,  relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let leadingConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: relation, toItem: relatedView, attribute: .leading, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(leadingConstraint)
        return leadingConstraint
    }

    /**
     Add trailing constraint to a view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     
     - returns: Initialized constraint after being added to the view
     */
    @discardableResult class func addTrailingConstraintTo(superView: UIView, view: UIView,  relatedView: UIView, constant: Double, relation: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: relation, toItem: relatedView, attribute: .trailing, multiplier: 1.0, constant: CGFloat(constant))
        superView.addConstraint(trailingConstraint)
        return trailingConstraint
    }

    /**
     Add surrounding constraints to a view with another view.
     
     - parameter superView: The view you want to add the constraint to it.
     - parameter view: The first view that you want the constrain to hold
     - parameter relatedView: The releated view to the view that you want the constrain to hold
     - parameter constant: The constant value for the constraint.
     - parameter relation: The releation of the constraints
     */
    class func addSurroundingConstraintsTo(superView: UIView, view: UIView, relatedView: UIView, withConstant constant: Double, relation: NSLayoutConstraint.Relation) {
        addTopConstraintTo(superView: superView, view: view, relatedView: relatedView, constant: constant, relation: relation)
     
        addBottomConstraintTo(superView: superView, view: view, relatedView: relatedView, constant: constant, relation: relation)
        addLeadingConstraintTo(superView: superView, view: view, relatedView: relatedView, constant: constant, relation: relation)
        addTrailingConstraintTo(superView: superView, view: view, relatedView: relatedView, constant: constant, relation: relation)
    }
}
