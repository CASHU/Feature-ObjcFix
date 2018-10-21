//
//  PaymentSuccessViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/20/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers class PaymentSuccessViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var scrollViewContentView : UIView!
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var transactionInfo : UILabel!
    @IBOutlet weak var transactionID : UILabel!
    @IBOutlet weak var afterTransactionInfo : UILabel!
    
    @IBOutlet weak var actionButton : UIButton!
    
    private var didLayoutSubViews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupText()
        self.setupViewOrintationBasedOnLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(!self.didLayoutSubViews){
            ThreadsUtility.execute({
                self.self.setupActionButtons()
            }, afterDelay: 0.1)
            self.didLayoutSubViews = true
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    func setupText(){
        self.titleLabel.text = (UserIdentificationDataCenter.sharedInstance().accountInfo?.name ?? "") + ", " + LocalizationManager.sharedInstance.getTranslationForKey("PaymentCompleted")!
        self.transactionInfo.text = LocalizationManager.sharedInstance.getTranslationForKey("TransactionInfo")!
        self.afterTransactionInfo.text = LocalizationManager.sharedInstance.getTranslationForKey("AfterTransactionInfo")
    }
    
    func setupActionButtons(){
        actionButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("ReturnTo")! + " " + (UserIdentificationDataCenter.sharedInstance().merchantDetails?.merchantName ?? ""), for: .normal)
        UIUtilities.createCircularViewforView(actionButton, withRadius: 6)
        UIUtilities.dropShadowForView(actionButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
    }
    
    func setupViewOrintationBasedOnLocalization(){
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic){
            self.scrollViewContentView.semanticContentAttribute = .forceRightToLeft
            
            self.afterTransactionInfo.textAlignment = .right
        }
    }
    
    
    @IBAction func doAction(_ sender: UIButton) {
        if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.presentingMethod == .push){
            var found = false
            for viewController in (self.navigationController?.viewControllers.reversed())! {
                if(viewController is InitializationViewController){
                    found = true
                    continue
                }
                
                if(found){
                    self.navigationController?.isNavigationBarHidden = false
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }else if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.presentingMethod == .present){
            self.dismissAnimated()
        }
    }
}
