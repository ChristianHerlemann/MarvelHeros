//
//  MarvelApp.swift
//  Marvel
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI
import Stinsen

@main
struct MarvelApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainCoordinator()
                .view()
        }
    }
}
