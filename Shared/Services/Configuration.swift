//
//  Configuration.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation

protocol Configuration {
    var apiServiceURL: URL { get }
}

struct MixInConfiguration: Configuration {
    var apiServiceURL: URL { URL(string: "https://gateway.marvel.com/v1/public/")! }
}
