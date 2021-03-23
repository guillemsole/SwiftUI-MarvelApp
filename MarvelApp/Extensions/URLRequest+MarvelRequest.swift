//
//  URLRequest+.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

fileprivate struct MarvelAPI {
    static let publicKey = "a461a1c77ed0b74733071e8d794f429d"
    static let privateKey = "ad6d68b70aa23baef666b4c34c8a4478c2fb2c31"
    static let scheme = "https"
    static let host = "gateway.marvel.com"
    static let version = "/v1/public"
}

enum MarvelEndpoint {
    case getCharacters
    case getCharacterById(id: String)
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/characters"
        case .getCharacterById(let id):
            return "/characters/" + id
        }
    }
}


extension URLRequest {
    init?(endpoint: MarvelEndpoint, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        var components = URLComponents()
        components.scheme = MarvelAPI.scheme
        components.host = MarvelAPI.host
        components.path = MarvelAPI.version + endpoint.path
        let rawHash = timestamp.description + MarvelAPI.privateKey + MarvelAPI.publicKey
        components.queryItems = [
            URLQueryItem(name: "ts", value: timestamp.description),
            URLQueryItem(name: "apikey", value: MarvelAPI.publicKey),
            URLQueryItem(name: "hash", value: rawHash.MD5)
        ]
        guard let url = components.url else {
            return nil
        }
        self.init(url: url)
    }
}
