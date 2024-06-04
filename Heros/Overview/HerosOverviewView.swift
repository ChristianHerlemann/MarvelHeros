//
//  HerosOverviewView.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import SwiftUI
import Networking
import Shared

struct HerosOverviewView: View {
    
    @StateObject var viewModel: HerosOverviewViewModel
    
    var body: some View {
        RequestingList(requestable: viewModel) { hero in
            Button(action: {viewModel.showHero(id: hero.id)}) {
                heroListRow(hero)
            }
        }
        .router(for: HerosCoordinator.self, apply: { viewModel.router = $0 })
    }
    
    func heroListRow(_ hero: Hero) -> some View {
        HStack(spacing: 16) {
            HeroImageView(viewModel: HeroImageViewModel(url: hero.imageURL))
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .clipped()
                .frame(width: 50, height: 50, alignment: .center)
                .redactable()
            
            Text(hero.name)
                .redactable(lenght: 22)
        }
    }
}

struct HerosOverviewView_Previews: PreviewProvider {
    
    static var viewModel: HerosOverviewViewModel = {
        let model = HerosOverviewViewModel()
        model.requestState.itemsState = .loaded(Hero.examples)
        return model
    }()
    
    static var previews: some View {
        HerosOverviewView(viewModel: viewModel)
            .previewDisplayName("Loaded")
        
        HerosOverviewView(viewModel: viewModel)
            .previewDisplayName("Loading")
            .environment(\.showPlaceholder, true)

    }
}

