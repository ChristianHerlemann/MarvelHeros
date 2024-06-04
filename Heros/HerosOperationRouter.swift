//
//  HerosOperationRouter.swift
//  Heros
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Networking
import Shared

// MARK: HerosOperationRouter
enum HerosOperationRouter: APIOperation {
    case overview
    case details(id: Int)
    
    // MARK: path
    var path: String {
        switch self {
        case .overview:
            return "characters"
        case .details(let id):
            return "characters/\(id)"
        }
    }
}
