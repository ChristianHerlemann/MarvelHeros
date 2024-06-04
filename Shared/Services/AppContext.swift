//
//  AppContext.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Networking

public class AppContext {
    public static let shared = AppContext()
    
    public lazy var apiClient: APIClientProtocol = APIClient()
    lazy var configuration: Configuration = MixInConfiguration()
}
