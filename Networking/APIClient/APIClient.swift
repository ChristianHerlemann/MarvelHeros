//
//  APIClient.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation

// MARK: APIClient
public protocol APIClientProtocol {
    func request<Model: Decodable>(_ type: Model.Type, operation: some APIOperation) async throws -> Model
    
    func downloadImage(url imageURL: String) async throws -> Data
}

public class APIClient: APIClientProtocol {
    public let session: URLSession
    
    public init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
    }
    
    public func request<Model: Decodable>(_ type: Model.Type, operation: some APIOperation) async throws -> Model {
        guard let urlRequest = try? operation.asURLRequest() else {
            throw APIClientError.invalidRequest
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                throw APIClientError.invalidResponse
            }
            
            switch response.statusCode {
            case 200:
                return try JSONDecoder().decode(Model.self, from: data)
            case 400:
                throw APIClientError.invalidRequest
            case 401:
                throw APIClientError.notAuthenticated
            case 404:
                throw APIClientError.notFound
            case 503, 504:
                throw APIClientError.noResponse
            default:
                throw APIClientError.other
            }
        } catch {
            throw APIClientError.underlyingError(error)
        }
    }
    
    public func downloadImage(url imageURL: String) async throws -> Data {
        guard var comps = URLComponents(string: imageURL) else {
            throw APIClientError.invalidRequest
        }
        
        comps.scheme = "https"
        
        guard let imageURL = comps.url else {
            throw APIClientError.invalidRequest
        }
        
        let urlRequest = URLRequest(url: imageURL,
                                    cachePolicy: .returnCacheDataElseLoad)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                throw APIClientError.invalidResponse
            }
            
            switch response.statusCode {
            case 200:
                return data
            case 400:
                throw APIClientError.invalidRequest
            case 401:
                throw APIClientError.notAuthenticated
            case 404:
                throw APIClientError.notFound
            case 503, 504:
                throw APIClientError.noResponse
            default:
                throw APIClientError.other
            }
        } catch {
            throw APIClientError.underlyingError(error)
        }
    }
}
