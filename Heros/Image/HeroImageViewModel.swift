//
//  HeroImageViewModel.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import Foundation
import SwiftUI
import Networking
import Shared

class HeroImageViewModel: Requestable, ObservableObject {
    struct HeroImage: Equatable, Decodable {
        let url: String
        let image: Image?
        
        init(url: String, image: Image?) {
            self.url = url
            self.image = image
        }
        
        init(from decoder: Decoder) throws {
            fatalError()
        }
    }
    
    let apiClient: APIClientProtocol
    let requestState = RequestState<HeroImage?>()
    
    private let url: String
    
    init(url: String, apiClient: APIClientProtocol = AppContext.shared.apiClient) {
        self.url = url
        self.apiClient = apiClient
    }
    
    func request() async throws -> HeroImage? {
        let imageData = try await apiClient.downloadImage(url: url)
        return HeroImage(url: url,
                         image: UIImage(data: imageData)?.swiftUI)
    }
}
