//
//  String+MD5.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
