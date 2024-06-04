//
//  APIOperation+Configuration.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation
import Networking

public extension APIOperation {
    var baseURL: URL {
        return AppContext.shared.configuration.apiServiceURL
    }
    
    internal var header: [HTTPHeader: String] {
        [
            .deviceType: "phone",
            .deviceOS: "ios"
        ]
    }
    
    // MARK: parameters
    var parameters: [String: String] {
        let timestamp = Date().timeIntervalSince1970
        let apiKey = "387d10570007caebb0fdd07f62508c3b"
        let privateKey = "20a8aaeeef8ef5068443170bd0aa1ec7df87bab6"
        
        return [
            "ts": "\(timestamp)",
            "apikey": apiKey,
            "hash": "\(timestamp)\(privateKey)\(apiKey)".md5
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                             resolvingAgainstBaseURL: false) else {
            throw URLConvertibleError.urlComponentError
        }
        
        components.queryItems = parameters.map { name, value in
            return URLQueryItem(name: name, value: value)
        }
        
        guard let url = components.url else {
            throw URLConvertibleError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}

enum HTTPHeader: String {
    case deviceType = "X-DEVICE-TYPE"
    case deviceOS = "X-DEVICE-OS"
}

public enum URLConvertibleError: Error, Equatable {
    case urlComponentError
    case invalidUrl
}
