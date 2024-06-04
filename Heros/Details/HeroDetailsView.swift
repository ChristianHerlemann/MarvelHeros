//
//  HeroDetailsView.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import SwiftUI
import Networking
import Shared

struct HeroDetailsView: View {
    @StateObject var viewModel: HeroDetailsViewModel
    
    var body: some View {
        Requesting(requestable: viewModel) { hero in
            if let hero {
                heroDetailsView(hero)
                
                Spacer()
                
                Button("Add Bookmark", action: { viewModel.addBookmark(hero: hero.id) })
                    .buttonStyle(TileButtonStyle())
                    .padding(.vertical)
            } else {
                Text("No Details found")
            }
        }
    }
    
    func heroDetailsView(_ hero: HeroDetails) -> some View {
        VStack {
            HeroImageView(viewModel: HeroImageViewModel(url: hero.imageURL))
                .frame(height: 200)
            
            Group {
                Text(hero.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(hero.description)
            }
            .padding(.horizontal, 16)
        }
    }
}

struct HeroDetailsView_Previews: PreviewProvider {
    static var viewModel: HeroDetailsViewModel = {
        let model = HeroDetailsViewModel(heroId: HeroDetails.example.id)
        model.requestState.itemsState = .loaded(HeroDetails.example)
        return model
    }()
    
    static var previews: some View {
        HeroDetailsView(viewModel: viewModel)
    }
}
