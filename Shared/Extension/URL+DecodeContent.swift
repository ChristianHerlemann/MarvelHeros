//
//  URL+DecodeContent.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 30.07.23.
//

import Foundation

public extension URL {
    func decodeContent<Model: Decodable>(_ type: Model.Type) throws -> Model {
        let data = try Data(contentsOf: self)
        return try JSONDecoder().decode(Model.self, from: data)
    }
}
