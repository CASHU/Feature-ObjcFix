//
//  GeneralDelegates.swift
//  
//
//  Created by Ahmed AbdEl-Samie on 6/4/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation


/**
 This is the main delegate for any outgoing operation from the app
 You can implement this methods to monitor the requests and the response of each one
 It uses the OperationID enum to identify each request
 */
protocol OperationDelegate: NSObjectProtocol {
    /**
     The request operation has been canceled for some reason.
     
     - parameter operationID: The unique ID of the operation which has been canceled.
     */
    func didCancelOperation(_ operationID: OperationID)
    
    /**
     The request operation did finish loading successfully.
     
     - parameter operationID: The unique ID of the operation which has been done.
     */
    func didFinishOperation(_ operationID: OperationID)
    
    /**
     The request operation did finish loading successfully.
     
     - parameter operationID: The unique ID of the operation which has been done.
     - parameter object: an object associated with the operation, usually be a result object.
     */
    func didFinishOperation(_ operationID: OperationID, object : AnyObject)

    /**
     The request operation did failed with an error.
     
     - parameter operationID: The unique ID of the operation which has been failed.
     - parameter operationID: The reason of the failure.
     */
    func didRecieveErrorForOperation(_ operationID: OperationID, andWithError error: Error?)
}
