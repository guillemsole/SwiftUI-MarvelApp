//
//  ResultState.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

enum ResultState<T> {
    case loading
    case success(T)
    case failed(MarvelError)
}

extension ResultState: Equatable {
    static func == (lhs: ResultState<T>, rhs: ResultState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.success, .success), (.failed, .failed):
            return true
        default:
            return false
        }
    }
    
    
}
