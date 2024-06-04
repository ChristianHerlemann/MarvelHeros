//
//  RedactableModifier.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 04.06.24.
//

import SwiftUI

struct RedactableModifier: ViewModifier {
    @Environment(\.showPlaceholder) var showPlaceholder
    
    let lenght: Int?
    
    var placeholderText: String? {
        guard let lenght else { return nil }
        return String(repeating: " ", count: lenght)
    }
    
    func body(content: Content) -> some View {
        if showPlaceholder, let placeholderText {
            Text(placeholderText)
                .redacted(reason: .placeholder)
        } else {
            content
                .redacted(reason: showPlaceholder ? .placeholder : [])
        }
    }
}

extension View {
    func redactable(lenght: Int? = nil) -> some View {
        self.modifier(RedactableModifier(lenght: lenght))
    }
}

struct ShowPlaceholderKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var showPlaceholder: Bool {
        get { self[ShowPlaceholderKey.self] }
        set { self[ShowPlaceholderKey.self] = newValue }
    }
}
