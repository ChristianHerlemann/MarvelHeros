//
//  APIOperation.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation

// MARK: APIOperation
public protocol APIOperation {
    
    var path: String { get }
    var parameters: [String: String] { get }
    
    func asURLRequest() throws -> URLRequest
}
