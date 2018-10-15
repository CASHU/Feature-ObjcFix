//
//  PaymentDetailsViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class PaymentDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var scrollViewContentView : UIView!
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    
    @IBOutlet weak var walletTitleLabel : UILabel!
    @IBOutlet weak var walletBalanceLabel : UILabel!
    @IBOutlet weak var walletBalanceWarningImage : UIImageView!
    @IBOutlet weak var walletBalanceWarningLabel : UILabel!
    @IBOutlet weak var walletBalanceWarningDetailsContainerView : UIView!
    @IBOutlet weak var walletBalanceWarningDetailsLabel : UILabel!
    @IBOutlet weak var walletBalanceContainerView : UIView!
    
    @IBOutlet weak var transactionTitleLabel : UILabel!
    
    @IBOutlet weak var productInfoContainerView : UIView!
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productImage : UIImageView!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var merchantNameTitleLabel : UILabel!
    @IBOutlet weak var merchantNameValueLabel : UILabel!
    
    @IBOutlet weak var actionButton : UIButton!
    
    @IBOutlet weak var totalPaymentContainerView : UIView!
    @IBOutlet weak var totalPaymentLabel : UILabel!
    @IBOutlet weak var totalPaymentCostLabel : UILabel!

    private var didLayoutSubViews = false
    private var isBalanceSuffiecent = true    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let balanceAmount = Double(UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceAmount ?? "0") ?? 0.0
        let productAmount = Double(UserIdentificationDataCenter.sharedInstance().paymentDetails?.amount ?? "0") ?? 0.0
        if(balanceAmount < productAmount){
            isBalanceSuffiecent = false
        }
        
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
        self.titleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("PaymentTitle")
        self.subtitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("PaymentSubtitle")! + " " + (UserIdentificationDataCenter.sharedInstance().accountInfo?.name ?? "")
        
        self.walletTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("WalletTitle")
        self.walletBalanceLabel.text = (UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceAmount ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceCurrency ?? "")
        
        self.walletBalanceWarningLabel.text = isBalanceSuffiecent ? "" :  LocalizationManager.sharedInstance.getTranslationForKey("InsuffecientBalance")
        
        
        self.walletBalanceWarningDetailsLabel.text = isBalanceSuffiecent ? "" :   LocalizationManager.sharedInstance.getTranslationForKey("WalletFund")
        
        self.transactionTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("TransactionDetails")
        self.merchantNameTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("Merchant")
        self.merchantNameValueLabel.text = UserIdentificationDataCenter.sharedInstance().merchantDetails?.merchantName
        
        self.productNameLabel.text = (UserIdentificationDataCenter.sharedInstance().paymentDetails?.displayText ?? "")
        self.productImage.image = CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails.productImage
        self.productPriceLabel.text = (UserIdentificationDataCenter.sharedInstance().paymentDetails?.amount ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().paymentDetails?.currency ?? "")
        self.totalPaymentLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("TotalAmount")
        self.totalPaymentCostLabel.text = (UserIdentificationDataCenter.sharedInstance().paymentDetails?.amount ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().paymentDetails?.currency ?? "")
        
        
        if(isBalanceSuffiecent){
            self.walletBalanceWarningImage.isHidden = true
            self.walletBalanceWarningDetailsContainerView.isHidden = true
        }else{
            self.totalPaymentContainerView.isHidden = true
            self.walletBalanceLabel.textColor = .red
            self.walletBalanceWarningLabel.textColor = .red
            self.productInfoContainerView.alpha = 0.75
        }
        
    }
    
    func setupActionButtons(){
        if(isBalanceSuffiecent){
            actionButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("PayNow"), for: .normal)
        }else{
            actionButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("ReturnTo")! + " " + (UserIdentificationDataCenter.sharedInstance().merchantDetails?.merchantName ?? ""), for: .normal)
            self.actionButton.backgroundColor = ColorsUtility.colorWithHexString("#1DAFEC")
        }
        
        UIUtilities.createCircularViewforView(actionButton, withRadius: 6)
        UIUtilities.dropShadowForView(actionButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
    }
    
    func setupViewOrintationBasedOnLocalization(){
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic){
            self.scrollViewContentView.semanticContentAttribute = .forceRightToLeft
            self.walletBalanceContainerView.semanticContentAttribute = .forceRightToLeft
            self.productInfoContainerView.semanticContentAttribute = .forceRightToLeft
            self.totalPaymentContainerView.semanticContentAttribute = .forceRightToLeft
            
            self.walletBalanceWarningDetailsLabel.textAlignment = .right
            self.productNameLabel.textAlignment = .right
            self.merchantNameValueLabel.textAlignment = .right
        }
    }
    
    
    @IBAction func doAction(_ sender: UIButton) {
        if(isBalanceSuffiecent){
            PaymentDataCenter.sharedInstance().doPaymentWithDelegate(self)
        }else{
            self.back(UIButton())
        }
    }
    
    @IBAction func showInfo(_ sender: UIButton) {
        PopupViewController.showPopupInController(self, title: LocalizationManager.sharedInstance.getTranslationForKey("CashPayments")!, message: LocalizationManager.sharedInstance.getTranslationForKey("CashPaymentsInfo")!, leftButtonTitle: LocalizationManager.sharedInstance.getTranslationForKey("Ok")!, rightButtonTitle: nil)
    }
    
    @IBAction func back(_ sender: UIButton) {
        UserIdentificationDataCenter.sharedInstance().cancelInitializationWithDelegate(self)
    }
}

extension PaymentDetailsViewController : OperationDelegate{
    
    func didFinishOperation(_ operationID: OperationID) {
        
    }
    
    func didFinishOperation(_ operationID: OperationID, object: AnyObject) {
        if(operationID == .CompletePayment || operationID == .CancelInitialize){
            if let cashuResponse = object as? CASHUResponse {
                if(cashuResponse.cashuBodyResponse.resultCode != "200"){
                    var message = ""
                    switch CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.language{
                    case .arabic:
                        message = cashuResponse.cashuBodyResponse.resultMessageAr
                    case.english:
                        message = cashuResponse.cashuBodyResponse.resultMessageEn
                    }
                    
                    PopupViewController.showPopupInController(self, title: LocalizationManager.sharedInstance.getTranslationForKey("Error")!, message: message, leftButtonTitle: LocalizationManager.sharedInstance.getTranslationForKey("Ok")!, rightButtonTitle: nil)
                    
                    if CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.isLoggingEnabled {
                        NSLog("***!!!*** CASHU Error : ***!!!*** \n\(cashuResponse.cashuBodyResponse.resultMessageError)")
                    }
                }else{
                    if(operationID == .CancelInitialize){
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
                    }else if(operationID == .CompletePayment){
                        self.performSegue(withIdentifier: "goToSuccessPage", sender: nil)
                    }
                }
            }
        }
    }
    
    func didRecieveErrorForOperation(_ operationID: OperationID, andWithError error: Error?) {
        
    }
    
    func didCancelOperation(_ operationID: OperationID) {
        
    }
}
