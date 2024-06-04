//
//  APIClientError.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

// MARK: APIClientError
public enum APIClientError: Error, Equatable {
    case invalidRequest
    case invalidResponse
    case noResponse // Codes 503, 504
    case notFound // Code 404
    case notAuthenticated // Code 401
    case underlyingError(Error)
    case other
    
    public static func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, .invalidRequest),
            (.invalidResponse, .invalidResponse),
            (.noResponse, .noResponse),
            (.notFound, .notFound),
            (.underlyingError, .underlyingError),
            (.other, .other):
            return true
        default:
            return false
        }
    }
}
