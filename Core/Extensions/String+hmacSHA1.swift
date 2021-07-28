//
//  String+hmacSHA1.swift
//  TwiLive
//
//  Created by user on 2019/09/14.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    public func hmacSHA1(key: String) -> String? {
        let hmac = HMAC<Insecure.SHA1>.authenticationCode(
            for: self.data(using: .utf8)!,
            using: .init(data: key.data(using: .utf8)!)
        )
        return Data(hmac).base64EncodedString()
    }
}
