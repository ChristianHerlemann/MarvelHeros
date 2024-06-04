//
//  HeroDetailsViewModel.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import Foundation
import Networking
import Shared

class HeroDetailsViewModel: Requestable, ObservableObject {
    
    private let apiClient: APIClientProtocol
    let requestState = RequestState<HeroDetails>()
    
    private let heroId: Int
    
    init(heroId: Int, apiClient: APIClientProtocol = AppContext.shared.apiClient) {
        self.heroId = heroId
        self.apiClient = apiClient
    }
    
    func request() async throws -> HeroDetails {
        let results = try await apiClient.request(DataWrapper<[HeroDetails]>.self,
                                                  operation: HerosOperationRouter.details(id: heroId)).data.results
        
        guard let hero = results.first else {
            throw RequestableError.noEntries
        }
        
        return hero
    }
    
    func addBookmark(hero id: Int) {
        
    }
}
