//
//  APIError.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

enum MarvelError: Error {
    case decodingError
    case unknown
    case errorCode(Int)
}

extension MarvelError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .unknown:
            return "The error is unknown"
        case .errorCode(let status):
            return "\(status) - Something went wrong"
        }
    }
}
