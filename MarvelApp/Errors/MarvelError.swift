//
//  APIError.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

enum MarvelError: Error {
    case returnedError(Error)
    case decodingError(Error)
    case unknown
    case errorCode(Int)
    case invalidURL
    case dataReturnedNil
    case customError(String)
}

extension MarvelError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError(let decodingError):
            return decodingError.localizedDescription
        case .unknown:
            return "The error is unknown"
        case .errorCode(let status):
            return "\(status) - Something went wrong"
        case .invalidURL:
            return "Invalid url"
        case .returnedError(let error):
            return error.localizedDescription
        case .dataReturnedNil:
            return "Returned nil data"
        case .customError(let error):
            return error
        }
    }
}

extension MarvelError: Equatable {
    public static func == (lhs: MarvelError, rhs: MarvelError) -> Bool {
        switch (lhs, rhs) {
        case (.returnedError, .returnedError), (.dataReturnedNil, .dataReturnedNil), (.unknown, .unknown), (.invalidURL, .invalidURL):
            return true
        case (.decodingError(let leftError), .decodingError(let rightError)):
            return leftError.localizedDescription == rightError.localizedDescription
        case (.errorCode(let leftStatusCode), .errorCode(let rightStatusCode)):
            return leftStatusCode == rightStatusCode
        case (.customError(let leftError), .customError(let rightError)):
            return leftError == rightError
        default:
            return false
        }
    }
}
