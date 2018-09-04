//
//  LoadingView.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/30/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import UIKit

/**
 Loading View is a shared instance class which is responsible for showing the loading screen over the current screen.
 It uses the window of the application to add the loading screen.
 There is two different types of Loading, You can block the screen and don't allow the user to interact or you can show it without blocking the screen and the user still can interact with the rest of the application and in that case you need to hide it manually.
 */
class LoadingView: UIView {
    /**
     Spinner background
     */
    @IBOutlet weak var loadingSpinnerBackground: UIImageView!
    /**
     Screen background
     */
    @IBOutlet weak var backgroundImage: UIImageView!

    /**
     Initializing a new static loading view that you can use accross the application to make sure that there is only one loading view will be shown.
     
     - returns: Static object for the loading view.
     */
    @objc static let sharedInstance: LoadingView = {
        let sharedInstance : LoadingView = LoadingView.instantiateFromXib()
        // styling the corner radius of the loading spinner background
        sharedInstance.loadingSpinnerBackground?.layer.cornerRadius = 10
        return sharedInstance
    }()
    
    /**
     Initializing a new loading view from the xib file.
     
     - returns: New instance of loading view from xib.
     */
    class func instantiateFromXib()-> LoadingView{
        return Bundle(for: LoadingView.self).loadNibNamed("LoadingView", owner: self, options: nil)?.first as! LoadingView;
    }

    /**
     Show the loading view above the current window, The user won't be able to interact with the application, The loading view will be in blocking mode.
     
     It will be added over the whole screens of the application, with zIndex 0.
     */
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        ConstraintsUtility.addSurroundingConstraintsTo(superView: UIApplication.shared.keyWindow!, view: self, relatedView: UIApplication.shared.keyWindow!, withConstant: 0, relation: .equal)
    }

    /**
     Show the loading view above the current window, The user will still be able to interact with the application, The loading view will be in non-blocking mode.
     You need to hide it manually.
     
     It will be added over the whole screens of the application, with zIndex 0.
     */
    @objc func showWithoutBlockingScreen() {
        UIApplication.shared.keyWindow?.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        ConstraintsUtility.addSurroundingConstraintsTo(superView: UIApplication.shared.keyWindow!, view: self, relatedView: UIApplication.shared.keyWindow!, withConstant: 0, relation: .equal)
        isUserInteractionEnabled = false
        backgroundImage?.isHidden = true
    }

    /**
     Show the loading view above the passed  parent view, The user won't be able to interact with the application, The loading view will be in blocking mode.
     
     - parameter parentView: The view which will the loading view will appear above
     */
    func showInParentView(_ parentView: UIView) {
        parentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        ConstraintsUtility.addSurroundingConstraintsTo(superView: parentView, view: self, relatedView: parentView, withConstant: 0, relation: .equal)
    }

    /**
     Hide the loading view either in blocking or non-blocking mode.
     
     It will hide the loading view and enable the interaction for the application again.
     */
    @objc func hide() {
        removeFromSuperview()
        isUserInteractionEnabled = true
        backgroundImage?.isHidden = false
    }
}
