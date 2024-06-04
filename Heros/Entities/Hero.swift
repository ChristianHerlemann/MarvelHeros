//
//  Hero.swift
//  Heros
//
//  Created by Chris Herlemann on 14.05.22.
//

import Foundation

// MARK: Hero
struct Hero: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    
    var imageURL: String {
        "\(thumbnail.path).\(thumbnail.fileExtension)"
    }
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.id == rhs.id
    }
}

struct Thumbnail: Decodable {
    let path: String
    let fileExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
