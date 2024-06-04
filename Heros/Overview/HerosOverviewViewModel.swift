//
//  HerosOverviewViewModel.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation
import Networking
import Shared

class HerosOverviewViewModel: Requestable, ObservableObject {
    var router: HerosCoordinator.Router!
    
    let apiClient: APIClientProtocol
    let requestState = RequestState<[Hero]>()
    
    init(apiClient: APIClientProtocol = AppContext.shared.apiClient) {
        self.apiClient = apiClient
    }
    
    func request() async throws -> [Hero] {
        try await self.apiClient.request(DataWrapper<[Hero]>.self,
                                         operation: HerosOperationRouter.overview).data.results
    }
    
    func showHero(id: Int) {
        router.route(to: \.heroDetails, id)
    }
}
