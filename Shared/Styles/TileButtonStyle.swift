//
//  TileButtonStyle.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import SwiftUI

public struct TileButtonStyle: ButtonStyle {
    
    var forgroundColor: Color
    var backgroundColor: Color
    
    public init(forgroundColor: Color = .white,
                backgroundColor: Color = .blue) {
        self.forgroundColor = forgroundColor
        self.backgroundColor = backgroundColor
    }
    
    public func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        HStack {
            configuration.label
                .font(.body)
                .foregroundColor(forgroundColor)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        }
        .background(backgroundColor)
        .opacity(configuration.isPressed ? 0.7 : 1)
        .cornerRadius(3.0)
        .padding(.horizontal)
    }
}

struct TileButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Hallo")
        }.buttonStyle(TileButtonStyle())
    }
}
