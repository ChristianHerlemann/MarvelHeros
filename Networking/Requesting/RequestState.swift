//
//  RequestState.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation

// MARK: RequestState
public class RequestState<ResponeModel>: ObservableObject {
    
    var loadingTask: Task<ResponeModel, Error>?
    @Published public var itemsState = StateViewState<ResponeModel>.loading
    
    public init() {}
    
    public func reset() {
        self.loadingTask = nil
        self.itemsState = .loading
    }
}
