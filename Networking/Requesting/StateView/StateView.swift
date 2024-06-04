//
//  StateView.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI

// MARK: StateView
struct StateView<Content: View, Success>: View {
    let state: StateViewState<Success>
    let content: (Success?) -> Content
    
    // MARK: body
    var body: some View {
        VStack {
            switch state {
            case .loaded(let data), .refreshing(let data):
                contentView(data)
            case .loading, .failed:
                contentView(nil)
            }
        }
    }
    
    // MARK: Content View
    func contentView(_ data: Success?) -> some View {
        content(data)
    }
}

// MARK: Preview
struct StateView_Previews: PreviewProvider {
    struct StateViewPreviewError: Error {
        var title: String { "An error occured" }
        var message: String { "Please try again later " }
        var debugText: String? { "Decoding error"}
    }
    
    static func content(value: String?) -> some View {
        Text(value ?? "-")
    }
    
    static var previews: some View {
        Group {
            StateView(state: StateViewState<String>.loading, content: content)
                .previewDisplayName("Loading")
            StateView(state: StateViewState<String>.loaded("Test"), content: content)
                .previewDisplayName("Loaded")
            StateView(state: StateViewState<String>.refreshing("Test"), content: content)
                .previewDisplayName("Refreshing")
            StateView(state: StateViewState<String>.failed(.underlying(StateViewPreviewError())), content: content)
                .previewDisplayName("Failed")
        }
    }
}
