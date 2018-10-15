//
//  ConnectionManager.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/20/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation
import UIKit

/**
 Connection Manager is a static singelton class which is responsible for any request that will go out from the application and also for any data the application will recieve.
 PLEASE use the shared instance to make sure that the application requests and data will be handled by only one static manager.
 The class produced the core requests concept which means if the request is marked as a core request, it won't be deleted or modified until it's completed successfully, Even if there is a network error, The only option that will be available is retry.
 Also the class produced the concept of VIRequest which means that the request should go to the top of the current requests and excuted first
 */
@objcMembers class ConnectionManager: NSObject {
    
    // Number of allowed requests that will be excuted parallely
    fileprivate var noOfAllowedDownloadThreads: Int = 0
    // Info about the current requests
    fileprivate var downlaodRequests = [ConnectionRequest]()
    fileprivate var activeTasks = [String: URLSessionDataTask]()
    fileprivate var activeRequests = [String: ConnectionRequest]()
    // Shared session
    fileprivate var session: URLSession?
    // Core requests info
    fileprivate var isCurrentlyContainingOnlyCoreRequests: Bool = false

    /**
     Initializing a new static Connection manager that you can use accross the application to make sure that there is only one Connection manager is controlling the requests and data.
     
     - returns: Static object for the Connection Manager.
     */
    static let sharedInstance: ConnectionManager = {
        let sharedInstance = ConnectionManager()
        sharedInstance.validateGlobalVariables()
        return sharedInstance
    }()
    
    /**
     It will validate and intialize the global varaibles that is being used by the connection manager as the sessions and the arrays that controlls the requests.
     */
    private func validateGlobalVariables() {
        isCurrentlyContainingOnlyCoreRequests = false
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        setMaxDownloadThreads(noOfAllowedDownloadThreads)
        if downlaodRequests.isEmpty {
            downlaodRequests = [ConnectionRequest]()
        }
        if activeTasks.isEmpty {
            activeTasks = [String: URLSessionDataTask]()
        }
        if activeRequests.isEmpty {
            activeRequests = [String: ConnectionRequest]()
        }
    }
    
    /**
     Cancel and deleted all the current requests, even the core requests.
     */
    func cancelAllConnections() {
        for req: ConnectionRequest in downlaodRequests {
            req.isRequestCanceled = true
        }
        
        downlaodRequests.removeAll()
        
        for key: String in activeRequests.keys {
            activeRequests[key]?.isRequestCanceled = true
            activeRequests.removeValue(forKey: key)
        }
        for key: String in activeTasks.keys {
            let task: URLSessionDataTask? = activeTasks[key]
            task?.cancel()
        }
    }
    
    /**
     Cancel a request.
     */
    func cancel(_ contentReq: ConnectionRequest) {
        var newDownlaodRequests = [ConnectionRequest]()
        
        for req: ConnectionRequest in downlaodRequests {
            if(req == contentReq){
                req.isRequestCanceled = true
            }else{
                newDownlaodRequests.append(req)
            }
        }
        
        downlaodRequests = newDownlaodRequests
        
        
        for key: String in activeRequests.keys {
            if(activeRequests[key] == contentReq){
                activeRequests[key]?.isRequestCanceled = true
                activeRequests.removeValue(forKey: key)
                let task: URLSessionDataTask? = activeTasks[key]
                task?.cancel()
                activeTasks.removeValue(forKey: key)
                
            }
        }
    }
    
    /**
     Cancel and deleted all the current requests except the core requests.
     */
    func cancelRequestsOtherThanCore() {
        for n in stride(from:downlaodRequests.count-1,to:0,by:-1) {
            let request: ConnectionRequest? = downlaodRequests[n]
            if !(request?.isCoreRequest)! {
                downlaodRequests.remove(at: n)
            }
        }
        for key: String in activeRequests.keys {
            if !(activeRequests[key]?.isCoreRequest)! {
                activeRequests.removeValue(forKey: key)
                let task: URLSessionDataTask? = activeTasks[key]
                task?.cancel()
            }
        }
        if downlaodRequests.count > 0 {
            isCurrentlyContainingOnlyCoreRequests = true
        }
        retryDownloadRequests()
    }

    /**
     Set the maximum number of requests that will be fired parallely.
     If the number of threads is 0 or less it will be set with 1
     - parameter noOfThread: number of requests that will be fired parallely
     */
    func setMaxDownloadThreads(_ noOfThread: Int) {
        if noOfThread <= 0 {
            noOfAllowedDownloadThreads = 100
        }else{
            noOfAllowedDownloadThreads = noOfThread;
        }
    }

    /**
     Add VIRequest "Very Important Request" to the connection manager to be excuted.
     It will be added to the very begining of the current requests to be executed, It will be executed before the current queue.
     Make sure to use it only when you don't care about the current queue of requests and you need this ASAP.
     
     - parameter contentReq: The connection request you need to add to the queue
     */
    func addVIRequest(_ contentReq: ConnectionRequest) {
        downlaodRequests.insert(contentReq, at: 0)
        startRequests()
    }

    /**
     Add request to the connection manager to be excuted.
     It will be added to the end of the current requests to be executed, It will be executed at the end of the current queue.
     Make sure to use it when you care about the current queue of requests and you don't need this ASAP.
     
     - parameter contentReq: The connection request you need to add to the queue
     */
    func add(_ contentReq: ConnectionRequest) {
        downlaodRequests.append(contentReq)
        startRequests()
    }

    /**
     Retry the current download requests.
     It will start loading the current queue of requests
     */
    func retryDownloadRequests() {
        startRequests()
    }

    /**
     Starts the download requests from the current queue.
     It will check for the network first and if it's available it will call the number of allowed requests from the current queue and will execute it.
     Also if the request varaible isShowLoading is true the method will show the loading view
     */
    fileprivate func startRequests() {
        if NetworkManager.sharedInstance.isConnectedToInternet() {
            isCurrentlyContainingOnlyCoreRequests = false
            for _ in Int(activeTasks.count)..<noOfAllowedDownloadThreads {
                if (downlaodRequests.count <= 0){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    continue
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                let request: ConnectionRequest? = downlaodRequests[0]
                downlaodRequests.remove(at: 0)
                if (request?.isShowLoading)! {
                    LoadingView.sharedInstance.show()
                }
                
                let dataTask: URLSessionDataTask? = session?.dataTask(with: (request?.request)!)
                activeTasks["\((dataTask?.taskIdentifier)!)"] = dataTask
                activeRequests["\((dataTask?.taskIdentifier)!)"] = request
                dataTask?.resume()
            }
        }
        else {
            // If there are no connection, it will show network error
            // If there are only core requests the cancel button will be removed
            if isCurrentlyContainingOnlyCoreRequests && downlaodRequests.count > 0 {
                NetworkManager.sharedInstance.showNetworkError(isRetryOptionAvailable: true, isCancelOptionAvailable: false)
            }
            else if downlaodRequests.count > 0 {
                NetworkManager.sharedInstance.showNetworkError(isRetryOptionAvailable: true, isCancelOptionAvailable: true)
            }
        }
    }
}

extension ConnectionManager : URLSessionDataDelegate{
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        // Disable network activity and hide loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let request: ConnectionRequest? = activeRequests["\(task.taskIdentifier)"] ?? nil
        if (request != nil && (request?.isShowLoading)!) {
            LoadingView.sharedInstance.hide()
        }
        
        // Notify the delegate
        if error != nil {
            request?.connectionManagerDidRecieveError(error)
        }
        else {
            request?.connectionManagerDidCompleteLoadingData()
        }
        
        // Remove the request and start downloading the new requests
        activeTasks.removeValue(forKey: "\(task.taskIdentifier)")
        activeRequests.removeValue(forKey: "\(task.taskIdentifier)")
        startRequests()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // Append data to the request result if there are no errors
        let request: ConnectionRequest? = activeRequests["\(dataTask.taskIdentifier)"]
        request?.data?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        let request: ConnectionRequest? = activeRequests["\(task.taskIdentifier)"]
        if(request?.isUploadRequest)!{
            request?.connectionManagerDidUploadWithProgress(uploadProgress)
        }
    }
}
