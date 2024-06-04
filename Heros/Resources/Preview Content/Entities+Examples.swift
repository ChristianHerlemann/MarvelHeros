//
//  Entities+Examples.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import Shared

extension Hero {
    static var examples: [Hero] {
        // swiftlint:disable force_try
        try! R.file.charactersJson.url()!.decodeContent(DataWrapper<[Hero]>.self).data.results
    }
    
    static var example: Hero {
        // swiftlint:disable force_try
        examples.first!
    }
}

extension HeroDetails {
    static var example: HeroDetails {
        // swiftlint:disable force_try
        try! R.file.characterDetailsJson.url()!.decodeContent(DataWrapper<[HeroDetails]>.self).data.results.first!
    }
}
