//
//  BlowfishWrapper.swift
//  Cashu
//
//  Created by Ahmad Naser on 2/5/17.
//  Copyright © 2017 Cashu. All rights reserved.
//

import Foundation
import SCrypto

extension String {
    var blowfish: String? {
        var encryptedPass : String? = self
        do {
            let encodedString = self.data(using: .utf8)
            encryptedPass = try encodedString?.encrypt(
                .blowfish,
                options: .PKCS7Padding,
                key: BackEndConfigurations.testingEncKey().data(using: .utf8)!,
                iv: BackEndConfigurations.testingEncIV().data(using: .utf8)).base64EncodedString()
            
        } catch {
            // Handle error if happened.
        }
        return encryptedPass
    }
    
    var blowfishStore: String? {
        var encryptedValue : String? = self
        do {
            let encodedString = self.data(using: .utf8)
            encryptedValue = try encodedString?.encrypt(
                .blowfish ,
                options: .init() ,
                key: BackEndConfigurations.productionEncKey().data(using: .utf8)!,
                iv: BackEndConfigurations.productionEncIV().data(using: .utf8)).base64EncodedString()
        } catch {
            // Handle error if happened.
        }
        return encryptedValue
    }
    
    var md5 : String? {
        return self.MD5()
    }
}
