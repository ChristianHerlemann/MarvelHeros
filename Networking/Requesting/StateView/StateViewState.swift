//
//  StateViewState.swift
//  Networking
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

// MARK: StateViewState
public enum StateViewState<Success> {
    case loading
    case refreshing(Success)
    case loaded(Success)
    case failed(StateViewError)
}

extension StateViewState: Equatable where Success: Equatable {
    public static func == (lhs: StateViewState<Success>, rhs: StateViewState<Success>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.loaded(let lhsData), .loaded(let rhsData)),
            (.refreshing(let lhsData), .refreshing(let rhsData)): return lhsData == rhsData
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default: return false
        }
    }
}
