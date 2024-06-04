//
//  HeroImageView.swift
//  Heros
//
//  Created by Chris Herlemann on 15.05.22.
//

import SwiftUI
import Networking

// MARK: HeroImageView
struct HeroImageView: View {
    @StateObject var viewModel: HeroImageViewModel
    
    var body: some View {
        Requesting(requestable: viewModel) { heroImage in
            
            (heroImage??.image ?? Image(systemName: "photo"))
                .resizable()
        }
    }
}

struct HeroImageView_Previews: PreviewProvider {
    static var previews: some View {
        HeroImageView(viewModel: HeroImageViewModel(url: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16"))
    }
}
