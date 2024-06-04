//
//  RequestingList.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI

public struct RequestingList<Model: Requestable & ObservableObject, Content: View>: View
where Model.ResponseModel: RandomAccessCollection, Model.ResponseModel.Element: Identifiable {
    
    let viewModel: Model
    var content: (Model.ResponseModel.Element) -> Content
    
    public init(requestable: Model,
         content: @escaping (Model.ResponseModel.Element) -> Content) {
        self.viewModel = requestable
        self.content = content
    }
    
    public var body: some View {
        Requesting(requestable: viewModel) { items in
            if let items {
                List(items) { item in
                    content(item)
                }
                .refreshable { viewModel.refresh() }
                .listStyle(.plain)
            } else {
             
                // TODO: Loading Placeholder
                Spacer()
            }
        }
    }
}
