//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

struct MarvelAPI {
    static let publicKey = "a461a1c77ed0b74733071e8d794f429d"
    static let privateKey = "ad6d68b70aa23baef666b4c34c8a4478c2fb2c31"
    static let scheme = "https"
    static let host = "gateway.marvel.com"
    static let version = "/v1/public"
}

enum MarvelEndpoint {
    case characters
    
    var path: String {
        switch self {
        case .characters:
            return "/characters"
        }
    }
}
