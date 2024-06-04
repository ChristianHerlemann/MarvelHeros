//
//  MainCoordinator.swift
//  Marvel
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI
import Stinsen
import Heros

final class MainCoordinator: TabCoordinatable {
    
    var child = TabChild(
        startingItems: [
            \MainCoordinator.heros
        ]
    )
    
    @Route(tabItem: makeHerosTab) var heros = makeHeros
    
    func makeHeros() -> NavigationViewCoordinator<HerosCoordinator> {
        NavigationViewCoordinator(HerosCoordinator())
    }
    
    @ViewBuilder func makeHerosTab(isActive: Bool) -> some View {
        Image(systemName: "star")
            .renderingMode(.template)
        
        Text("Helden")
    }
    
//    func customize(_ view: AnyView) -> some View {
//        view
//            .applyDefaultTabBarStyle()
//    }
}
