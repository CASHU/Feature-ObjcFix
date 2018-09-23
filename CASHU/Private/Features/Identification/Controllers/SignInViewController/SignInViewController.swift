//
//  SignInViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var scrollViewContentView : UIView!

    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var emailAddressTitle : UILabel!
    @IBOutlet weak var emailAddressTextField : UITextField!
    @IBOutlet weak var emailAddressTextFieldHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var passwordTitle : UILabel!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var passwordTextFieldHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var signUpTitleLabel : UILabel!
    @IBOutlet weak var signUpButton : UIButton!

    @IBOutlet weak var keypadHandleViewHeightConstraint : NSLayoutConstraint!

    private var didLayoutSubViews = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.setupText()
        self.setupViewOrintationBasedOnLocalization()
        self.setupKeypadListeners()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.dismissKeypad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(!self.didLayoutSubViews){
            ThreadsUtility.execute({
                self.setupBottomBordersForTextFields()
                self.self.setupActionButtons()
            }, afterDelay: 0.1)
            self.didLayoutSubViews = true
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func setupBottomBordersForTextFields(){
        let borderColor = ColorsUtility.colorWithHexString("#127CAE")

        emailAddressTextField.setBottomBorderWithColor(borderColor)
        emailAddressTextField.heightConstraint = emailAddressTextFieldHeightConstraint
        passwordTextField.setBottomBorderWithColor(borderColor)
        passwordTextField.heightConstraint = passwordTextFieldHeightConstraint
    }

    func setupTextFields(){

        if(LocalizationManager.sharedInstance.getCurrentLanguage() != .english){
            emailAddressTextField.textAlignment = .right
            passwordTextField.textAlignment = .right
            emailAddressTitle.textAlignment = .right
            passwordTitle.textAlignment = .right
            titleLabel.textAlignment = .right
            subtitleLabel.textAlignment = .right
        }

        emailAddressTextField.placeholder = LocalizationManager.sharedInstance.getTranslationForKey("SignInEmailAddressPlaceHolder")
        passwordTextField.placeholder = LocalizationManager.sharedInstance.getTranslationForKey("SignInPasswordPlaceHolder")

        UIUtilities.changePlaceHolderTextColorForTextField(emailAddressTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
        UIUtilities.changePlaceHolderTextColorForTextField(passwordTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
    }

    func setupText(){
        self.titleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("SignInTitle")
        self.subtitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("SignInSubtitle")
        self.emailAddressTitle.text = LocalizationManager.sharedInstance.getTranslationForKey("SignInEmailAddressTitle")
        self.passwordTitle.text = LocalizationManager.sharedInstance.getTranslationForKey("SignInPasswordTitle")
        self.signUpTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("SignUpTitle")
    }

    func setupActionButtons(){
        loginButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("SignInButton"), for: .normal)
        UIUtilities.createCircularViewforView(loginButton, withRadius: 6)
        UIUtilities.dropShadowForView(loginButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
        
        signUpButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("SignUpButton"), for: .normal)
        UIUtilities.createCircularViewforView(signUpButton, withRadius: 6)
        UIUtilities.dropShadowForView(signUpButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
    }

    func setupViewOrintationBasedOnLocalization(){
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic){
            self.scrollViewContentView.semanticContentAttribute = .forceRightToLeft
        }
    }

    func setupKeypadListeners(){
        UIUtilities.notifyMeWhenKeyPadWillShow(target: self, selector: #selector(updateViewScroll))
        UIUtilities.notifyMeWhenKeyPadDidChangeFrame(target: self, selector: #selector(updateViewScroll))
        UIUtilities.notifyMeWhenKeyPadWillHide(target: self, selector: #selector(updateViewScroll))

        UIUtilities.addTapGestureToView(self.view, withTarget: self, andSelector: #selector(dismissKeypad), andCanCancelTouchesInTheView: false)
    }

    @objc func dismissKeypad(){
        self.emailAddressTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }

    @objc func updateViewScroll(notification: NSNotification){
        let userInfo = notification.userInfo!

        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        keypadHandleViewHeightConstraint.constant = (view.bounds.maxY - (convertedKeyboardEndFrame.minY))
        AnimationsUtility.animateLayoutFor(self.view, duration: Float(animationDuration), delay: 0.0, completionBlock: nil)
    }

    func isLoginFormValid() -> Bool{
        var isError = false
        if(!ValidationsUtility.isStringNotEmpty(self.emailAddressTextField.text!)){
            self.emailAddressTextField.showErrorMessage(LocalizationManager.sharedInstance.getTranslationForKey("EmailAddressIsRequired")!)
            isError = true
        }

        if(!ValidationsUtility.isStringNotEmpty(self.passwordTextField.text!)){
            self.passwordTextField.showErrorMessage(LocalizationManager.sharedInstance.getTranslationForKey("PasswordIsRequired")!)
            isError = true
        }

        return !isError
    }

    func hideAllErrorMessages(){
        self.emailAddressTextField.hideErrorMessage()
        self.passwordTextField.hideErrorMessage()
    }

    @IBAction func signIn(_ sender: UIButton) {
        self.hideAllErrorMessages()
        if(self.isLoginFormValid()){
            self.dismissKeypad()
            let loginQuery = LoginQuery()
            loginQuery.email = self.emailAddressTextField.text!
            loginQuery.password = self.passwordTextField.text!
            UserIdentificationDataCenter.sharedInstance().signInWithDelegate(self, loginQuery: loginQuery)
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let lang = LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic ? "ar" : "en"
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://www.cashu.com/CLogin/registersForm?lang=\(lang)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "https://www.cashu.com/CLogin/registersForm?lang=\(lang)")!)
        }
    }

    @IBAction func back(_ sender: UIButton) {
        UserIdentificationDataCenter.sharedInstance().cancelInitializationWithDelegate(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToPaymentDetails"){
            if let _ = segue.destination as? PaymentDetailsViewController {
                
            }
        }
    }
}

extension SignInViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.signIn(UIButton())
        return true
    }
}

extension SignInViewController : OperationDelegate{

    func didFinishOperation(_ operationID: OperationID) {

    }

    func didFinishOperation(_ operationID: OperationID, object: AnyObject) {
        if(operationID == .SignIn || operationID == .CancelInitialize){
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
                    }else if(operationID == .SignIn){
                        self.performSegue(withIdentifier: "goToPaymentDetails", sender: nil)
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
