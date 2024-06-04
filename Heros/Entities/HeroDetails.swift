//
//  HeroDetails.swift
//  Heros
//
//  Created by Chris Herlemann on 15.05.22.
//

struct HeroDetails: Equatable, Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
    var imageURL: String {
        "\(thumbnail.path).\(thumbnail.fileExtension)"
    }
    
    static func == (lhs: HeroDetails, rhs: HeroDetails) -> Bool {
        lhs.id == rhs.id
    }
}
