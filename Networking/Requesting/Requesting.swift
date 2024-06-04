//
//  Requesting.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI

public struct Requesting<Model: Requestable & ObservableObject, Content: View>: View {
    var isRunningUnitTests: Bool {
#if TEST
        return true
#else
        return false
#endif
    }
    
    private var isRunningForPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    
    let model: Model
    @ObservedObject var requestState: RequestState<Model.ResponseModel>
    
    var content: (Model.ResponseModel?) -> Content
    
    public init(requestable: Model, @ViewBuilder content: @escaping (Model.ResponseModel?) -> Content) {
        self.model = requestable
        self.requestState = requestable.requestState
        self.content = content
    }
    
    public var body: some View {
        StateView(state: requestState.itemsState) { items in
            content(items)
        }
        .onAppear {
            guard !isRunningUnitTests,
                  !isRunningForPreview else { return }
            model.refresh()
        }
    }
}
