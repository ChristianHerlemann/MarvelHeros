//
//  UIKit+SwiftUI.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import UIKit
import SwiftUI

public extension UIImage {
    var swiftUI: Image { Image(uiImage: self) }
}

public extension UIColor {
    var swiftUI: Color { Color(self) }
}
