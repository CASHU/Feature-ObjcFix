//
//  NetworkManager.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/24/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation
import UIKit

/**
 Network Manager is a static singelton class which is responsible for providing the information about the current network state.
 PLEASE use the shared instance to make sure that the application network will be handled by only one static manager.
 You can start listining on network change notifications.
 */
@objcMembers class NetworkManager: NSObject {
    // Helper class for checking for the network status
    private var internetReachability: Reachability?

    /**
     Initializing a new static Network manager that you can use accross the application to make sure that there is only one Network manager is controlling the network.
     
     - returns: Static object for the Network Manager.
     */
    static let sharedInstance: NetworkManager = {
        let sharedInstance = NetworkManager()
        return sharedInstance
    }()
    
    override init() {
        super.init()
        
        // Intialize the data and starting the notifier
        internetReachability = Reachability()
        do {
            try internetReachability?.startNotifier()
        }catch{
            print("Failed to start the Notifier")
        }
    }

    /**
     Will return true or false based on if you are connected to the internet either through the wifi or data or you are not connected.

     - returns: True or false, either you are connected or not.
     */
    func isConnectedToInternet() -> Bool {
        let internetStatus: Reachability.NetworkStatus = (internetReachability?.currentReachabilityStatus)!
        switch internetStatus {
            case .notReachable:
                return false
            case .reachableViaWiFi:
                return true
            case .reachableViaWWAN:
                return true
        }
    }

    /**
     This method is responsible for showing network error over the whole application.
     You can give it a retry option which will go and retry the latest request and cancel option which will dismiss the alert or neither this or that and it will show Ok option which will dismiss also the alert.
     Hint: You can force the user to always retry the request by passing the retry option with true and the cancel with false
     
     - parameter isRetryOptionAvailable: Is the alert will be shown with a retry option
     - parameter isCancelOptionAvailable: Is the alert will be shown with a cancel option
     */
    func showNetworkError(isRetryOptionAvailable: Bool, isCancelOptionAvailable: Bool) {
//        let alert: UIAlertController = UIAlertController(title: LocalizationManager.sharedInstance.getTranslationForKey("NetworkError"), message: LocalizationManager.sharedInstance.getTranslationForKey("CheckNetworkError"), preferredStyle: .alert)
//        if isCancelOptionAvailable{
//            alert.addAction(UIAlertAction(title: LocalizationManager.sharedInstance.getTranslationForKey("Cancel"), style: .cancel, handler:{ (alertAction) in
//                alert.dismiss(animated: true, completion: nil);
//            }));
//
//        }
//
//        if isRetryOptionAvailable {
//            alert.addAction(UIAlertAction(title: LocalizationManager.sharedInstance.getTranslationForKey("Retry"), style: .cancel, handler:{ (alertAction) in
//                alert.dismiss(animated: true, completion: nil);
//            }));
//        }
//
//        if !isRetryOptionAvailable && !isCancelOptionAvailable {
//            alert.addAction(UIAlertAction(title: LocalizationManager.sharedInstance.getTranslationForKey("Ok"), style: .cancel, handler:{ (alertAction) in
//                alert.dismiss(animated: true, completion: nil);
//            }));
//        }
//
//        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil);
    }
}
