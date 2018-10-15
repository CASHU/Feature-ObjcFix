//
//  ImageDataProvider.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/20/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation
import UIKit

/**
 Image Data Provider delegate that will be notified when the image is loaded successfully or failed.
 */
protocol ImageDataProviderDelegate: NSObjectProtocol {
    /**
     Notify the delegate that the image did complete successfully.
     It will pass the image from the response.
     
     - parameter image: Loaded image
     */
    func didLoadImage(_ image: UIImage, specialKey : String)
    /**
     Notify the delegate that the image did failed while loading
     */
    func didFailLoadingImage()
}

/**
 Image Data Provider is a helper class for loding images.
 It uses the connection request to handle the downloading of the image
 All what you need is to pass the url for the image.
 
 Hint: Please keep the ImageDataProvider object as long as the object is alive. as the delegate is intialized as weak
 */
@objcMembers class ImageDataProvider: NSObject{
    // Delegate to be notified when the loading isDone
    fileprivate weak var delegate: ImageDataProviderDelegate?
    
    // Is image provider currently downloading the required image or not
    var isDownloading = false
    
    // Is image provider currently downloading the required image or not
    var specialKey = ""

    init(aDelegate: ImageDataProviderDelegate?) {
        super.init()
        
        // setup the delegate
        delegate = aDelegate
    
    }

    /**
     Load image with the provided URL.
     Use the Complete URL for this service as this doesn't use the service URL from the configurations manager
     
     - parameter url: The complete URL as a String for the Image
     */
    func loadImageWithURL(_ url: String) {
        let cr = ConnectionRequest(delegate: self, requestURL: url, requestMethod: ConnectionRequestHTTPMethod.get, parameters: nil, isShowLoading: false, aRequestID: .LoadImageGeneralOperationID, isACoreRequest: false)
        cr.isCompleteURL = true
        isDownloading = true
        cr.initiateRequest()
    }    
}

extension ImageDataProvider : ConnectionRequestDelegate{
    func requestDidCompleteLoading(request: ConnectionRequest, data: Data) {
        let img = UIImage(data: data)
        if delegate != nil {
            isDownloading = false
            if(img != nil){
                delegate?.didLoadImage(img!, specialKey: specialKey)
            }
        }
    }
    
    func requestDidRecieveError(request: ConnectionRequest, error: Error?) {
        if delegate != nil {
            isDownloading = false
            delegate?.didFailLoadingImage()
        }
    }
    
    func requestDidUploadWithProgress(_ uploadProgress: Float) {
        
    }
}
