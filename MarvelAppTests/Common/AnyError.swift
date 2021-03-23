//
//  AnyError.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import Foundation

enum AnyError: Error {
    case any
}

extension AnyError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .any:
            return "description"
        }
    }
}
