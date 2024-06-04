//
//  HerosCoordinator.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI
import Stinsen

public final class HerosCoordinator: NavigationCoordinatable {
    public let stack = NavigationStack(initial: \HerosCoordinator.start)
    
    @Root public var start = makeStart
    @Route(.push) public var heroDetails = makeHeroDetails
    
    public init() {}
    
    func makeStart() -> some View {
        HerosOverviewView(viewModel: HerosOverviewViewModel())
    }
    
    func makeHeroDetails(id: Int) -> some View {
        HeroDetailsView(viewModel: HeroDetailsViewModel(heroId: id))
    }
}

