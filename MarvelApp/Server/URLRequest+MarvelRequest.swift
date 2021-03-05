//
//  URLRequest+.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

extension URLRequest {
    init?(endpoint: MarvelEndpoint, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        var components = URLComponents()
        components.scheme = MarvelAPI.scheme
        components.host = MarvelAPI.host
        components.path = MarvelAPI.version + endpoint.path
        let rawHash = "\(timestamp)" + MarvelAPI.publicKey + MarvelAPI.privateKey
        components.queryItems = [
            URLQueryItem(name: "ts", value: "\(timestamp)"),
            URLQueryItem(name: "apikey", value: MarvelAPI.publicKey),
            URLQueryItem(name: "hash", value: rawHash.MD5)
        ]
        guard let url = components.url else {
            return nil
        }
        self.init(url: url)
    }
}
