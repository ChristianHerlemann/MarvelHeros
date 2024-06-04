//
//  Requestable.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

import Foundation
import Combine

// MARK: Requestable
public protocol Requestable: AnyObject {
    associatedtype ResponseModel: Equatable, Decodable
    
    var requestState: RequestState<ResponseModel> { get }
    
    func request() async throws -> ResponseModel
    
    func onRequestStateChanged()
    
    func onError(error: Error)
}

// MARK: extension Requestable
public extension Requestable {

    var isRequesting: Bool {
        switch requestState.itemsState {
        case .loading: return requestState.loadingTask != nil
        case .refreshing: return true
        case .loaded, .failed: return false
        }
    }
    
    var isRefreshing: Bool {
        switch requestState.itemsState {
        case .refreshing: return true
        case .loaded, .loading, .failed: return false
        }
    }
    
    var loadedData: ResponseModel? {
        switch requestState.itemsState {
        case .loaded(let data), .refreshing(let data):
            return data
        case .failed, .loading:
            return nil
        }
    }
    
    var maxRetries: Int { 3 }
    
    // MARK: load
    func load() {
        Task { [weak self] in
            guard let self else { return }
            _ = await self.load()
        }
    }
    
    @MainActor
    @discardableResult
    func load() async -> ResponseModel? {
        guard !isRequesting else {
            return try? await requestState.loadingTask?.value
        }
        
        requestState.loadingTask?.cancel()
        self.setRequestState(.loading)
        
        do {
            self.requestState.loadingTask = Task {
                do {
                    let loadedData = try await self.loadData()
                    return loadedData
                } catch {
                    throw error
                }
            }
            
            return try await requestState.loadingTask?.value
        } catch {
            self.setRequestState(.failed(.underlying(error)))
            onError(error: error)
            return nil
        }
    }
    
    // MARK: refresh
    func refresh() {
        Task { [weak self] in
            guard let self else { return }
            _ = await self.refresh()
        }
    }
    
    @MainActor
    @discardableResult
    func refresh() async -> ResponseModel? {
        guard !isRequesting else {
            return try? await requestState.loadingTask?.value
        }
        
        guard let data = loadedData else {
            return await load()
        }
        
        requestState.loadingTask?.cancel()
        self.setRequestState(.refreshing(data))
        
        do {
            await MainActor.run {
                requestState.loadingTask = Task {
                    do {
                        let loadedData = try await self.loadData()
                        return loadedData
                    } catch {
                        throw error
                    }
                }
            }
            
            return try await requestState.loadingTask?.value
        } catch {
            self.setRequestState(.failed(.underlying(error)))
            onError(error: error)
            return nil
        }
    }
    
    @MainActor
    private func setRequestState(_ newState: StateViewState<ResponseModel>) {
        guard requestState.itemsState != newState else {
            return
        }
        
        requestState.itemsState = newState
        onRequestStateChanged()
    }
    
    @MainActor
    func reset() {
        self.requestState.reset()
        onRequestStateChanged()
    }
}

// MARK: extension Requestable
extension Requestable {
    // MARK: request
    private func loadData() async throws -> ResponseModel {
        let data = try await request()
        await self.setRequestState(.loaded(data))
        
        return data
    }
}

// MARK: extension Requestable
public extension Requestable where Self: ObservableObject,
                                   Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    
    func onRequestStateChanged() {
        objectWillChange.send()
    }
}
