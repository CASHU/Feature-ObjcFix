//
//  UserIdentificationDataCenter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class UserIdentificationDataCenter: NSObject {
    
    private var authenticationURL = "common/authenticate"
    private var initializationURL = "mobileSDK_Services/sdkPaymentInitialize"
    private var signInURL = "mobileSDK_Services/sdkLogin"
    private var cancelInitializeURL = "mobileSDK_Services/sdkCancel"
    
    
    fileprivate weak var delegate: OperationDelegate?

    private static var privateSharedInstance : UserIdentificationDataCenter?
    private(set) var cashuToken: CASHUToken?
    private(set) var cashuSDKToken: CASHUSDKToken?
    private(set) var paymentDetails: PaymentDetails?
    private(set) var merchantDetails: MerchantDetails?
    private(set) var accountInfo: AccountInfo?
    
    class func sharedInstance() -> UserIdentificationDataCenter {
        guard let sharedInstance = privateSharedInstance else {
            privateSharedInstance = UserIdentificationDataCenter()
            return privateSharedInstance!
        }
        
        return sharedInstance
    }
    
    class func destroy() {
        privateSharedInstance = nil
    }
    
    func authenticateWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        let parameters : [String:String] = ["Area":"ios",
                                            "AreaVersion":"1.01",
                                            "Key":BackEndConfigurations.key(),
                                            "Username":BackEndConfigurations.userName()]
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: authenticationURL, requestMethod: .post, parameters: parameters, isShowLoading: false, aRequestID: .Authenticate, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
    
    func initializeWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        var parameters : [String:Any] = ["Client_ID":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.clientID,
                                            "Merchant_Ref":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.merchantReference,
                                            "Env":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.environment == .dev ? "SAND" : "PROD",
                                            "Device_Id":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.deviceID,
                                            "Lang":LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic ? "AR" : "EN"]
        
        let paymentObject : String = "{\"currency\" : \(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails.currency == .usd ? "\"USD\"" : "\"AED\""),\"amount\":\"\(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails.price)\",\"displayText\":\"\(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails.productName)\",\"language\":\(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic ? "\"AR\"" : "\"EN\""),\"servicesName\" : \"SDK\",\"sessionID\" : \"\",\"txt1\" : \"\(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails.productName)\",\"txt2\" : \"\",\"txt3\" : \"\",\"txt4\" : \"\",\"txt5\" : \"\"}"
        
        parameters ["Pay_Obj"] = paymentObject
        
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: initializationURL, requestMethod: .post, parameters: parameters, isShowLoading: false, aRequestID: .Initialize, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
    
    func cancelInitializationWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        let parameters : [String:String] = ["cancelType":"Login",                                            "Env":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.environment == .dev ? "SAND" : "PROD",
                                            "SDK_Token":self.cashuSDKToken?.token ?? ""]
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: cancelInitializeURL, requestMethod: .post, parameters: parameters, isShowLoading: true, aRequestID: .CancelInitialize, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
    
    
    func signInWithDelegate(_ delegate: OperationDelegate?, loginQuery : LoginQuery){
        self.delegate = delegate
        
        let parameters : [String:String] = ["Email":loginQuery.email,
                                            "Password":loginQuery.password.md5 ?? "",
                                            "Env":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.environment == .dev ? "SAND" : "PROD",
                                            "SDK_Token":self.cashuSDKToken?.token ?? ""]
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: signInURL, requestMethod: .post, parameters: parameters, isShowLoading: true, aRequestID: .SignIn, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
}


extension UserIdentificationDataCenter : ConnectionRequestDelegate{
    
    func requestDidCompleteLoading(request: ConnectionRequest, data: Data) {
        let response = ParsingUtility.parseDataAsDictionary(data)
        let cashuResponse : CASHUResponse = CASHUResponse(data: response)
        
        if(request.requestID == .Authenticate){
            if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                self.cashuToken = CASHUToken(data: cashuResponse.cashuBodyResponse.data)
            }
            delegate?.didFinishOperation(request.requestID, object: cashuResponse)
        }else if(request.requestID == .Initialize){
            if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                self.cashuSDKToken = CASHUSDKToken(data: cashuResponse.cashuBodyResponse.data)
                self.paymentDetails = PaymentDetails(data: cashuResponse.cashuBodyResponse.data)
                self.merchantDetails = MerchantDetails(data: cashuResponse.cashuBodyResponse.data)
            }
            delegate?.didFinishOperation(request.requestID, object: cashuResponse)
        }else if(request.requestID == .SignIn){
            if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                self.accountInfo = AccountInfo(data: cashuResponse.cashuBodyResponse.data)
            }
            delegate?.didFinishOperation(request.requestID, object: cashuResponse)
        }else if(request.requestID == .CancelInitialize){
            delegate?.didFinishOperation(request.requestID, object: cashuResponse)
        }
    }
    
    func requestDidRecieveError(request: ConnectionRequest, error: Error?) {
        delegate?.didRecieveErrorForOperation(request.requestID, andWithError: error)
    }
    
    func requestDidUploadWithProgress(_ uploadProgress: Float) {
        
    }
    
}
