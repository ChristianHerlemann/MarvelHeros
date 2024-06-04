//
//  Requestable+OnError.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Networking

public extension Requestable {
    func onError(error: Error) {
        // Could log to Crashlytics
        print(error.localizedDescription)
    }
}
