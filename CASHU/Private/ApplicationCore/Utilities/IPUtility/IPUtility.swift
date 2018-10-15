//
//  IPUtility.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/12/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

@objcMembers class IPUtility: NSObject {

    private var IPAddressURL1 = "https://api.ipify.org"
    fileprivate(set) var ipAddress = ""
    
    fileprivate weak var delegate: OperationDelegate?

    
    private static var privateSharedInstance : IPUtility?
    
    class func sharedInstance() -> IPUtility {
        guard let sharedInstance = privateSharedInstance else {
            privateSharedInstance = IPUtility()
            return privateSharedInstance!
        }
        
        return sharedInstance
    }
    
    class func destroy() {
        privateSharedInstance = nil
    }
    
    func getIPAddressWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: IPAddressURL1, requestMethod: .get, parameters: nil, isShowLoading: false, aRequestID: .IPAddressInfo, isACoreRequest: false)
        cr.isCompleteURL = true
        cr.initiateRequest()
    }
    
}


extension IPUtility : ConnectionRequestDelegate{
    
    func requestDidCompleteLoading(request: ConnectionRequest, data: Data) {
        if(request.requestID == .IPAddressInfo){
            self.ipAddress = ParsingUtility.parseDataAsString(data)
            delegate?.didFinishOperation(request.requestID)
        }
    }
    
    func requestDidRecieveError(request: ConnectionRequest, error: Error?) {
        delegate?.didRecieveErrorForOperation(request.requestID, andWithError: error)
    }
    
    func requestDidUploadWithProgress(_ uploadProgress: Float) {
        
    }
    
}
