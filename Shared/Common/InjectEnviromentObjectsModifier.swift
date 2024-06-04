//
//  InjectEnviromentObjectsModifier.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import SwiftUI
import Stinsen

// Check if running in preview to prevent common crash when accessing missing environment object
private let isRunningForPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"

struct InjectEnviromentObject<Object: ObservableObject>: ViewModifier {
    @EnvironmentObject var object: Object
    
    var apply: (Object) -> Void
    
    func body(content: Self.Content) -> some View {
        
        if !isRunningForPreview {
            apply(object)
        }
        
        return AnyView(content)
    }
    
}

extension View {
    func enviromentObject<Object: ObservableObject>(type: Object.Type, apply: @escaping (Object) -> Void) -> some View {
        ModifiedContent(content: self, modifier: InjectEnviromentObject(apply: apply))
    }
    
    public func router<Coordinator: NavigationCoordinatable>(for router: Coordinator.Type, apply: @escaping (Coordinator.Router) -> Void) -> some View {
        self.enviromentObject(type: Coordinator.Router.self, apply: apply)
    }
}
